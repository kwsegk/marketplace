package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Cart;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartDAOImpl implements CartDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Cart> getAllCarts() {
        return entityManager.createQuery("from Cart", Cart.class).getResultList();
    }

    @Override
    public Cart getCartById(int id) {
        return entityManager.find(Cart.class, id);
    }

    @Override
    public Cart getCartByUserId(int userId) {
        List<Cart> carts = entityManager.createQuery("from Cart where user.id = :userId", Cart.class)
                .setParameter("userId", userId)
                .getResultList();
        return carts.isEmpty() ? null : carts.get(0);
    }

    @Override
    public void saveCart(Cart cart) {
        entityManager.persist(cart);
    }

    @Override
    public void updateCart(Cart cart) {
        entityManager.merge(cart);
    }

    @Override
    public void deleteCart(int id) {
        Cart cart = getCartById(id);
        if (cart != null) {
            entityManager.remove(cart);
        }
    }
}
