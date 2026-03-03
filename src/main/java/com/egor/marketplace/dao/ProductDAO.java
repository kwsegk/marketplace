package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Product;

import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts();
    List<Product> getAllProductsByUserId(int userId);
    List<Product> searchAndFilterProducts(String search, String sortBy, Integer userId);
    Product getProductById(int id);
    boolean hasOrderItems(int productId);
    void saveProduct(Product product);
    void updateProduct(Product product);
    void deleteProduct(int id);
}
