<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.shopsphere.model.Order" %>
<%@ page import="com.shopsphere.model.OrderItem" %>

<%@ page import="java.util.List" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> orderItems =
            (List<OrderItem>) request.getAttribute("orderItems");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Order Details</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            color: #172033;

            background:
                radial-gradient(
                    circle at 0% 0%,
                    rgba(99, 102, 241, 0.10),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 100% 20%,
                    rgba(59, 130, 246, 0.10),
                    transparent 25%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef3ff,
                    #f9fbff
                );

            min-height: 100vh;
        }

        .page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 45px 20px 70px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .small-title {
            display: inline-block;
            color: #4f46e5;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 4px;
            margin-bottom: 10px;
        }

        .page-header h1 {
            margin: 0;
            font-size: 42px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .page-header p {
            margin: 12px auto 0;
            color: #64748b;
            font-size: 16px;
        }

        .order-card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 30px;
            box-shadow: 0 18px 45px rgba(30, 41, 59, 0.09);
            margin-bottom: 35px;
        }

        .order-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding-bottom: 25px;
            border-bottom: 1px solid #e5e7eb;
        }

        .order-id {
            margin: 0;
            font-size: 28px;
            font-weight: 800;
        }

        .status {
            display: inline-flex;
            align-items: center;
            padding: 9px 18px;
            border-radius: 999px;
            background: #dcfce7;
            color: #15803d;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-top: 25px;
        }

        .info-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px;
        }

        .info-label {
            color: #64748b;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .info-value {
            color: #111827;
            font-size: 20px;
            font-weight: 800;
        }

        .amount {
            color: #2563eb;
        }

        .section-title {
            margin: 0 0 20px;
            font-size: 28px;
            font-weight: 800;
        }

        .items-card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 30px;
            box-shadow: 0 18px 45px rgba(30, 41, 59, 0.09);
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th {
            padding: 16px;
            text-align: left;
            background: #202020;
            color: white;
            font-size: 14px;
        }

        th:first-child {
            border-radius: 10px 0 0 10px;
        }

        th:last-child {
            border-radius: 0 10px 10px 0;
        }

        td {
            padding: 18px 16px;
            border-bottom: 1px solid #e5e7eb;
            font-size: 15px;
            color: #334155;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background: #f8fafc;
        }

        .subtotal {
            color: #111827;
            font-weight: 800;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 14px;
            margin-top: 35px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 46px;
            padding: 0 22px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
            transform: translateY(-2px);
        }

        .btn-pay {
            background: linear-gradient(
                135deg,
                #16a34a,
                #15803d
            );
            color: white;
            box-shadow: 0 8px 18px rgba(22, 163, 74, 0.22);
        }

        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(22, 163, 74, 0.28);
        }

        .empty-items {
            text-align: center;
            padding: 35px;
            color: #64748b;
        }

        @media (max-width: 800px) {

            .page {
                padding: 30px 15px 50px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .order-top {
                flex-direction: column;
                align-items: flex-start;
            }

            .order-info {
                grid-template-columns: 1fr;
            }

            .order-card,
            .items-card {
                padding: 20px;
            }

        }

    </style>

</head>

<body>

    <jsp:include page="fragments/navbar.jspf" />

    <div class="page">

        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE
            </div>

            <h1>
                Order Details
            </h1>

            <p>
                View your order information and purchased items.
            </p>

        </div>


        <%
            if (order != null) {
        %>

        <div class="order-card">

            <div class="order-top">

                <h2 class="order-id">
                    Order #<%= order.getOrderId() %>
                </h2>

                <div class="status">
                    <%= order.getStatus() %>
                </div>

            </div>


            <div class="order-info">

                <div class="info-box">

                    <div class="info-label">
                        Total Amount
                    </div>

                    <div class="info-value amount">
                        ₹<%= order.getTotalAmount() %>
                    </div>

                </div>


                <div class="info-box">

                    <div class="info-label">
                        Address ID
                    </div>

                    <div class="info-value">
                        <%= order.getAddressId() %>
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

            </div>

        </div>


        <div class="items-card">

            <h2 class="section-title">
                Order Items
            </h2>


            <%
                if (orderItems != null && !orderItems.isEmpty()) {
            %>

            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                Order Item ID
                            </th>

                            <th>
                                Product ID
                            </th>

                            <th>
                                Quantity
                            </th>

                            <th>
                                Price
                            </th>

                            <th>
                                Subtotal
                            </th>

                        </tr>

                    </thead>


                    <tbody>

                        <%
                            for (OrderItem item : orderItems) {
                        %>

                        <tr>

                            <td>
                                <%= item.getOrderItemId() %>
                            </td>

                            <td>
                                <%= item.getProductId() %>
                            </td>

                            <td>
                                <%= item.getQuantity() %>
                            </td>

                            <td>
                                ₹<%= item.getPrice() %>
                            </td>

                            <td class="subtotal">
                                ₹<%= item.getPrice() * item.getQuantity() %>
                            </td>

                        </tr>

                        <%
                            }
                        %>

                    </tbody>

                </table>

            </div>

            <%
                } else {
            %>

            <div class="empty-items">

                No items found for this order.

            </div>

            <%
                }
            %>


            <div class="actions">

                <a
                    href="/ShopSphere/orders"
                    class="btn btn-back">

                    ← Back to My Orders

                </a>


                <a
                    href="/ShopSphere/payment?orderId=<%= order.getOrderId() %>"
                    class="btn btn-pay">

                    💳 Pay Now

                </a>

            </div>

        </div>

        <%
            } else {
        %>

        <div class="items-card">

            <div class="empty-items">

                <h2>
                    Order Not Found
                </h2>

                <p>
                    The requested order could not be found.
                </p>

                <div class="actions">

                    <a
                        href="/ShopSphere/orders"
                        class="btn btn-back">

                        ← Back to My Orders

                    </a>

                </div>

            </div>

        </div>

        <%
            }
        %>

    </div>

</body>

</html>