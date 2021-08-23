package io.github.hmasum18.sysmat.controller;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.model.UserProfile;
import io.github.hmasum18.sysmat.repository.UserRepository;
import io.github.hmasum18.sysmat.service.EmailSenderService;
import io.github.hmasum18.sysmat.service.UserProfileService;
import io.github.hmasum18.sysmat.service.UserService;
import io.github.hmasum18.sysmat.util.JwtUtil;
import net.bytebuddy.utility.RandomString;
import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Optional;


@Controller
@RequestMapping("auth")
public class AuthController {
    public static final String TAG="AuthController->";
    public static final String LOGIN_FORM = "auth/login";

    @Value("${is-localhost}")
    private String isLocalHost;

    @Autowired
    JwtUtil jwtUtil;

    @Autowired
    UserService userService;

    @Autowired
    UserProfileService userProfileService;

    @Autowired
    EmailSenderService emailSenderService;

    @GetMapping(value = "/registration")
    public String registration(ModelMap model) {
        model.put("user", new User());
        return "auth/registration";
    }

    @PostMapping(value = "/registration")
    public String registration(@ModelAttribute("user") User user,
                               ModelMap modelMap) {

        if (foundDuplicateUsername(user.getUsername())) {
           modelMap.put("usernameError",  "This username has already been taken!");
            return "auth/registration";
        }

        if(foundDuplicateEmail(user.getEmail())){
            modelMap.put("emailError",  "This email has already used by another user.");
            return "auth/registration";
        }

        user.setVerified(false);
        user.setRoles("ROLE_USER");

        boolean isVerificationCodeSent = sendVerificationCode(user);

        if(isVerificationCodeSent)
            userService.save(user, user.getPassword());
        else{
            modelMap.put("emailError","Email account is not valid.");
            return "auth/registration";
        }

        return "redirect:/auth/login?verified="+VERIFICATION_SENT;
    }

    private boolean sendVerificationCode(User user) {
        user.setVerificationCode(RandomString.make(64)); //save a verification code

        StringBuilder emailBody = new StringBuilder();
        emailBody.append("Welcome to Sysmat ").append(user.getUsername()).append(", \n\n");
        emailBody.append("Thanks for joining Sysmat. You are one step away.").
                append(" Click the link below to verify your account.").append("\n\n");

        if(isLocalHost.equals("true"))
            emailBody.append("http://localhost:8080/auth/verify?code=")
                    .append(user.getVerificationCode());
        else
            emailBody.append("https://sysmat.herokuapp.com/auth/verify?code=")
                    .append(user.getVerificationCode());
        emailBody.append("\n\n").append("Thank you.");

       return emailSenderService.sendSimpEmail(user.getEmail(), emailBody.toString(), "Sysmat verification.");
    }

    @GetMapping("/verify")
    public String verifyUser(String code){
        Optional<User> user = userService.getByVerificationCode(code);

        if (user.isEmpty()){
            return "redirect:/auth/login?verified="+VERIFICATION_FAILED;
        }else if(user.get().isVerified()){
            return "redirect:/auth/login?verified="+VERIFIED;
        }
        else {
            user.get().setVerificationCode(null);
            user.get().setVerified(true);
            userService.save(user.get());
            return "redirect:/auth/login?verified="+VERIFICATION_SUCCESS;
        }
    }

    public static final int VERIFICATION_FAILED = 0;
    public static final int VERIFICATION_SUCCESS = 1;
    public static final int VERIFICATION_SENT = 5;
    public static final int VERIFIED = 3;
    public static final int NOT_VERIFIED = 4;

    @GetMapping(value = "login")
    public String login(ModelMap model, String error, String logout, Integer verified) {
        System.out.println(TAG+"inside get login method");
        if (error != null) {
            model.put("error", "Your username and password is invalid.");
        }

        if (logout != null) {
            model.put("logout", "You have been logged out successfully.");
        }

        if(verified!=null){
            if(verified == VERIFIED)
                model.put("VERIFIED", "You are already verified. Please login to continue.");
            else if(verified == NOT_VERIFIED)
                model.put("NOT_VERIFIED", "You haven't verified your account yet. Check you mail to verify your account.");
            else if(verified == VERIFICATION_FAILED)
                model.put("VERIFICATION_FAILED", "Invalid verification link.");
            else if(verified == VERIFICATION_SUCCESS){
                model.put("VERIFICATION_SUCCESS",
                        "You account is verified now. Please login to continue.");
            }
            else if(verified == VERIFICATION_SENT){
                model.put("VERIFICATION_SENT"
                        , "Verification sent to you email account. Please check your mail to verify your sysmat account.");
            }
        }

        model.put("user", new User());

        return LOGIN_FORM;
    }

    @GetMapping("profile")
    private String profile(ModelMap modelMap){
        User user = userService.getLoggedInUser();
        modelMap.put("user", user);
        UserProfile userProfile = userProfileService.getProfile(user);
        if(userProfile == null){
            userProfile = new UserProfile();
            userProfile.setUser(user);
            userProfile = userProfileService.save(userProfile);
        }
        modelMap.put("userProfile", userProfile);
        return "auth/profile";
    }

    @PostMapping("profile")
    private String profile(ModelMap modelMap, UserProfile userProfile, String currentPassword, String newPassword){
        User user = userService.getLoggedInUser();
        modelMap.put("user", user);

       /* System.out.println("updateProfile(): " + userProfile);
        System.out.println("updateProfile(): odlPassword " + currentPassword);
        System.out.println("updateProfile(): newPassword " + newPassword);*/

        if(userService.matchPassword(currentPassword)){
            if(newPassword !=null && !newPassword.isEmpty()){
                user = userService.save(user, newPassword);
            }
            userProfile.setUser(user);
            userProfileService.save(userProfile);
            System.out.println("updateProfile(): correct password");
        }else{
            System.out.println("updateProfile(): Incorrect password");
            modelMap.put("passwordError", "Incorrect Password!");
        }

        userProfile = userProfileService.getProfile(user);
        modelMap.put("userProfile", userProfile);

        return "auth/profile";
    }

    private boolean foundDuplicateUsername(String username) {
        Optional<User> duplicateUser = userService.getUser(username);
        return duplicateUser.isPresent();
    }

    private boolean foundDuplicateEmail(String email) {
        Optional<User> duplicateUser = userService.getUserByEmail(email);
        return duplicateUser.isPresent();
    }


}
