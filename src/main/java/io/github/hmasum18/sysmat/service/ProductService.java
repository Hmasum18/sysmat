package io.github.hmasum18.sysmat.service;

import io.github.hmasum18.sysmat.model.Category;
import io.github.hmasum18.sysmat.model.Product;
import io.github.hmasum18.sysmat.model.User;
import io.github.hmasum18.sysmat.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    @Transactional
    public Product save(Product product){
        return productRepository.save(product);
    }

    public Optional<List<Product>> getAllProduct(User user){
        return productRepository.findAllByUser(user);
    }

    public Optional<List<Product>> getAllProduct(User user, boolean verified){
        return productRepository.findAllByUserAndVerified(user, verified);
    }

    // for anonymous user
    public Optional<List<Product>> getAllProduct(Category category, boolean verified){
        return productRepository.findAllByCategoryAndVerified(category, verified);
    }

    public Optional<List<Product>> getAllProduct(boolean verified){
        return productRepository.findAllByVerifiedOrderByCreatedDesc(verified);
    }


    public Optional<Product> getProduct(int productId) {
        return productRepository.findById(productId);
    }

    public void delete(int productId) {
        productRepository.deleteById(productId);
    }
}
