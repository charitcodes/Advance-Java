package com.shopsphere.dao;

import com.shopsphere.model.Category;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // GET ALL CATEGORIES
    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();

        String sql =
                "SELECT * FROM categories " +
                "ORDER BY category_id";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(
                        rs.getInt("category_id")
                );

                category.setName(
                        rs.getString("name")
                );

                category.setDescription(
                        rs.getString("description")
                );

                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }


    // GET CATEGORY BY ID
    public Category getCategoryById(int categoryId) {

        Category category = null;

        String sql =
                "SELECT * FROM categories " +
                "WHERE category_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    category = new Category();

                    category.setCategoryId(
                            rs.getInt("category_id")
                    );

                    category.setName(
                            rs.getString("name")
                    );

                    category.setDescription(
                            rs.getString("description")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }


    // ADD CATEGORY
    public boolean addCategory(Category category) {

        String sql =
                "INSERT INTO categories " +
                "(name, description) " +
                "VALUES (?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // UPDATE CATEGORY
    public boolean updateCategory(Category category) {

        String sql =
                "UPDATE categories SET " +
                "name = ?, " +
                "description = ? " +
                "WHERE category_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // DELETE CATEGORY
    public boolean deleteCategory(int categoryId) {

        String sql =
                "DELETE FROM categories " +
                "WHERE category_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}