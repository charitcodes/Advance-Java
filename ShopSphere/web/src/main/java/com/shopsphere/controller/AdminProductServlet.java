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

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }


    // ==========================================
    // GET
    // ==========================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");


        // ======================================
        // ADD PRODUCT FORM
        // ======================================

        if ("add".equalsIgnoreCase(action)) {

            request.getRequestDispatcher(
                    "/admin/product-form.jsp"
            ).forward(request, response);

            return;
        }


        // ======================================
        // EDIT PRODUCT FORM
        // ======================================

        if ("edit".equalsIgnoreCase(action)) {

            String id = request.getParameter("id");

            try {

                int productId =
                        Integer.parseInt(id);

                Product product =
                        productService.getProductById(productId);

                if (product == null) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/products"
                    );

                    return;
                }

                request.setAttribute(
                        "product",
                        product
                );

                request.getRequestDispatcher(
                        "/admin/product-form.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/products"
                );

                return;
            }
        }


        // ======================================
        // SHOW ALL PRODUCTS
        // ======================================

        List<Product> products =
                productService.getAllProducts();

        request.setAttribute(
                "products",
                products
        );

        request.getRequestDispatcher(
                "/admin/products.jsp"
        ).forward(request, response);
    }


    // ==========================================
    // POST
    // ==========================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");


        try {


            // ==================================
            // ADD PRODUCT
            // ==================================

            if ("add".equalsIgnoreCase(action)) {

                Product product =
                        new Product();


                product.setCategoryId(
                        Integer.parseInt(
                                request.getParameter(
                                        "categoryId"
                                )
                        )
                );


                product.setName(
                        request.getParameter("name")
                );


                product.setBrand(
                        request.getParameter("brand")
                );


                product.setDescription(
                        request.getParameter(
                                "description"
                        )
                );


                product.setPrice(
                        Double.parseDouble(
                                request.getParameter(
                                        "price"
                                )
                        )
                );


                product.setDiscount(
                        Double.parseDouble(
                                request.getParameter(
                                        "discount"
                                )
                        )
                );


                product.setStock(
                        Integer.parseInt(
                                request.getParameter(
                                        "stock"
                                )
                        )
                );


                product.setImage(
                        request.getParameter("image")
                );


                productService.addProduct(
                        product
                );
            }


            // ==================================
            // UPDATE PRODUCT
            // ==================================

            else if ("update".equalsIgnoreCase(action)) {

                Product product =
                        new Product();


                product.setProductId(
                        Integer.parseInt(
                                request.getParameter(
                                        "productId"
                                )
                        )
                );


                product.setCategoryId(
                        Integer.parseInt(
                                request.getParameter(
                                        "categoryId"
                                )
                        )
                );


                product.setName(
                        request.getParameter("name")
                );


                product.setBrand(
                        request.getParameter("brand")
                );


                product.setDescription(
                        request.getParameter(
                                "description"
                        )
                );


                product.setPrice(
                        Double.parseDouble(
                                request.getParameter(
                                        "price"
                                )
                        )
                );


                product.setDiscount(
                        Double.parseDouble(
                                request.getParameter(
                                        "discount"
                                )
                        )
                );


                product.setStock(
                        Integer.parseInt(
                                request.getParameter(
                                        "stock"
                                )
                        )
                );


                product.setImage(
                        request.getParameter("image")
                );


                productService.updateProduct(
                        product
                );
            }


            // ==================================
            // DELETE PRODUCT
            // ==================================

            else if ("delete".equalsIgnoreCase(action)) {

                int productId =
                        Integer.parseInt(
                                request.getParameter(
                                        "productId"
                                )
                        );


                productService.deleteProduct(
                        productId
                );
            }


            // ==================================
            // UPDATE STOCK
            // ==================================

            else if ("stock".equalsIgnoreCase(action)) {

                int productId =
                        Integer.parseInt(
                                request.getParameter(
                                        "productId"
                                )
                        );


                int stock =
                        Integer.parseInt(
                                request.getParameter(
                                        "stock"
                                )
                        );


                if (stock < 0) {
                    stock = 0;
                }


                productService.updateStock(
                        productId,
                        stock
                );
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        // ======================================
        // RETURN TO PRODUCT LIST
        // ======================================

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/products"
        );
    }
}