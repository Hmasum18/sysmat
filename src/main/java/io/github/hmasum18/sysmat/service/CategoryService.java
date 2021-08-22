package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository repository;

    public Optional<Category> getCategory(int categoryId){
        return repository.findById(categoryId);
    }

    public List<Category> getAllCategory(){
        return repository.findAll();
    }
}
