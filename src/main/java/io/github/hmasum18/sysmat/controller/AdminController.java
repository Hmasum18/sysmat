package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.config.WebConfiguration;
import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    CategoryRepository categoryRepository;

    @GetMapping("/category/add")
    public String addCategory(ModelMap modelMap){
        modelMap.put("category", new Category());
        return "category/add_category";
    }

    @PostMapping("/category/add")
    public String addCategory(@ModelAttribute(name="category")Category category
                                , @RequestParam("logoFile")MultipartFile logoImageFile){
        System.out.println("#addCategory(): category:"+category);
        if(logoImageFile!=null){
            String logoImageFileName = StringUtils.cleanPath(logoImageFile.getOriginalFilename());
            category.setLogo(logoImageFileName);

            //save the product
            category =  categoryRepository.save(category);
            System.out.println(category);

            // product = productRepository.findProductByProduct_name(product.getProduct_name());

            System.out.println("#addCategory(): category:"+category);

            try {
                String fileSaveDir = WebConfiguration.IMAGE_UPLOAD_ROOT_PATH
                        +"/category/"+category.getId()+"-"+category.getName();
                Path fileSaveDirPath = Paths.get(fileSaveDir);
                if(!Files.exists(fileSaveDirPath)){
                    Files.createDirectories(fileSaveDirPath);
                }

                InputStream inputStream = logoImageFile.getInputStream();
                Path filePath = fileSaveDirPath.resolve(logoImageFileName);
                Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
                System.out.println("logo image saved");
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("image was not saved");
            }
        }

        return "redirect:/admin/category/all";
    }

    @GetMapping("category/all")
    public String getAllCategories(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }
}
