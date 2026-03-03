package com.egor.marketplace.service;

import com.egor.marketplace.entity.Product;

import java.util.List;

public interface ProductService {
    List<Product> getAllProducts();
    List<Product> searchAndFilterProducts(String search, String sortBy, Integer excludeUserId);
    List<Product> getProductsByUserId(int userId);
    Product getProductById(int id);
    boolean canDeleteProduct(int productId);
    void addProduct(Product product, int userId);
    void updateProduct(Product product);
    void deleteProduct(int id);
}
