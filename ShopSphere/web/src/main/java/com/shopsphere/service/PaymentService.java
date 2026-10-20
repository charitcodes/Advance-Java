package com.shopsphere.service;

import com.shopsphere.dao.PaymentDAO;
import com.shopsphere.model.Payment;

public class PaymentService {

    private PaymentDAO paymentDAO;

    public PaymentService() {
        paymentDAO = new PaymentDAO();
    }

    public void addPayment(Payment payment) {
        paymentDAO.addPayment(payment);
    }

    public Payment getPaymentByOrderId(int orderId) {
        return paymentDAO.getPaymentByOrderId(orderId);
    }
}