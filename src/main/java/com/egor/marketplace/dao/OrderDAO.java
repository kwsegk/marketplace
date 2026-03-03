package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Order;

import java.util.List;

public interface OrderDAO {
    List<Order> getOrdersByUserId(int userId);
    Order getOrderById(int id);
    void saveOrder(Order order);
    void updateOrder(Order order);
    void deleteOrder(int id);
}
