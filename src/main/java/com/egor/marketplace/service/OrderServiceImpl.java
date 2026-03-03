package com.egor.marketplace.service;

import com.egor.marketplace.dao.AddressDAO;
import com.egor.marketplace.dao.OrderDAO;
import com.egor.marketplace.dao.PaymentMethodDAO;
import com.egor.marketplace.dao.UserDAO;
import com.egor.marketplace.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AddressDAO addressDAO;

    @Autowired
    private PaymentMethodDAO paymentMethodDAO;

    @Autowired
    private ProductService productService;

    @Override
    @Transactional
    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    @Override
    @Transactional
    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    @Override
    @Transactional
    public Order createOrderFromCart(Cart cart, int userId, int addressId, int paymentMethodId) {
        User user = userDAO.getUserById(userId);
        Address address = addressDAO.getAddressById(addressId);
        PaymentMethod paymentMethod = paymentMethodDAO.getPaymentMethodById(paymentMethodId);

        Order order = new Order(user, address, paymentMethod, cart.getTotalPrice(), "Успешный");
        
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart.getItems()) {
            Product product = cartItem.getProduct();
            
            // Уменьшаем количество товара на складе
            int newQuantity = product.getQuantity() - cartItem.getQuantity();
            if (newQuantity < 0) {
                throw new RuntimeException("Недостаточно товара на складе: " + product.getName());
            }
            product.setQuantity(newQuantity);
            productService.updateProduct(product);
            
            OrderItem orderItem = new OrderItem(
                product,
                cartItem.getQuantity(),
                product.getPrice()
            );
            orderItem.setOrder(order);
            orderItems.add(orderItem);
        }
        
        order.setOrderItems(orderItems);
        orderDAO.saveOrder(order);
        
        return order;
    }

    @Override
    @Transactional
    public void updateOrder(Order order) {
        orderDAO.updateOrder(order);
    }

    @Override
    @Transactional
    public void deleteOrder(int id) {
        orderDAO.deleteOrder(id);
    }
}
