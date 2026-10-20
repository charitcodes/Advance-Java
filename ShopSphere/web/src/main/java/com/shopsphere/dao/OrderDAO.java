package com.shopsphere.dao;

import com.shopsphere.model.Order;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // GET ORDERS BY USER ID
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_id DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Order order = new Order();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setAddressId(rs.getInt("address_id"));
                    order.setTotalAmount(
                            rs.getDouble("total_amount")
                    );

                    order.setStatus(
                            rs.getString("order_status")
                    );

                    order.setOrderDate(
                            rs.getString("created_at")
                    );

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }


    // GET ALL ORDERS - ADMIN
    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "ORDER BY order_id DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id")
                );

                order.setUserId(
                        rs.getInt("user_id")
                );

                order.setAddressId(
                        rs.getInt("address_id")
                );

                order.setTotalAmount(
                        rs.getDouble("total_amount")
                );

                order.setStatus(
                        rs.getString("order_status")
                );

                order.setOrderDate(
                        rs.getString("created_at")
                );

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }


    // GET ORDER BY ID - ADMIN
    public Order getOrderById(int orderId) {

        Order order = null;

        String sql =
                "SELECT * FROM orders " +
                "WHERE order_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    order = new Order();

                    order.setOrderId(
                            rs.getInt("order_id")
                    );

                    order.setUserId(
                            rs.getInt("user_id")
                    );

                    order.setAddressId(
                            rs.getInt("address_id")
                    );

                    order.setTotalAmount(
                            rs.getDouble("total_amount")
                    );

                    order.setStatus(
                            rs.getString("order_status")
                    );

                    order.setOrderDate(
                            rs.getString("created_at")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return order;
    }


    // UPDATE ORDER STATUS - ADMIN
    public boolean updateOrderStatus(
            int orderId,
            String status) {

        String sql =
                "UPDATE orders SET " +
                "order_status = ? " +
                "WHERE order_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // CREATE ORDER
    public int createOrder(Order order) {

        String sql =
                "INSERT INTO orders " +
                "(user_id, total_amount, address_id, order_status) " +
                "VALUES (?, ?, ?, 'PLACED')";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps =
                connection.prepareStatement(
                    sql,
                    Statement.RETURN_GENERATED_KEYS
                )
        ) {

            ps.setInt(
                    1,
                    order.getUserId()
            );

            ps.setDouble(
                    2,
                    order.getTotalAmount()
            );

            ps.setInt(
                    3,
                    order.getAddressId()
            );

            int result = ps.executeUpdate();

            if (result == 0) {
                return 0;
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}