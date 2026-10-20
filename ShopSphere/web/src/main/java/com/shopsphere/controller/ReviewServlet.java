package com.shopsphere.controller;

import com.shopsphere.model.Review;
import com.shopsphere.model.User;
import com.shopsphere.service.ReviewService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private ReviewService reviewService;

    @Override
    public void init() {
        reviewService = new ReviewService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParameter = request.getParameter("productId");

        if (productIdParameter == null) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParameter);

            List<Review> reviews =
                    reviewService.getReviewsByProductId(productId);

            request.setAttribute("reviews", reviews);
            request.setAttribute("productId", productId);

            request.getRequestDispatcher("/reviews.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
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

        try {
            int productId =
                    Integer.parseInt(request.getParameter("productId"));

            int rating =
                    Integer.parseInt(request.getParameter("rating"));

            String comment = request.getParameter("comment");

            Review review = new Review();

            review.setUserId(user.getUserId());
            review.setProductId(productId);
            review.setRating(rating);
            review.setComment(comment);

            reviewService.addReview(review);

            response.sendRedirect(
                    request.getContextPath() +
                    "/reviews?productId=" + productId
            );

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }
}