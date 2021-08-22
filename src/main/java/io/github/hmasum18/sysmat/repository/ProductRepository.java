package io.github.hmasum18.sysmat.repository;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    Optional<List<Product>> findAllByUser(User user);

    Optional<List<Product>> findAllByUserAndVerified(User user,  boolean verified);

    Optional<List<Product>> findAllByCategory(Category category);

    // for all user
    Optional<List<Product>> findAllByCategoryAndVerified(Category category, boolean verified);

    // for admin pending request
    Optional<List<Product>> findAllByVerifiedOrderByCreatedDesc(boolean verified);
}
