package com.shopsphere.filter;

import com.shopsphere.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/admin/*"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        String path = httpRequest.getServletPath();

        HttpSession session =
                httpRequest.getSession(false);

        User admin = null;

        if (session != null) {
            admin = (User) session.getAttribute("admin");
        }

        // Admin login page should be accessible without login
        if ("/admin/login".equals(path)) {
            chain.doFilter(request, response);
            return;
        }

        // All other admin pages require ADMIN login
        if (admin == null || !"ADMIN".equals(admin.getRole())) {

            httpResponse.sendRedirect(
                    httpRequest.getContextPath() + "/admin/login"
            );

            return;
        }

        chain.doFilter(request, response);
    }
}