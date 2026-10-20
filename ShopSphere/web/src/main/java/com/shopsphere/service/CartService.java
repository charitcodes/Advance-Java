package com.shopsphere.service;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.CartItem;

import java.util.List;

public class CartService {

    private CartDAO cartDAO;

    public CartService() {
        cartDAO = new CartDAO();
    }

    public List<CartItem> getCartByUserId(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    public void addToCart(int userId, int productId, int quantity) {
        cartDAO.addToCart(userId, productId, quantity);
    }

    public void removeFromCart(int cartId) {
        cartDAO.removeFromCart(cartId);
    }
}