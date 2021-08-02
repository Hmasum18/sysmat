package io.github.hmasum18.sysmat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
    @RequestMapping("/")
    public ModelAndView anonymousUser(){
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("role", "anonymous user");
        return mv;
    }

    @RequestMapping("/user")
    public ModelAndView user(){
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("role",  "user");
        return mv;
    }

    @RequestMapping("/admin")
    public ModelAndView admin(){
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("role", "admin");
        return mv;
    }
}
