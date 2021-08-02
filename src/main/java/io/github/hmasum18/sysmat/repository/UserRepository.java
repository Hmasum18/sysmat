package io.github.hmasum18.sysmat.repository;

import io.github.hmasum18.sysmat.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByUsername(String userName);
    User findByLogin(String login); //email or phone numbers
}
