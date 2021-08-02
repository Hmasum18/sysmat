package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.Product;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class UserController {

    @GetMapping("product/add")
    private String add(ModelMap modelMap){
        modelMap.put("product", new Product());
        return "";
    }

    @PostMapping("product/add")
    private String add(@ModelAttribute("product")Product product){

        return "";
    }
}
