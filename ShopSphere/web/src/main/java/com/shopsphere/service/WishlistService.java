package com.shopsphere.service;

import com.shopsphere.dao.WishlistDAO;
import com.shopsphere.model.WishlistItem;

import java.util.List;

public class WishlistService {

    private WishlistDAO wishlistDAO;

    public WishlistService() {
        wishlistDAO = new WishlistDAO();
    }

    public List<WishlistItem> getWishlistByUserId(int userId) {
        return wishlistDAO.getWishlistByUserId(userId);
    }

    public void addToWishlist(int userId, int productId) {
        wishlistDAO.addToWishlist(userId, productId);
    }

    public void removeFromWishlist(int wishlistId) {
        wishlistDAO.removeFromWishlist(wishlistId);
    }
}