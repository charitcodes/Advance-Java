package com.shopsphere.controller;

import com.shopsphere.model.Order;
import com.shopsphere.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/login"
            );

            return;
        }

        String action = request.getParameter("action");

        // VIEW ORDER DETAILS
        if ("view".equalsIgnoreCase(action)) {

            String id = request.getParameter("id");

            try {

                int orderId = Integer.parseInt(id);

                Order order =
                        orderService.getOrderById(orderId);

                if (order == null) {

                    response.sendRedirect(
                            request.getContextPath() +
                            "/admin/orders"
                    );

                    return;
                }

                request.setAttribute(
                        "order",
                        order
                );

                request.getRequestDispatcher(
                        "/admin/order-details.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/admin/orders"
                );

                return;
            }
        }

        // ORDERS FOR SELECTED USER
        String userIdParameter =
                request.getParameter("userId");

        if (userIdParameter != null &&
            !userIdParameter.isEmpty()) {

            try {

                int userId =
                        Integer.parseInt(
                                userIdParameter
                        );

                List<Order> orders =
                        orderService.getOrdersByUserId(
                                userId
                        );

                request.setAttribute(
                        "orders",
                        orders
                );

            } catch (NumberFormatException e) {

                request.setAttribute(
                        "error",
                        "Invalid user ID."
                );
            }

        } else {

            // ALL ORDERS
            List<Order> orders =
                    orderService.getAllOrders();

            request.setAttribute(
                    "orders",
                    orders
            );
        }

        request.getRequestDispatcher(
                "/admin/orders.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/login"
            );

            return;
        }

        String action =
                request.getParameter("action");

        try {

            // UPDATE ORDER STATUS
            if ("status".equalsIgnoreCase(action)) {

                int orderId =
                        Integer.parseInt(
                                request.getParameter(
                                        "orderId"
                                )
                        );

                String status =
                        request.getParameter(
                                "status"
                        );

                if (status != null &&
                    !status.trim().isEmpty()) {

                    orderService.updateOrderStatus(
                            orderId,
                            status
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath() +
                "/admin/orders"
        );
    }
}