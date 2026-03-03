package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderDAOImpl implements OrderDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        return entityManager.createQuery(
                "SELECT o FROM Order o LEFT JOIN FETCH o.orderItems WHERE o.user.id = :userId ORDER BY o.orderDate DESC", Order.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public Order getOrderById(int id) {
        List<Order> orders = entityManager.createQuery(
                "SELECT o FROM Order o LEFT JOIN FETCH o.orderItems WHERE o.id = :id", Order.class)
                .setParameter("id", id)
                .getResultList();
        return orders.isEmpty() ? null : orders.get(0);
    }

    @Override
    public void saveOrder(Order order) {
        entityManager.persist(order);
    }

    @Override
    public void updateOrder(Order order) {
        entityManager.merge(order);
    }

    @Override
    public void deleteOrder(int id) {
        Order order = getOrderById(id);
        if (order != null) {
            entityManager.remove(order);
        }
    }
}
