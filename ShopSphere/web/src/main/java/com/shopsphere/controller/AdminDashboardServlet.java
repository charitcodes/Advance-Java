package com.shopsphere.controller;

import com.shopsphere.service.DashboardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private DashboardService dashboardService;


    @Override
    public void init() {
        dashboardService = new DashboardService();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // CHECK ADMIN LOGIN
        // =========================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/login"
            );

            return;
        }


        // =========================
        // LOAD DASHBOARD STATISTICS
        // =========================

        int totalProducts =
                dashboardService.getTotalProducts();

        int totalCustomers =
                dashboardService.getTotalCustomers();

        int totalOrders =
                dashboardService.getTotalOrders();

        double totalSales =
                dashboardService.getTotalSales();

        int lowStockProducts =
                dashboardService.getLowStockProducts();


        // =========================
        // SEND DATA TO JSP
        // =========================

        request.setAttribute(
                "totalProducts",
                totalProducts
        );

        request.setAttribute(
                "totalCustomers",
                totalCustomers
        );

        request.setAttribute(
                "totalOrders",
                totalOrders
        );

        request.setAttribute(
                "totalSales",
                totalSales
        );

        request.setAttribute(
                "lowStockProducts",
                lowStockProducts
        );


        // =========================
        // OPEN DASHBOARD
        // =========================

        request.getRequestDispatcher(
                "/admin/dashboard.jsp"
        ).forward(request, response);
    }
}