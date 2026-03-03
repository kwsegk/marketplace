package com.egor.marketplace.service;

import com.egor.marketplace.entity.PaymentMethod;

import java.util.List;

public interface PaymentMethodService {
    List<PaymentMethod> getPaymentMethodsByUserId(int userId);
    PaymentMethod getPaymentMethodById(int id);
    void addPaymentMethod(PaymentMethod paymentMethod, int userId);
    void updatePaymentMethod(PaymentMethod paymentMethod);
    void deletePaymentMethod(int id);
    void setDefaultPaymentMethod(int userId, int paymentMethodId);
}
