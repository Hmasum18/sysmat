package io.github.hmasum18.sysmat.repository;

import io.github.hmasum18.sysmat.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
}
