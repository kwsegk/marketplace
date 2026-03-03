package com.egor.marketplace.service;

import com.egor.marketplace.dao.ProductDAO;
import com.egor.marketplace.dao.UserDAO;
import com.egor.marketplace.entity.Product;
import com.egor.marketplace.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private UserDAO userDAO;

    @Override
    @Transactional
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    @Override
    @Transactional
    public List<Product> searchAndFilterProducts(String search, String sortBy, Integer excludeUserId) {
        return productDAO.searchAndFilterProducts(search, sortBy, excludeUserId);
    }

    @Override
    @Transactional
    public List<Product> getProductsByUserId(int userId) {
        return productDAO.getAllProductsByUserId(userId);
    }

    @Override
    @Transactional
    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    @Override
    @Transactional
    public boolean canDeleteProduct(int productId) {
        return !productDAO.hasOrderItems(productId);
    }

    @Override
    @Transactional
    public void addProduct(Product product, int userId) {
        User user = userDAO.getUserById(userId);
        product.setUser(user);
        productDAO.saveProduct(product);
    }

    @Override
    @Transactional
    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
    }

    @Override
    @Transactional
    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
    }
}
