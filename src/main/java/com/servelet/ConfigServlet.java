package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/config")
public class ConfigServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        ServletConfig config = getServletConfig();
        String name = config.getInitParameter("name");

        System.out.println("Name: " + name);
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<h1>ServletConfig Example</h1>");
        out.println("<p>Servlet is running successfully.</p>");
    }
}