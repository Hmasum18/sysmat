package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder bCryptPasswordEncoder;


    public Optional<User> getUser(String username) {
        return userRepository.findByUsername(username);
    }

    public Optional<User> getUserByEmail(String email){
        return userRepository.findByEmail(email);
    }

    public User getLoggedInUser(){
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("getLoggedInInUser(): owner: " + username);
        Optional<User> user = userRepository.findByUsername(username);
        return user.orElse(null);
    }

    @Transactional
    public User save(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public User save(User user, String password) {
        user.setPassword(bCryptPasswordEncoder.encode(password));
        return userRepository.save(user);
    }

    public boolean matchPassword(String password){
        if(getLoggedInUser()==null)
            return  false;
        return bCryptPasswordEncoder.matches(password, getLoggedInUser().getPassword());
    }

    public Optional<User> getByVerificationCode(String code) {
        return userRepository.findByVerificationCode(code);
    }
}
