package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Cart;

import java.util.List;

public interface CartDAO {
    List<Cart> getAllCarts();
    Cart getCartById(int id);
    Cart getCartByUserId(int userId);
    void saveCart(Cart cart);
    void updateCart(Cart cart);
    void deleteCart(int id);
}
