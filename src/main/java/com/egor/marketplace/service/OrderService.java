package com.egor.marketplace.service;

import com.egor.marketplace.entity.Address;
import com.egor.marketplace.entity.Cart;
import com.egor.marketplace.entity.Order;
import com.egor.marketplace.entity.PaymentMethod;

import java.util.List;

public interface OrderService {
    List<Order> getOrdersByUserId(int userId);
    Order getOrderById(int id);
    Order createOrderFromCart(Cart cart, int userId, int addressId, int paymentMethodId);
    void updateOrder(Order order);
    void deleteOrder(int id);
}
