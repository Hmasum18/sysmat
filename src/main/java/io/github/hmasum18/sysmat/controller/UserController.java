package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    CategoryRepository categoryRepository;

    // =============================== product routes ======================================
    @GetMapping("product/add")
    public String addProduct(ModelMap modelMap){
        modelMap.put("product", new Product());
        modelMap.put("categoryList", categoryRepository.findAll());
        return "product/add_product";
    }

    @PostMapping("product/add")
    public String addProduct(@ModelAttribute("product")Product product
                                , @RequestParam("logoFile")MultipartFile logoImageFile){
        System.out.println("addProduct(): "+product);

        if(logoImageFile!=null) {
            String logoImageFileName = StringUtils.cleanPath(logoImageFile.getOriginalFilename());
            System.out.println("addProduct():"+logoImageFileName);
        }else{
            System.out.println("addProduct(): No image file recieved");
        }

        return "redirect:/user/product/all";
    }

    @GetMapping("product/all")
    public String getAllProducts(ModelMap modelMap){
        return "product/all_products";
    }
}
