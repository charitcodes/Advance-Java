package com.shopsphere.service;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.Order;

import java.util.List;

public class OrderService {

    private OrderDAO orderDAO;

    public OrderService() {
        orderDAO = new OrderDAO();
    }

    // GET ORDERS BY USER
    public List<Order> getOrdersByUserId(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    // GET ALL ORDERS - ADMIN
    public List<Order> getAllOrders() {
        return orderDAO.getAllOrders();
    }

    // GET ORDER BY ID - ADMIN
    public Order getOrderById(int orderId) {
        return orderDAO.getOrderById(orderId);
    }

    // UPDATE ORDER STATUS - ADMIN
    public boolean updateOrderStatus(
            int orderId,
            String status) {

        return orderDAO.updateOrderStatus(
                orderId,
                status
        );
    }

    // CREATE ORDER
    public int createOrder(Order order) {
        return orderDAO.createOrder(order);
    }
}