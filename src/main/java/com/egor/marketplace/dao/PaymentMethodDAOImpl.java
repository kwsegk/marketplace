package com.egor.marketplace.dao;

import com.egor.marketplace.entity.PaymentMethod;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PaymentMethodDAOImpl implements PaymentMethodDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<PaymentMethod> getPaymentMethodsByUserId(int userId) {
        return entityManager.createQuery(
                "SELECT p FROM PaymentMethod p WHERE p.user.id = :userId ORDER BY p.isDefault DESC, p.id", PaymentMethod.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Override
    public PaymentMethod getPaymentMethodById(int id) {
        return entityManager.find(PaymentMethod.class, id);
    }

    @Override
    public void savePaymentMethod(PaymentMethod paymentMethod) {
        entityManager.persist(paymentMethod);
    }

    @Override
    public void updatePaymentMethod(PaymentMethod paymentMethod) {
        entityManager.merge(paymentMethod);
    }

    @Override
    public void deletePaymentMethod(int id) {
        PaymentMethod paymentMethod = getPaymentMethodById(id);
        if (paymentMethod != null) {
            entityManager.remove(paymentMethod);
        }
    }

    @Override
    public void setDefaultPaymentMethod(int userId, int paymentMethodId) {
        entityManager.createQuery("UPDATE PaymentMethod p SET p.isDefault = false WHERE p.user.id = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
        
        entityManager.createQuery("UPDATE PaymentMethod p SET p.isDefault = true WHERE p.id = :paymentMethodId")
                .setParameter("paymentMethodId", paymentMethodId)
                .executeUpdate();
    }
}
