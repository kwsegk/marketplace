package com.egor.marketplace.dao;

import com.egor.marketplace.entity.User;

import java.util.List;

public interface UserDAO {
    User getUserById(int id);
    User getUserByIdWithProducts(int id);
    User getUserByUsername(String username);
    List<User> getAllSellersWithProducts();
    List<User> getAllBuyersWithOrders();
    List<User> getAllUsers();
    void saveUser(User user);
    void updateUser(User user);
    void deleteUser(int id);
}
