package com.shopsphere.controller;

import com.shopsphere.model.User;
import com.shopsphere.model.WishlistItem;
import com.shopsphere.service.WishlistService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistService wishlistService;

    @Override
    public void init() {
        wishlistService = new WishlistService();
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

        List<WishlistItem> items =
                wishlistService.getWishlistByUserId(user.getUserId());

        request.setAttribute("wishlistItems", items);

        request.getRequestDispatcher("/wishlist.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                int productId =
                        Integer.parseInt(request.getParameter("productId"));

                wishlistService.addToWishlist(
                        user.getUserId(),
                        productId
                );

            } else if ("remove".equals(action)) {

                int wishlistId =
                        Integer.parseInt(request.getParameter("wishlistId"));

                wishlistService.removeFromWishlist(wishlistId);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath() + "/wishlist"
        );
    }
}