package com.shopsphere.controller;

import com.shopsphere.model.Product;
import com.shopsphere.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        // Product Details
        if (id != null && !id.isEmpty()) {

            try {

                int productId = Integer.parseInt(id);

                Product product =
                        productService.getProductById(productId);

                request.setAttribute("product", product);

                request.getRequestDispatcher(
                        "/product-details.jsp"
                ).forward(request, response);

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath() + "/products"
                );
            }

        }

        // All Products
        else {

            List<Product> products =
                    productService.getAllProducts();

            request.setAttribute("products", products);

            request.getRequestDispatcher(
                    "/products.jsp"
            ).forward(request, response);
        }
    }
}