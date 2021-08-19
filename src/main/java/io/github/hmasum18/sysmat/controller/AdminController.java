package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.config.WebConfiguration;
import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Value("${firebase-api-key}")
    private String firebaseApiKey;

    @Autowired
    CategoryRepository categoryRepository;

    // ======================= category routes =========================================

    @GetMapping("/category/add")
    public String addCategory(ModelMap modelMap) {
        modelMap.put("category", new Category());
        modelMap.put("firebaseApiKey", firebaseApiKey);
        return "category/add_category";
    }

    @PostMapping("/category/add")
    public String addCategory(@ModelAttribute(name = "category") Category category) {
        System.out.println("#addCategory(): category:" + category);

        //save the product
        category = categoryRepository.save(category);
        System.out.println(category);

        System.out.println("#addCategory(): saved category:" + category);

        return"redirect:/admin/category/all";
}

    @GetMapping("category/all")
    public String getAllCategories(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    @GetMapping("product/pending")
    public String getPendingProducts(ModelMap modelMap) {
        return "product/all_products";
    }
}
