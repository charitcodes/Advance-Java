package com.shopsphere.service;

import com.shopsphere.dao.OrderItemDAO;
import com.shopsphere.model.OrderItem;

import java.util.List;

public class OrderItemService {

    private OrderItemDAO orderItemDAO;

    public OrderItemService() {
        orderItemDAO = new OrderItemDAO();
    }

    public List<OrderItem> getItemsByOrderId(int orderId) {
        return orderItemDAO.getItemsByOrderId(orderId);
    }

    public void addOrderItem(OrderItem item) {
        orderItemDAO.addOrderItem(item);
    }
}