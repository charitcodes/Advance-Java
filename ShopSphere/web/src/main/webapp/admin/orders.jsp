<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Order" %>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    int orderCount =
            orders == null ? 0 : orders.size();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - Admin Orders</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            color: #172033;
            min-height: 100vh;

            background:
                radial-gradient(
                    circle at 0% 0%,
                    rgba(99, 102, 241, 0.10),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 100% 20%,
                    rgba(245, 158, 11, 0.09),
                    transparent 25%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef3ff,
                    #f9fbff
                );
        }


        /* NAVBAR */

        .admin-navbar {
            width: 100%;
            min-height: 68px;
            padding: 0 42px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            background: #202020;

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.18);
        }

        .admin-logo {
            color: white;
            text-decoration: none;

            font-size: 25px;
            font-weight: 800;
        }

        .admin-logo span {
            color: #60a5fa;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-button {
            min-height: 40px;
            padding: 0 15px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            border-radius: 9px;
            text-decoration: none;

            font-size: 13px;
            font-weight: 700;

            transition: all 0.2s ease;
        }

        .dashboard-button {
            color: white;
            border: 1px solid #64748b;
        }

        .dashboard-button:hover {
            color: #202020;
            background: white;
            border-color: white;
        }

        .logout-button {
            color: white;
            background: #dc3545;
            border: 1px solid #dc3545;
        }

        .logout-button:hover {
            background: #bb2d3b;
            border-color: #bb2d3b;
        }


        /* PAGE */

        .orders-page {
            padding: 45px 5% 70px;
        }

        .page-header {
            max-width: 1250px;
            margin: 0 auto 30px;

            display: flex;
            align-items: flex-end;
            justify-content: space-between;

            gap: 25px;
        }

        .small-title {
            display: inline-block;
            margin-bottom: 9px;

            color: #d97706;

            font-size: 12px;
            font-weight: 800;
            letter-spacing: 4px;
        }

        .page-header h1 {
            margin: 0;

            color: #111827;

            font-size: 40px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .page-header p {
            margin: 10px 0 0;

            color: #64748b;
            font-size: 15px;
        }

        .order-count {
            min-width: 120px;
            padding: 14px 18px;

            text-align: center;

            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 14px;

            box-shadow:
                0 8px 22px rgba(30, 41, 59, 0.07);
        }

        .order-count strong {
            display: block;
            color: #d97706;
            font-size: 24px;
        }

        .order-count span {
            color: #64748b;

            font-size: 11px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: 1px;
        }


        /* TABLE */

        .table-card {
            max-width: 1350px;
            margin: 0 auto;

            overflow: hidden;

            background: rgba(255, 255, 255, 0.97);

            border: 1px solid #e5e7eb;
            border-radius: 22px;

            box-shadow:
                0 15px 40px rgba(30, 41, 59, 0.09);
        }

        .table-header {
            padding: 22px 25px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            border-bottom: 1px solid #e5e7eb;
            background: white;
        }

        .table-header h2 {
            margin: 0;

            color: #111827;

            font-size: 19px;
            font-weight: 800;
        }

        .table-header span {
            color: #64748b;
            font-size: 13px;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        thead {
            background: #20242a;
        }

        th {
            padding: 16px 18px;

            color: white;
            text-align: left;

            font-size: 12px;
            font-weight: 800;
            letter-spacing: 0.4px;

            white-space: nowrap;
        }

        td {
            padding: 17px 18px;

            border-bottom: 1px solid #e5e7eb;

            color: #334155;
            font-size: 14px;

            vertical-align: middle;
        }

        tbody tr {
            transition: background 0.15s ease;
        }

        tbody tr:hover {
            background: #fffbeb;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }


        /* ORDER DATA */

        .order-id {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-width: 50px;
            height: 31px;
            padding: 0 10px;

            border-radius: 8px;

            background: #eef2ff;
            color: #4338ca;

            font-size: 12px;
            font-weight: 800;
        }

        .user-id {
            color: #475569;
            font-weight: 700;
        }

        .amount {
            color: #111827;
            font-size: 15px;
            font-weight: 800;
            white-space: nowrap;
        }

        .address-id {
            color: #64748b;
            font-weight: 700;
        }

        .order-date {
            color: #64748b;
            white-space: nowrap;
            font-size: 13px;
        }


        /* STATUS */

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            padding: 7px 11px;

            border-radius: 999px;

            font-size: 11px;
            font-weight: 800;

            white-space: nowrap;

            background: #dcfce7;
            color: #15803d;
        }

        .status::before {
            content: "";

            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: currentColor;
        }


        /* ACTION */

        .view-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            padding: 9px 14px;

            border-radius: 8px;

            background: #eff6ff;
            color: #2563eb;

            border: 1px solid #dbeafe;

            text-decoration: none;

            font-size: 12px;
            font-weight: 800;

            white-space: nowrap;

            transition: 0.2s ease;
        }

        .view-button:hover {
            background: #2563eb;
            color: white;
            border-color: #2563eb;

            transform: translateY(-1px);
        }


        /* EMPTY */

        .empty-state {
            max-width: 1250px;
            margin: 0 auto;

            padding: 70px 30px;

            text-align: center;

            background: white;

            border: 1px solid #e5e7eb;
            border-radius: 22px;

            box-shadow:
                0 15px 40px rgba(30, 41, 59, 0.08);
        }

        .empty-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }

        .empty-state h2 {
            margin: 0 0 8px;
            color: #111827;
        }

        .empty-state p {
            margin: 0;
            color: #64748b;
        }

        .page-footer {
            max-width: 1250px;
            margin: 25px auto 0;

            padding: 18px;

            text-align: center;

            color: #94a3b8;
            font-size: 12px;
        }


        /* RESPONSIVE */

        @media (max-width: 700px) {

            .admin-navbar {
                padding: 0 18px;
            }

            .admin-logo {
                font-size: 20px;
            }

            .dashboard-button {
                display: none;
            }

            .orders-page {
                padding: 32px 15px 50px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .page-header h1 {
                font-size: 34px;
            }

            .order-count {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- NAVBAR -->

<nav class="admin-navbar">

    <a
        href="<%= request.getContextPath() %>/admin/dashboard.jsp"
        class="admin-logo"
    >
        Shop<span>Sphere</span> Admin
    </a>


    <div class="nav-actions">

        <a
            href="<%= request.getContextPath() %>/admin/dashboard.jsp"
            class="nav-button dashboard-button"
        >
            Dashboard
        </a>


        <a
            href="<%= request.getContextPath() %>/logout"
            class="nav-button logout-button"
        >
            Logout
        </a>

    </div>

</nav>


<!-- MAIN -->

<main class="orders-page">


    <!-- HEADER -->

    <div class="page-header">

        <div>

            <div class="small-title">
                ORDER MANAGEMENT
            </div>

            <h1>
                Customer Orders
            </h1>

            <p>
                Monitor customer orders, amounts,
                delivery addresses and current status.
            </p>

        </div>


        <div class="order-count">

            <strong>
                <%= orderCount %>
            </strong>

            <span>
                Orders
            </span>

        </div>

    </div>


    <%
        if (orders != null && !orders.isEmpty()) {
    %>


    <!-- ORDER TABLE -->

    <div class="table-card">


        <div class="table-header">

            <h2>
                Order List
            </h2>

            <span>
                Customer order records
            </span>

        </div>


        <div class="table-responsive">

            <table>

                <thead>

                    <tr>

                        <th>
                            ORDER
                        </th>

                        <th>
                            CUSTOMER
                        </th>

                        <th>
                            TOTAL AMOUNT
                        </th>

                        <th>
                            STATUS
                        </th>

                        <th>
                            ADDRESS
                        </th>

                        <th>
                            ORDER DATE
                        </th>

                        <th>
                            ACTION
                        </th>

                    </tr>

                </thead>


                <tbody>

                <%
                    for (Order order : orders) {
                %>

                    <tr>


                        <td>

                            <span class="order-id">
                                #<%= order.getOrderId() %>
                            </span>

                        </td>


                        <td>

                            <span class="user-id">
                                User #<%= order.getUserId() %>
                            </span>

                        </td>


                        <td>

                            <span class="amount">
                                ₹<%= String.format(
                                    "%.2f",
                                    order.getTotalAmount()
                                ) %>
                            </span>

                        </td>


                        <td>

                            <span class="status">
                                <%= order.getStatus() %>
                            </span>

                        </td>


                        <td>

                            <span class="address-id">
                                Address #<%= order.getAddressId() %>
                            </span>

                        </td>


                        <td>

                            <span class="order-date">
                                <%= order.getOrderDate() %>
                            </span>

                        </td>


                        <td>

                            <a
                                href="<%= request.getContextPath() %>/admin/orders?action=view&id=<%= order.getOrderId() %>"
                                class="view-button"
                            >
                                View Details
                            </a>

                        </td>


                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>


    <%
        } else {
    %>


    <!-- EMPTY -->

    <div class="empty-state">

        <div class="empty-icon">
            🛒
        </div>

        <h2>
            No Customer Orders
        </h2>

        <p>
            There are currently no orders available.
        </p>

    </div>


    <%
        }
    %>


    <div class="page-footer">

        ShopSphere Admin Panel
        &nbsp; • &nbsp;
        Customer Order Management

    </div>


</main>


</body>

</html>