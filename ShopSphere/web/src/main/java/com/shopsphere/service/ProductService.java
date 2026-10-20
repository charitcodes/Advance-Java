package com.shopsphere.service;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import java.util.List;

public class ProductService {

    private ProductDAO productDAO;

    public ProductService() {
        productDAO = new ProductDAO();
    }

    // =========================
    // GET ALL PRODUCTS
    // =========================
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    // =========================
    // GET PRODUCT BY ID
    // =========================
    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    // =========================
    // ADD PRODUCT
    // =========================
    public boolean addProduct(Product product) {
        return productDAO.addProduct(product);
    }

    // =========================
    // UPDATE PRODUCT
    // =========================
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    // =========================
    // DELETE PRODUCT
    // =========================
    public boolean deleteProduct(int productId) {
        return productDAO.deleteProduct(productId);
    }

    // =========================
    // UPDATE STOCK
    // =========================
    public boolean updateStock(int productId, int stock) {
        return productDAO.updateStock(productId, stock);
    }
    
    public List<Product> getLowStockProducts() {
    return productDAO.getLowStockProducts();
}
}