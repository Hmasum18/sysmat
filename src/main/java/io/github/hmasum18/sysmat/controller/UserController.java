package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import io.github.hmasum18.sysmat.repository.ProductRepository;
import io.github.hmasum18.sysmat.repository.UserRepository;
import io.github.hmasum18.sysmat.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

@Controller
@RequestMapping("user")
public class UserController {

    @Value("${firebase-api-key}")
    private String firebaseApiKey;

    @Value("${firebase-project-id}")
    private String firebaseProjectId;

    @Value("${firebase-message-sender-id}")
    private String messagingSenderId;

    @Value("${firebase-app-id}")
    private String firebaseAppId;

    @Value("${geoapify-api-key}")
    String geoapifyApiKey;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductService productService;

    // =============================== product routes ======================================
    @GetMapping("product/add")
    public String addProduct(ModelMap modelMap) {
        modelMap.put("product", new Product());
        modelMap.put("categoryList", categoryRepository.findAll());
        modelMap.put("geoapifyApiKey", geoapifyApiKey);
        putFirebaseCredentials(modelMap);
        return "product/add_product";
    }

    private void putFirebaseCredentials(ModelMap modelMap) {
        modelMap.put("firebaseApiKey", firebaseApiKey);
        modelMap.put("firebaseProjectId", firebaseProjectId);
        modelMap.put("messagingSenderId", messagingSenderId);
        modelMap.put("firebaseAppId", firebaseAppId);
    }

    @PostMapping("product/add")
    public String addProduct(@ModelAttribute("product") Product product, int categoryId) {
        Optional<Category> categoryOptional = categoryRepository.findById(categoryId);
        product.setCategory(categoryOptional.get());
        product.setUser(getLoggedInInUser());
        product = productService.save(product);
        System.out.println("addProduct(): " + product);

        return "redirect:/user/product/";
    }

    @GetMapping("product/")
    public String getAllProducts(ModelMap modelMap) {
        productService.getAllProduct(getLoggedInInUser(), true).ifPresent(products -> {
            modelMap.put("productList", products);
        });
        return "product/all_products";
    }

    private User getLoggedInInUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("getLoggedInInUser(): owner: " + username);
        Optional<User> user = userRepository.findByUsername(username);
        return user.get();
    }
}
