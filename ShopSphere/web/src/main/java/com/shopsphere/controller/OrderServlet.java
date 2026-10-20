package com.shopsphere.controller;

import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.model.User;
import com.shopsphere.service.OrderItemService;
import com.shopsphere.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final OrderItemService orderItemService = new OrderItemService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        User user = (User) session.getAttribute("user");

        String id = request.getParameter("id");

        // If an order ID is provided, show order details
        if (id != null && !id.isEmpty()) {

            try {

                int orderId = Integer.parseInt(id);

                List<Order> orders =
                        orderService.getOrdersByUserId(user.getUserId());

                Order selectedOrder = null;

                for (Order order : orders) {

                    if (order.getOrderId() == orderId) {
                        selectedOrder = order;
                        break;
                    }
                }

                if (selectedOrder == null) {

                    response.sendRedirect(
                        request.getContextPath() + "/orders"
                    );
                    return;
                }

                List<OrderItem> items =
                        orderItemService.getItemsByOrderId(orderId);

                request.setAttribute("order", selectedOrder);
                request.setAttribute("orderItems", items);

                request.getRequestDispatcher(
                    "/order-details.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                    request.getContextPath() + "/orders"
                );
                return;
            }
        }

        // Show all orders
        List<Order> orders =
                orderService.getOrdersByUserId(user.getUserId());

        request.setAttribute("orders", orders);

        request.getRequestDispatcher(
            "/orders.jsp"
        ).forward(request, response);
    }
}