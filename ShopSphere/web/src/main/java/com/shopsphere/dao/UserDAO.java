package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // =========================
    // LOGIN
    // =========================
    public User login(String email, String password) {

        User user = null;

        String sql = "SELECT * FROM users " +
                     "WHERE LOWER(TRIM(email)) = LOWER(TRIM(?)) " +
                     "AND password = SHA2(?, 256) " +
                     "AND status = TRUE";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    user = new User();

                    user.setUserId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setMobile(rs.getString("mobile"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getBoolean("status"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }


    // =========================
    // REGISTER
    // =========================
    public boolean register(User user) {

        String sql = "INSERT INTO users " +
                     "(name, email, password, mobile, role, status) " +
                     "VALUES (?, ?, SHA2(?, 256), ?, 'CUSTOMER', TRUE)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getMobile());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // GET ALL USERS
    // =========================
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT user_id, name, email, mobile, role, status, created_at " +
                     "FROM users " +
                     "ORDER BY user_id DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
}