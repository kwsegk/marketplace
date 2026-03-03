package com.egor.marketplace.dao;

import com.egor.marketplace.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public User getUserById(int id) {
        return entityManager.find(User.class, id);
    }

    @Override
    public User getUserByUsername(String username) {
        List<User> users = entityManager.createQuery("from User where username = :username", User.class)
                .setParameter("username", username)
                .getResultList();
        return users.isEmpty() ? null : users.get(0);
    }

    @Override
    public void saveUser(User user) {
        entityManager.persist(user);
    }

    @Override
    public void updateUser(User user) {
        entityManager.merge(user);
    }

    @Override
    public void deleteUser(int id) {
        User user = getUserById(id);
        if (user != null) {
            // 1. Удаляем все order_items для заказов этого пользователя (как покупателя)
            entityManager.createQuery("DELETE FROM OrderItem oi WHERE oi.order.user.id = :userId")
                    .setParameter("userId", id)
                    .executeUpdate();
            
            // 2. НЕ удаляем order_items товаров продавца - они должны остаться в истории заказов
            // Вместо этого просто отвязываем товары от продавца (делаем их "архивными")
            entityManager.createQuery("UPDATE Product p SET p.user = NULL WHERE p.user.id = :userId")
                    .setParameter("userId", id)
                    .executeUpdate();
            
            // 3. Удаляем все заказы пользователя (как покупателя)
            entityManager.createQuery("DELETE FROM Order o WHERE o.user.id = :userId")
                    .setParameter("userId", id)
                    .executeUpdate();
            
            // 4. Удаляем все отзывы на товары этого пользователя
            entityManager.createQuery("DELETE FROM Review r WHERE r.product.user.id = :userId")
                    .setParameter("userId", id)
                    .executeUpdate();
            
            // 5. Удаляем все отзывы, оставленные этим пользователем
            entityManager.createQuery("DELETE FROM Review r WHERE r.user.id = :userId")
                    .setParameter("userId", id)
                    .executeUpdate();
            
            // 6. Теперь можем безопасно удалить пользователя (addresses, payment_methods через каскад)
            entityManager.remove(user);
        }
    }

    @Override
    public User getUserByIdWithProducts(int id) {
        List<User> users = entityManager.createQuery(
                "SELECT u FROM User u LEFT JOIN FETCH u.products WHERE u.id = :id", User.class)
                .setParameter("id", id)
                .getResultList();
        return users.isEmpty() ? null : users.get(0);
    }

    @Override
    public List<User> getAllSellersWithProducts() {
        return entityManager.createQuery(
                "SELECT DISTINCT u FROM User u LEFT JOIN FETCH u.products WHERE u.role = :sellerRole ORDER BY u.id", User.class)
                .setParameter("sellerRole", com.egor.marketplace.entity.Role.SELLER)
                .getResultList();
    }

    @Override
    public List<User> getAllBuyersWithOrders() {
        return entityManager.createQuery(
                "SELECT DISTINCT u FROM User u LEFT JOIN FETCH u.orders WHERE u.role = :userRole ORDER BY u.id", User.class)
                .setParameter("userRole", com.egor.marketplace.entity.Role.USER)
                .getResultList();
    }

    @Override
    public List<User> getAllUsers() {
        return entityManager.createQuery(
                "SELECT u FROM User u ORDER BY u.role, u.id", User.class)
                .getResultList();
    }
}
