
package com.shopsphere.controller;

import com.shopsphere.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/update-stock")
public class UpdateStockServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );
            return;
        }

        try {
            int productId = Integer.parseInt(
                    request.getParameter("productId")
            );

            int stock = Integer.parseInt(
                    request.getParameter("stock")
            );

            if (productId <= 0 || stock < 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Product ID must be positive and stock cannot be negative."
                );
                return;
            }

            boolean updated =
                    productService.updateStock(productId, stock);

            if (updated) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/low-stock?updated=1"
                );
            } else {
                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/low-stock?error=1"
                );
            }

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Enter a valid product ID and stock quantity."
            );
        }
    }
}
