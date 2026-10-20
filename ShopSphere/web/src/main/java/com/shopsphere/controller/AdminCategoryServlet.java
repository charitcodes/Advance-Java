package com.shopsphere.controller;

import com.shopsphere.model.Category;
import com.shopsphere.service.CategoryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() {
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );
            return;
        }

        String action = request.getParameter("action");

        // ADD CATEGORY FORM
        if ("add".equalsIgnoreCase(action)) {

            request.getRequestDispatcher(
                    "/admin/category-form.jsp"
            ).forward(request, response);

            return;
        }

        // EDIT CATEGORY FORM
        if ("edit".equalsIgnoreCase(action)) {

            String id = request.getParameter("id");

            try {

                int categoryId = Integer.parseInt(id);

                Category category =
                        categoryService.getCategoryById(categoryId);

                if (category == null) {

                    response.sendRedirect(
                            request.getContextPath() +
                            "/admin/categories"
                    );

                    return;
                }

                request.setAttribute(
                        "category",
                        category
                );

                request.getRequestDispatcher(
                        "/admin/category-form.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath() +
                        "/admin/categories"
                );

                return;
            }
        }

        // CATEGORY LIST
        List<Category> categories =
                categoryService.getAllCategories();

        request.setAttribute(
                "categories",
                categories
        );

        request.getRequestDispatcher(
                "/admin/categories.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() +
                    "/admin/login"
            );

            return;
        }

        String action = request.getParameter("action");

        try {

            // ADD CATEGORY
            if ("add".equalsIgnoreCase(action)) {

                Category category = new Category();

                category.setName(
                        request.getParameter("name")
                );

                category.setDescription(
                        request.getParameter("description")
                );

                categoryService.addCategory(category);
            }

            // UPDATE CATEGORY
            else if ("update".equalsIgnoreCase(action)) {

                Category category = new Category();

                category.setCategoryId(
                        Integer.parseInt(
                                request.getParameter("categoryId")
                        )
                );

                category.setName(
                        request.getParameter("name")
                );

                category.setDescription(
                        request.getParameter("description")
                );

                categoryService.updateCategory(category);
            }

            // DELETE CATEGORY
            else if ("delete".equalsIgnoreCase(action)) {

                int categoryId =
                        Integer.parseInt(
                                request.getParameter("categoryId")
                        );

                categoryService.deleteCategory(
                        categoryId
                );
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        response.sendRedirect(
                request.getContextPath() +
                "/admin/categories"
        );
    }
}