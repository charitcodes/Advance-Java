package com.shopsphere.dao;

import com.shopsphere.model.WishlistItem;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public List<WishlistItem> getWishlistByUserId(int userId) {

        List<WishlistItem> items = new ArrayList<>();

        String sql =
                "SELECT * FROM wishlist " +
                "WHERE user_id = ? " +
                "ORDER BY wishlist_id DESC";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    WishlistItem item = new WishlistItem();

                    item.setWishlistId(
                            rs.getInt("wishlist_id"));

                    item.setUserId(
                            rs.getInt("user_id"));

                    item.setProductId(
                            rs.getInt("product_id"));

                    items.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }


    public boolean addToWishlist(int userId, int productId) {

        // Check whether product is already in wishlist
        String checkSql =
                "SELECT wishlist_id FROM wishlist " +
                "WHERE user_id = ? AND product_id = ?";

        String insertSql =
                "INSERT INTO wishlist " +
                "(user_id, product_id) " +
                "VALUES (?, ?)";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement checkPs =
                        connection.prepareStatement(checkSql)
        ) {

            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);

            try (ResultSet rs = checkPs.executeQuery()) {

                if (rs.next()) {
                    // Already exists
                    return true;
                }
            }

            try (
                    PreparedStatement insertPs =
                            connection.prepareStatement(insertSql)
            ) {

                insertPs.setInt(1, userId);
                insertPs.setInt(2, productId);

                int rows = insertPs.executeUpdate();

                return rows > 0;
            }

        } catch (Exception e) {

            System.out.println(
                    "Wishlist insert failed: " +
                    e.getMessage()
            );

            e.printStackTrace();

            return false;
        }
    }


    public boolean removeFromWishlist(int wishlistId) {

        String sql =
                "DELETE FROM wishlist " +
                "WHERE wishlist_id = ?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps =
                        connection.prepareStatement(sql)
        ) {

            ps.setInt(1, wishlistId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}