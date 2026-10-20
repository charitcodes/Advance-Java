package com.shopsphere.dao;

import com.shopsphere.model.Payment;
import com.shopsphere.util.DBConnection;

import java.sql.*;

public class PaymentDAO {

    public void addPayment(Payment payment) {

        String sql = "INSERT INTO payments " +
                     "(order_id, payment_method, transaction_reference, amount) " +
                     "VALUES (?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setString(3, payment.getTransactionId());
            ps.setDouble(4, payment.getAmount());

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();

        }
    }


    public Payment getPaymentByOrderId(int orderId) {

        Payment payment = null;

        String sql = "SELECT * FROM payments WHERE order_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    payment = new Payment();

                    payment.setPaymentId(
                        rs.getInt("payment_id")
                    );

                    payment.setOrderId(
                        rs.getInt("order_id")
                    );

                    payment.setPaymentMethod(
                        rs.getString("payment_method")
                    );

                    payment.setTransactionId(
                        rs.getString("transaction_reference")
                    );

                    payment.setAmount(
                        rs.getDouble("amount")
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return payment;
    }
}