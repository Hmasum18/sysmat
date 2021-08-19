package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class UniversalController {
    @Autowired
    CategoryRepository categoryRepository;

    @GetMapping("/")
    public String home(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    @GetMapping("/category/")
    public String getAllCategory(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }


    @GetMapping("/product")
    public String getAllProduct(ModelMap modelMap){
        return "product/all_products";
    }
}
