package com.shopsphere.dao;

import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    // =========================
    // TOTAL PRODUCTS
    // =========================

    public int getTotalProducts() {

        String sql = "SELECT COUNT(*) FROM products WHERE status = TRUE";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================
    // TOTAL CUSTOMERS
    // =========================

    public int getTotalCustomers() {

        String sql =
                "SELECT COUNT(*) FROM users " +
                "WHERE role = 'CUSTOMER'";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================
    // TOTAL ORDERS
    // =========================

    public int getTotalOrders() {

        String sql = "SELECT COUNT(*) FROM orders";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =========================
    // TOTAL SALES
    // =========================

    public double getTotalSales() {

        String sql =
                "SELECT COALESCE(SUM(total_amount), 0) " +
                "FROM orders " +
                "WHERE order_status <> 'CANCELLED'";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }


    // =========================
    // LOW STOCK PRODUCTS
    // =========================

    public int getLowStockProducts() {

        String sql =
                "SELECT COUNT(*) FROM products " +
                "WHERE status = TRUE " +
                "AND stock <= 5";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}