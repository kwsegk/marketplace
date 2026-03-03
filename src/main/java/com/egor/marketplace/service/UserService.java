package com.egor.marketplace.service;

import com.egor.marketplace.entity.User;

import java.util.List;

public interface UserService {
    User getUserById(int id);
    User getUserByIdWithProducts(int id);
    User getUserByUsername(String username);
    List<User> getAllSellersWithProducts();
    List<User> getAllBuyersWithOrders();
    List<User> getAllUsers();
    void registerUser(User user);
    boolean authenticateUser(String username, String password);
    void updateUser(User user);
    void deleteUser(int id);
}
