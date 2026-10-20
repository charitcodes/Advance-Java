package com.shopsphere.controller;

import com.shopsphere.dao.AddressDAO;
import com.shopsphere.dao.CartDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.dao.OrderItemDAO;
import com.shopsphere.dao.ProductDAO;

import com.shopsphere.model.Address;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.model.Product;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private CartDAO cartDAO;
    private ProductDAO productDAO;
    private AddressDAO addressDAO;
    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() {

        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
        addressDAO = new AddressDAO();
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        User user =
                (User) session.getAttribute("user");

        try {

            List<CartItem> cartItems =
                    cartDAO.getCartByUserId(
                            user.getUserId());

            double totalAmount = 0;

            for (CartItem cartItem : cartItems) {

                Product product =
                        productDAO.getProductById(
                                cartItem.getProductId());

                if (product != null) {

                    totalAmount +=
                            product.getPrice()
                            * cartItem.getQuantity();
                }
            }

            List<Address> addresses =
                    addressDAO.getAddressesByUserId(
                            user.getUserId());

            request.setAttribute(
                    "cartItems",
                    cartItems);

            request.setAttribute(
                    "totalAmount",
                    totalAmount);

            request.setAttribute(
                    "addresses",
                    addresses);

            request.getRequestDispatcher(
                    "/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to load checkout page.");

            request.getRequestDispatcher(
                    "/checkout.jsp")
                    .forward(request, response);
        }
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        User user =
                (User) session.getAttribute("user");

        try {

            int addressId =
                    Integer.parseInt(
                            request.getParameter("addressId"));


            // Verify address belongs to logged-in user
            List<Address> addresses =
                    addressDAO.getAddressesByUserId(
                            user.getUserId());

            boolean validAddress = false;

            for (Address address : addresses) {

                if (address.getAddressId() == addressId) {

                    validAddress = true;
                    break;
                }
            }

            if (!validAddress) {

                request.setAttribute(
                        "error",
                        "Please select a valid address.");

                doGet(request, response);

                return;
            }


            // Get current cart
            List<CartItem> cartItems =
                    cartDAO.getCartByUserId(
                            user.getUserId());

            if (cartItems == null ||
                    cartItems.isEmpty()) {

                request.setAttribute(
                        "error",
                        "Your cart is empty.");

                doGet(request, response);

                return;
            }


            // Calculate total from database
            double totalAmount = 0;

            for (CartItem cartItem : cartItems) {

                Product product =
                        productDAO.getProductById(
                                cartItem.getProductId());

                if (product != null) {

                    totalAmount +=
                            product.getPrice()
                            * cartItem.getQuantity();
                }
            }


            // Create order
            Order order = new Order();

            order.setUserId(
                    user.getUserId());

            order.setTotalAmount(
                    totalAmount);

            order.setStatus(
                    "PLACED");

            order.setAddressId(
                    addressId);

            int orderId =
                    orderDAO.createOrder(order);


            if (orderId <= 0) {

                throw new Exception(
                        "Order could not be created.");
            }


            // Create order items
            for (CartItem cartItem : cartItems) {

                Product product =
                        productDAO.getProductById(
                                cartItem.getProductId());

                if (product != null) {

                    OrderItem orderItem =
                            new OrderItem();

                    orderItem.setOrderId(
                            orderId);

                    orderItem.setProductId(
                            cartItem.getProductId());

                    orderItem.setQuantity(
                            cartItem.getQuantity());

                    orderItem.setPrice(
                            product.getPrice());

                    orderItemDAO.addOrderItem(
                            orderItem);
                }
            }


            // Clear cart after successful order
            cartDAO.clearCartByUserId(
                    user.getUserId());


            // Open order details
            response.sendRedirect(
                    request.getContextPath()
                    + "/orders?id="
                    + orderId);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to place order. Please try again.");

            doGet(request, response);
        }
    }
}