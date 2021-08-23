package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.service.CategoryService;
import io.github.hmasum18.sysmat.service.ProductService;
import io.github.hmasum18.sysmat.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

@Controller
public class AnonymousController {

    @Autowired
    private UserService userService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @GetMapping("/")
    public String home(ModelMap modelMap) {
        List<Category> categoryList = categoryService.getAllCategory();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    // render all the available category
    @GetMapping("/category/")
    public String getAllCategory(ModelMap modelMap) {
        List<Category> categoryList = categoryService.getAllCategory();
        modelMap.put("categoryList", categoryList);
        return "category/all_categories";
    }

    // render all the verified product of a category
    @GetMapping("/category/{category_id}")
    public String getAllProduct(ModelMap modelMap, @PathVariable int category_id) {
        Category category = categoryService.getCategory(category_id).get();
        modelMap.put("category", category);

        // verified products
        Optional<List<Product>> productList = productService
                .getAllProduct(category, true);
        productList.ifPresent(products -> {
            modelMap.put("productList", products);
        });


        // unverified products
        if(userService.getLoggedInUser() != null){
            Optional<List<Product>> unVerifiedProductList = productService
                    .getAllProduct(category, false);
            unVerifiedProductList.ifPresent(products -> {
                modelMap.put("productListUnverified", products);
            });
        }


        return "product/all_products";
    }
}
