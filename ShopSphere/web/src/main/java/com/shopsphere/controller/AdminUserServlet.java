package com.shopsphere.controller;

import com.shopsphere.model.User;
import com.shopsphere.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null || session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );

            return;
        }

        // Get all users
        List<User> users = userDAO.getAllUsers();

        // Send users to JSP
        request.setAttribute("users", users);

        // Open customer management page
        request.getRequestDispatcher("/admin/users.jsp")
               .forward(request, response);
    }
}