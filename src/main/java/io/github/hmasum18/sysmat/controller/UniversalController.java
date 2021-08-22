package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import io.github.hmasum18.sysmat.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

@Controller
public class UniversalController {
    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    ProductService productService;

    @GetMapping("/")
    public String home(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    // render all the available category
    @GetMapping("/category/")
    public String getAllCategory(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    // render all the verified product of a category
    @GetMapping("/category/{category_id}")
    public String getAllProduct(ModelMap modelMap, @PathVariable int category_id) {
        Category category = categoryRepository.findById(category_id).get();
        Optional<List<Product>> categoryList = productService
                .getAllProduct(category, true);

        categoryList.ifPresent(products -> {
            modelMap.put("productList", products);
        });

        return "product/all_products";
    }
}
