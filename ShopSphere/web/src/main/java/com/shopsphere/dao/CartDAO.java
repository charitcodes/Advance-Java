package com.shopsphere.dao;

import com.shopsphere.model.CartItem;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<CartItem> getCartByUserId(int userId) {

        List<CartItem> cartItems = new ArrayList<>();

        String sql =
                "SELECT * FROM cart " +
                "WHERE user_id = ? " +
                "ORDER BY cart_id";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    CartItem item = new CartItem();

                    item.setCartId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));

                    cartItems.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }


    public void addToCart(int userId, int productId, int quantity) {

        String findSql =
                "SELECT cart_id, quantity " +
                "FROM cart " +
                "WHERE user_id = ? AND product_id = ? " +
                "ORDER BY cart_id " +
                "LIMIT 1";

        String updateSql =
                "UPDATE cart " +
                "SET quantity = ? " +
                "WHERE cart_id = ?";

        String deleteDuplicateSql =
                "DELETE FROM cart " +
                "WHERE user_id = ? " +
                "AND product_id = ? " +
                "AND cart_id <> ?";

        String insertSql =
                "INSERT INTO cart " +
                "(user_id, product_id, quantity) " +
                "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            int cartId = 0;
            int existingQuantity = 0;

            try (PreparedStatement ps =
                         connection.prepareStatement(findSql)) {

                ps.setInt(1, userId);
                ps.setInt(2, productId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {

                        cartId = rs.getInt("cart_id");
                        existingQuantity = rs.getInt("quantity");
                    }
                }
            }

            if (cartId > 0) {

                int newQuantity =
                        existingQuantity + quantity;

                try (PreparedStatement ps =
                             connection.prepareStatement(updateSql)) {

                    ps.setInt(1, newQuantity);
                    ps.setInt(2, cartId);

                    ps.executeUpdate();
                }

                try (PreparedStatement ps =
                             connection.prepareStatement(deleteDuplicateSql)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, productId);
                    ps.setInt(3, cartId);

                    ps.executeUpdate();
                }

            } else {

                try (PreparedStatement ps =
                             connection.prepareStatement(insertSql)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, productId);
                    ps.setInt(3, quantity);

                    ps.executeUpdate();
                }
            }

            connection.commit();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }


    public void removeFromCart(int cartId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE cart_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            ps.setInt(1, cartId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // Clear all cart items for a user
    public void clearCartByUserId(int userId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE user_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}