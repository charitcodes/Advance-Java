package com.shopsphere.service;

import com.shopsphere.dao.DashboardDAO;

public class DashboardService {

    private DashboardDAO dashboardDAO;

    public DashboardService() {
        dashboardDAO = new DashboardDAO();
    }


    public int getTotalProducts() {
        return dashboardDAO.getTotalProducts();
    }


    public int getTotalCustomers() {
        return dashboardDAO.getTotalCustomers();
    }


    public int getTotalOrders() {
        return dashboardDAO.getTotalOrders();
    }


    public double getTotalSales() {
        return dashboardDAO.getTotalSales();
    }


    public int getLowStockProducts() {
        return dashboardDAO.getLowStockProducts();
    }
}