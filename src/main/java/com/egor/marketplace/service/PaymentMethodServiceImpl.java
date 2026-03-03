package com.egor.marketplace.service;

import com.egor.marketplace.dao.PaymentMethodDAO;
import com.egor.marketplace.dao.UserDAO;
import com.egor.marketplace.entity.PaymentMethod;
import com.egor.marketplace.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PaymentMethodServiceImpl implements PaymentMethodService {

    @Autowired
    private PaymentMethodDAO paymentMethodDAO;

    @Autowired
    private UserDAO userDAO;

    @Override
    @Transactional
    public List<PaymentMethod> getPaymentMethodsByUserId(int userId) {
        return paymentMethodDAO.getPaymentMethodsByUserId(userId);
    }

    @Override
    @Transactional
    public PaymentMethod getPaymentMethodById(int id) {
        return paymentMethodDAO.getPaymentMethodById(id);
    }

    @Override
    @Transactional
    public void addPaymentMethod(PaymentMethod paymentMethod, int userId) {
        User user = userDAO.getUserById(userId);
        paymentMethod.setUser(user);
        paymentMethodDAO.savePaymentMethod(paymentMethod);
    }

    @Override
    @Transactional
    public void updatePaymentMethod(PaymentMethod paymentMethod) {
        paymentMethodDAO.updatePaymentMethod(paymentMethod);
    }

    @Override
    @Transactional
    public void deletePaymentMethod(int id) {
        paymentMethodDAO.deletePaymentMethod(id);
    }

    @Override
    @Transactional
    public void setDefaultPaymentMethod(int userId, int paymentMethodId) {
        paymentMethodDAO.setDefaultPaymentMethod(userId, paymentMethodId);
    }
}
