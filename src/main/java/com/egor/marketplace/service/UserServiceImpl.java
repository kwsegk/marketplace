package com.egor.marketplace.service;

import com.egor.marketplace.dao.UserDAO;
import com.egor.marketplace.entity.Role;
import com.egor.marketplace.entity.User;
import com.egor.marketplace.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PasswordUtil passwordUtil;

    @Override
    @Transactional
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    @Override
    @Transactional
    public User getUserByIdWithProducts(int id) {
        return userDAO.getUserByIdWithProducts(id);
    }

    @Override
    @Transactional
    public List<User> getAllSellersWithProducts() {
        return userDAO.getAllSellersWithProducts();
    }

    @Override
    @Transactional
    public List<User> getAllBuyersWithOrders() {
        return userDAO.getAllBuyersWithOrders();
    }

    @Override
    @Transactional
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    @Override
    @Transactional
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    @Override
    @Transactional
    public void registerUser(User user) {
        if (user.getRole() == null) {
            user.setRole(Role.USER);
        }
        String hashedPassword = passwordUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);
        userDAO.saveUser(user);
    }

    @Override
    @Transactional
    public boolean authenticateUser(String username, String password) {
        User user = userDAO.getUserByUsername(username);
        if (user != null) {
            return passwordUtil.checkPassword(password, user.getPassword());
        }
        return false;
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    @Override
    @Transactional
    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }
}
