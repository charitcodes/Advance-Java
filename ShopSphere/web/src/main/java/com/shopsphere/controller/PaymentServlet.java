package com.shopsphere.controller;

import com.shopsphere.model.Order;
import com.shopsphere.model.Payment;
import com.shopsphere.model.User;
import com.shopsphere.service.OrderService;
import com.shopsphere.service.PaymentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private PaymentService paymentService;
    private OrderService orderService;

    @Override
    public void init() {

        paymentService = new PaymentService();
        orderService = new OrderService();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        String orderIdParameter =
                request.getParameter("orderId");

        if (orderIdParameter == null ||
                orderIdParameter.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/orders");

            return;
        }

        try {

            int orderId =
                    Integer.parseInt(orderIdParameter);

            User user =
                    (User) session.getAttribute("user");

            List<Order> orders =
                    orderService.getOrdersByUserId(
                            user.getUserId());

            Order selectedOrder = null;

            for (Order order : orders) {

                if (order.getOrderId() == orderId) {

                    selectedOrder = order;
                    break;
                }
            }

            if (selectedOrder == null) {

                response.sendRedirect(
                        request.getContextPath() + "/orders");

                return;
            }

            request.setAttribute(
                    "order",
                    selectedOrder);

            request.getRequestDispatcher(
                    "/payment.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/orders");
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        User user =
                (User) session.getAttribute("user");

        try {

            int orderId =
                    Integer.parseInt(
                            request.getParameter("orderId"));

            String paymentMethod =
                    request.getParameter("paymentMethod");


            // Verify order belongs to logged-in user

            List<Order> orders =
                    orderService.getOrdersByUserId(
                            user.getUserId());

            Order selectedOrder = null;

            for (Order order : orders) {

                if (order.getOrderId() == orderId) {

                    selectedOrder = order;
                    break;
                }
            }

            if (selectedOrder == null) {

                response.sendRedirect(
                        request.getContextPath() + "/orders");

                return;
            }


            // Create mock payment

            Payment payment =
                    new Payment();

            payment.setOrderId(orderId);

            payment.setPaymentMethod(
                    paymentMethod);

            payment.setAmount(
                    selectedOrder.getTotalAmount());

            payment.setPaymentStatus(
                    "SUCCESS");

            payment.setTransactionId(
                    "TXN-"
                    + UUID.randomUUID()
                    .toString()
                    .substring(0, 8)
                    .toUpperCase());


            paymentService.addPayment(
                    payment);


            // Redirect to success page

            response.sendRedirect(
                    request.getContextPath()
                    + "/payment-success.jsp"
                    + "?orderId="
                    + orderId);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/payment-failed.jsp");
        }
    }
}