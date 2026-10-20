<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shopsphere.model.Order" %>

<%
    Order order = (Order) request.getAttribute("order");

    if (order == null) {
        response.sendRedirect(
            request.getContextPath() + "/admin/orders"
        );
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Order Details - ShopSphere Admin</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .topbar {
            min-height: 68px;
            padding: 0 35px;

            background: #202020;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.18);
        }

        .logo {
            color: white;
            text-decoration: none;
            font-size: 27px;
            font-weight: 800;
        }

        .logo span {
            color: #3b82f6;
        }

        .admin-label {
            color: #d1d5db;
            font-size: 14px;
        }

        .container {
            max-width: 1000px;
            width: 100%;

            margin: 40px auto;
            padding: 0 20px;
        }

        .back-button {
            display: inline-flex;
            align-items: center;

            margin-bottom: 22px;
            padding: 10px 15px;

            background: white;
            color: #2563eb;

            border: 1px solid #dbeafe;
            border-radius: 8px;

            text-decoration: none;
            font-size: 14px;
            font-weight: 700;

            transition: 0.2s ease;
        }

        .back-button:hover {
            background: #eff6ff;
        }

        .page-title {
            margin: 0;
            font-size: 31px;
            color: #111827;
        }

        .subtitle {
            margin: 7px 0 28px;
            color: #6b7280;
            font-size: 14px;
        }

        .card {
            background: white;
            border-radius: 14px;
            padding: 28px;

            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.07);

            margin-bottom: 22px;
        }

        .card-title {
            margin: 0 0 22px;
            font-size: 19px;
            color: #111827;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .info-box {
            padding: 17px;

            background: #f8fafc;
            border: 1px solid #eef0f3;
            border-radius: 9px;
        }

        .info-label {
            color: #6b7280;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 7px;
            text-transform: uppercase;
        }

        .info-value {
            color: #111827;
            font-size: 16px;
            font-weight: 700;
        }

        .amount {
            color: #16a34a;
            font-size: 20px;
        }

        .status-form {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        select {
            min-width: 220px;
            padding: 11px 13px;

            border: 1px solid #d1d5db;
            border-radius: 8px;

            background: white;
            font-size: 14px;
            outline: none;
        }

        select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
        }

        .update-button {
            padding: 11px 18px;

            border: none;
            border-radius: 8px;

            background: #2563eb;
            color: white;

            font-size: 14px;
            font-weight: 700;

            cursor: pointer;

            transition: 0.2s ease;
        }

        .update-button:hover {
            background: #1d4ed8;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;

            padding: 7px 12px;

            border-radius: 20px;

            background: #eff6ff;
            color: #2563eb;

            font-size: 12px;
            font-weight: 800;
        }

        .note {
            margin-top: 14px;
            color: #6b7280;
            font-size: 13px;
        }

        @media (max-width: 650px) {

            .topbar {
                padding: 0 18px;
            }

            .logo {
                font-size: 22px;
            }

            .container {
                margin-top: 25px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 22px;
            }

        }

    </style>

</head>

<body>

    <div class="topbar">

        <a
            href="<%= request.getContextPath() %>/admin/dashboard.jsp"
            class="logo"
        >
            Shop<span>Sphere</span>
        </a>

        <div class="admin-label">
            Admin Panel
        </div>

    </div>


    <div class="container">


        <a
            href="<%= request.getContextPath() %>/admin/orders"
            class="back-button"
        >
            &#8592; Back to Orders
        </a>


        <h1 class="page-title">
            Order #<%= order.getOrderId() %>
        </h1>

        <p class="subtitle">
            View order information and update its status.
        </p>


        <!-- ORDER INFORMATION -->

        <div class="card">

            <h2 class="card-title">
                Order Information
            </h2>


            <div class="info-grid">


                <div class="info-box">

                    <div class="info-label">
                        Order ID
                    </div>

                    <div class="info-value">
                        #<%= order.getOrderId() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Customer ID
                    </div>

                    <div class="info-value">
                        #<%= order.getUserId() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Address ID
                    </div>

                    <div class="info-value">
                        #<%= order.getAddressId() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Total Amount
                    </div>

                    <div class="info-value amount">
                        &#8377;<%= String.format("%.2f", order.getTotalAmount()) %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Order Date
                    </div>

                    <div class="info-value">
                        <%= order.getOrderDate() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Current Status
                    </div>

                    <div class="info-value">

                        <span class="status-badge">
                            <%= order.getStatus() %>
                        </span>

                    </div>

                </div>


            </div>

        </div>


        <!-- UPDATE STATUS -->

        <div class="card">

            <h2 class="card-title">
                Update Order Status
            </h2>


            <form
                method="POST"
                action="<%= request.getContextPath() %>/admin/orders"
                class="status-form"
            >

                <input
                    type="hidden"
                    name="action"
                    value="status"
                >

                <input
                    type="hidden"
                    name="orderId"
                    value="<%= order.getOrderId() %>"
                >


                <select name="status" required>

                    <option value="PLACED"
                        <%= "PLACED".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Placed
                    </option>

                    <option value="CONFIRMED"
                        <%= "CONFIRMED".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Confirmed
                    </option>

                    <option value="SHIPPED"
                        <%= "SHIPPED".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Shipped
                    </option>

                    <option value="OUT_FOR_DELIVERY"
                        <%= "OUT_FOR_DELIVERY".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Out for Delivery
                    </option>

                    <option value="DELIVERED"
                        <%= "DELIVERED".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Delivered
                    </option>

                    <option value="CANCELLED"
                        <%= "CANCELLED".equals(order.getStatus())
                                ? "selected" : "" %>>
                        Cancelled
                    </option>

                </select>


                <button
                    type="submit"
                    class="update-button"
                >
                    Update Status
                </button>

            </form>


            <div class="note">
                Updating the status will also be reflected in the
                customer's order tracking.
            </div>

        </div>


    </div>

</body>

</html>