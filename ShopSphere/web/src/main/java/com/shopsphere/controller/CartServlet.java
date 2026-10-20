package com.shopsphere.controller;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;
import com.shopsphere.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartService cartService;

    @Override
    public void init() {
        cartService = new CartService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<CartItem> cartItems =
                cartService.getCartByUserId(user.getUserId());

        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("/cart.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {

            if ("add".equals(action)) {

                int productId =
                        Integer.parseInt(request.getParameter("productId"));

                int quantity =
                        Integer.parseInt(request.getParameter("quantity"));

                cartService.addToCart(
                        user.getUserId(),
                        productId,
                        quantity
                );

            } else if ("remove".equals(action)) {

                int cartId =
                        Integer.parseInt(request.getParameter("cartId"));

                cartService.removeFromCart(cartId);
            }

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );
        }
    }
}