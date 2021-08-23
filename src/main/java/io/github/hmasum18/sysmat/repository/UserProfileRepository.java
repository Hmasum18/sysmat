package io.github.hmasum18.sysmat.repository;

import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.model.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserProfileRepository extends JpaRepository<UserProfile, Integer>{
    Optional<UserProfile> findByUser(User user);
}
