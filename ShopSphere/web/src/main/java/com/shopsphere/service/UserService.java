package com.shopsphere.service;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;

public class UserService {

    private UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public User login(String email, String password) {
        return userDAO.login(email, password);
    }

    public boolean register(User user) {
        return userDAO.register(user);
    }
}