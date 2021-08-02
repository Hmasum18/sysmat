package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.service.UserService;
import io.github.hmasum18.sysmat.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;
import java.util.Optional;


@Controller
@RequestMapping("auth")
public class AuthController {
    public static final String TAG="AuthController->";
    public static final String LOGIN_FORM = "auth/login";

    @Autowired
    JwtUtil jwtUtil;

    @Autowired
    UserService userService;

    @GetMapping(value = "/registration")
    public String registration(ModelMap model) {
        model.put("user", new User());
        return "auth/registration";
    }

    @PostMapping(value = "/registration")
    public String registration(@ModelAttribute("user") User user,
                               BindingResult bindingResult) {

        if (foundDuplicateUsername(user.getUsername())) {
            bindingResult.rejectValue("username", "", "This username has already been taken!");
        }

        if (bindingResult.hasErrors()) {
            return "auth/registration";
        }

        user.setVerified(false);
        user.setRoles("ROLE_USER");

        userService.save(user);

        return "redirect:/user";
    }

    @GetMapping(value = "login")
    public String login(ModelMap model, String error, String logout) {
        System.out.println(TAG+"inside get login method");
        if (error != null) {
            model.put("error", "Lol! Your username and password is invalid.");
        }

        if (logout != null) {
            model.put("logout", "Yahoo! You have been logged out successfully.");
        }

        model.put("user", new User());

        return LOGIN_FORM;
    }

    @PostMapping(value = "login")
    public String login(@ModelAttribute("user") User user, HttpServletRequest request, HttpServletResponse response) {
        System.out.println(TAG+"inside post login method");

        return LOGIN_FORM;
    }

    private boolean foundDuplicateUsername(String username) {
        Optional<User> duplicateUser = userService.findByUsername(username);

        return duplicateUser.isPresent();
    }

}
