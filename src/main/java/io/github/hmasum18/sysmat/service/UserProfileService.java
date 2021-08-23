package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.model.UserProfile;
import io.github.hmasum18.sysmat.repository.UserProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserProfileService {
    @Autowired
    private UserProfileRepository repository;

    @Transactional
    public UserProfile save(UserProfile userProfile) {
        return repository.save(userProfile);
    }

    public UserProfile getProfile(User user){
        return repository.findByUser(user).orElse(null);
    }
}
