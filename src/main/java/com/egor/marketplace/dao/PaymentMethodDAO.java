package com.egor.marketplace.dao;

import com.egor.marketplace.entity.PaymentMethod;

import java.util.List;

public interface PaymentMethodDAO {
    List<PaymentMethod> getPaymentMethodsByUserId(int userId);
    PaymentMethod getPaymentMethodById(int id);
    void savePaymentMethod(PaymentMethod paymentMethod);
    void updatePaymentMethod(PaymentMethod paymentMethod);
    void deletePaymentMethod(int id);
    void setDefaultPaymentMethod(int userId, int paymentMethodId);
}
