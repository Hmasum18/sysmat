package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.config.WebConfiguration;
import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import io.github.hmasum18.sysmat.service.ProductService;
import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Value("${firebase-api-key}")
    private String firebaseApiKey;

    @Value("${firebase-project-id}")
    private String firebaseProjectId;

    @Value("${firebase-message-sender-id}")
    private String messagingSenderId;

    @Value("${firebase-app-id}")
    private String firebaseAppId;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    ProductService productService;

    // ======================= category routes =========================================

    @GetMapping("/category/add")
    public String addCategory(ModelMap modelMap) {
        modelMap.put("category", new Category());
        putFirebaseCredentials(modelMap);
        return "category/add_category";
    }


    @PostMapping("/category/add")
    public String addCategory(@ModelAttribute(name = "category") Category category) {
        System.out.println("#addCategory(): received category:" + category);

        //save the product
        category = categoryRepository.save(category);
        System.out.println(category);

        System.out.println("#addCategory(): saved category:" + category);

        return "redirect:/admin/category/";
    }

    @GetMapping("/category/{categoryId}/edit")
    public String editCategory(@PathVariable int categoryId, ModelMap modelMap) {
        Optional<Category> category = categoryRepository.findById(categoryId);
        modelMap.put("category", category.get());
        putFirebaseCredentials(modelMap);
        return "category/edit_category";
    }

    @PostMapping("/category/{categoryId}/edit")
    public String editCategory(@ModelAttribute(name = "category") Category category, @PathVariable int categoryId) {
        System.out.println("#addCategory(): received category:" + category);
        Category prevCategory = categoryRepository.findById(categoryId).get();

        category.setCreated(prevCategory.getCreated());

        //save the product
        category = categoryRepository.save(category);
        System.out.println(category);

        System.out.println("#addCategory(): saved category:" + category);

        return "redirect:/admin/category/";
    }

    @PostMapping(value = "/category/{categoryId}/delete")
    public String deleteCategory(@PathVariable int categoryId) {
        System.out.println("deleteCategory(): " + categoryId);
        categoryRepository.delete(categoryRepository.findById(categoryId).get());
        return "redirect:/admin/category/";
    }

    @GetMapping("category/")
    public String getAllCategories(ModelMap modelMap) {
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.put("categoryList", categoryList);
        putFirebaseCredentials(modelMap);
        return "category/all_categories";
    }

    // ======================== product routes =========================================

    // render all the unverified product
    @GetMapping("product/pending")
    public String getPendingProducts(ModelMap modelMap) {
        Optional<List<Product>> productList = productService.getAllProduct(false);
        productList.ifPresent(products -> {
            modelMap.put("productList", products);
        });
        putFirebaseCredentials(modelMap);
        return "product/pending_products";
    }

    @GetMapping("product/{productId}/verify")
    public String verify(@PathVariable int productId, ModelMap modelMap){
        System.out.println("verify(): "+productId);
        Product product = productService.getProduct(productId).get();
        product.setVerified(true);
        product = productService.save(product);
        System.out.println("verify(): "+product);
        return "redirect:/admin/product/pending/";
    }


    private void putFirebaseCredentials(ModelMap modelMap) {
        modelMap.put("firebaseApiKey", firebaseApiKey);
        modelMap.put("firebaseProjectId", firebaseProjectId);
        modelMap.put("messagingSenderId", messagingSenderId);
        modelMap.put("firebaseAppId", firebaseAppId);
    }

}
