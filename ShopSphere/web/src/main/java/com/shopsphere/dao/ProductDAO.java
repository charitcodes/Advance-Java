package com.shopsphere.dao;

import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // =========================
    // GET ALL ACTIVE PRODUCTS
    // =========================
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products WHERE status = 1 ORDER BY product_id";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setDiscount(rs.getDouble("discount"));
                product.setStock(rs.getInt("stock"));
                product.setImage(rs.getString("image_url"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // =========================
    // GET PRODUCT BY ID
    // =========================
    public Product getProductById(int productId) {

        Product product = null;

        String sql =
                "SELECT * FROM products " +
                "WHERE product_id = ? AND status = 1";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    product = new Product();

                    product.setProductId(rs.getInt("product_id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setBrand(rs.getString("brand"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDiscount(rs.getDouble("discount"));
                    product.setStock(rs.getInt("stock"));
                    product.setImage(rs.getString("image_url"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return product;
    }


    // =========================
    // ADD PRODUCT
    // =========================
    public boolean addProduct(Product product) {

        String sql =
                "INSERT INTO products " +
                "(category_id, name, brand, description, price, discount, stock, image_url, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 1)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getBrand());
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getPrice());
            ps.setDouble(6, product.getDiscount());
            ps.setInt(7, product.getStock());
            ps.setString(8, product.getImage());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================
    // UPDATE PRODUCT
    // =========================
    public boolean updateProduct(Product product) {

        String sql =
                "UPDATE products SET " +
                "category_id = ?, " +
                "name = ?, " +
                "brand = ?, " +
                "description = ?, " +
                "price = ?, " +
                "discount = ?, " +
                "stock = ?, " +
                "image_url = ? " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getBrand());
            ps.setString(4, product.getDescription());
            ps.setDouble(5, product.getPrice());
            ps.setDouble(6, product.getDiscount());
            ps.setInt(7, product.getStock());
            ps.setString(8, product.getImage());
            ps.setInt(9, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================
    // DELETE PRODUCT
    // =========================
    public boolean deleteProduct(int productId) {

        /*
         * Soft delete:
         * status = 0 means the product is hidden
         * from the customer side.
         */
        String sql =
                "UPDATE products SET status = 0 " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================
    // UPDATE STOCK
    // =========================
    public boolean updateStock(int productId, int stock) {

        String sql =
                "UPDATE products SET stock = ? " +
                "WHERE product_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, stock);
            ps.setInt(2, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Product> getLowStockProducts() {

    List<Product> products = new ArrayList<>();

    String sql =
            "SELECT * FROM products " +
            "WHERE status = TRUE " +
            "AND stock <= 5 " +
            "ORDER BY stock ASC";

    try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
    ) {

        while (rs.next()) {

            Product product = new Product();

            product.setProductId(
                    rs.getInt("product_id")
            );

            product.setCategoryId(
                    rs.getInt("category_id")
            );

            product.setName(
                    rs.getString("name")
            );

            product.setBrand(
                    rs.getString("brand")
            );

            product.setDescription(
                    rs.getString("description")
            );

            product.setPrice(
                    rs.getDouble("price")
            );

            product.setDiscount(
                    rs.getDouble("discount")
            );

            product.setStock(
                    rs.getInt("stock")
            );

            product.setImage(
        rs.getString("image_url")
);

            products.add(product);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return products;
}
}
