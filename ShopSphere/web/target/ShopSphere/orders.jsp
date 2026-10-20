<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.shopsphere.model.Order" %>
<%@ page import="java.util.List" %>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - My Orders</title>

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
            max-width: 1250px;
            margin: 0 auto;
            padding: 45px 20px 70px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 40px;
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

        .orders-card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 18px 45px rgba(30, 41, 59, 0.09);
        }

        .orders-count {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 25px;
        }

        .orders-count h2 {
            margin: 0;
            font-size: 24px;
        }

        .count-badge {
            padding: 8px 14px;
            border-radius: 999px;
            background: #eef2ff;
            color: #4f46e5;
            font-size: 13px;
            font-weight: 800;
        }

        .orders-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 20px;
        }

        .order-item {
            position: relative;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 22px;
            transition: all 0.25s ease;
        }

        .order-item:hover {
            transform: translateY(-5px);
            border-color: #c7d2fe;
            box-shadow: 0 15px 35px rgba(30, 41, 59, 0.10);
        }

        .order-item-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            padding-bottom: 18px;
            border-bottom: 1px solid #e5e7eb;
        }

        .order-number {
            margin: 0;
            font-size: 21px;
            font-weight: 800;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 13px;
            border-radius: 999px;
            background: #dcfce7;
            color: #15803d;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .order-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-top: 20px;
        }

        .info-box {
            background: #f8fafc;
            border-radius: 14px;
            padding: 14px;
        }

        .info-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .info-value {
            color: #111827;
            font-size: 16px;
            font-weight: 800;
        }

        .amount {
            color: #2563eb;
            font-size: 19px;
        }

        .order-date {
            font-size: 13px;
            line-height: 1.4;
        }

        .order-action {
            margin-top: 20px;
        }

        .view-button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            min-height: 45px;
            border-radius: 12px;
            text-decoration: none;
            color: white;
            background: linear-gradient(
                135deg,
                #2563eb,
                #4f46e5
            );
            font-size: 14px;
            font-weight: 700;
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
            transition: all 0.2s ease;
        }

        .view-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(37, 99, 235, 0.28);
        }

        .empty-orders {
            text-align: center;
            padding: 65px 25px;
        }

        .empty-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #eef2ff;
            font-size: 38px;
        }

        .empty-orders h2 {
            margin: 0 0 10px;
            font-size: 27px;
        }

        .empty-orders p {
            margin: 0 0 25px;
            color: #64748b;
        }

        .shop-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 45px;
            padding: 0 22px;
            border-radius: 12px;
            text-decoration: none;
            color: white;
            background: linear-gradient(
                135deg,
                #2563eb,
                #4f46e5
            );
            font-size: 14px;
            font-weight: 700;
        }

        @media (max-width: 850px) {

            .orders-grid {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 600px) {

            .page {
                padding: 30px 15px 50px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .orders-card {
                padding: 18px;
            }

            .order-item-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .order-info {
                grid-template-columns: 1fr;
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
                My Orders
            </h1>

            <p>
                Track and manage all your ShopSphere orders in one place.
            </p>

        </div>


        <div class="orders-card">

            <%
                if (orders != null && !orders.isEmpty()) {
            %>

            <div class="orders-count">

                <h2>
                    Your Orders
                </h2>

                <div class="count-badge">
                    <%= orders.size() %>
                    Order<%= orders.size() == 1 ? "" : "s" %>
                </div>

            </div>


            <div class="orders-grid">

                <%
                    for (Order order : orders) {
                %>

                <div class="order-item">

                    <div class="order-item-top">

                        <h3 class="order-number">
                            Order #<%= order.getOrderId() %>
                        </h3>

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

                            <div class="info-value order-date">
                                <%= order.getOrderDate() %>
                            </div>

                        </div>


                        <div class="info-box">

                            <div class="info-label">
                                Order Status
                            </div>

                            <div class="info-value">
                                <%= order.getStatus() %>
                            </div>

                        </div>

                    </div>


                    <div class="order-action">

                        <a
                            href="/ShopSphere/orders?id=<%= order.getOrderId() %>"
                            class="view-button">

                            View Order Details →

                        </a>

                    </div>

                </div>

                <%
                    }
                %>

            </div>

            <%
                } else {
            %>


            <div class="empty-orders">

                <div class="empty-icon">
                    📦
                </div>

                <h2>
                    No Orders Yet
                </h2>

                <p>
                    You haven't placed any orders yet.
                    Start shopping and your orders will appear here.
                </p>

                <a
                    href="/ShopSphere/products"
                    class="shop-button">

                    Start Shopping

                </a>

            </div>


            <%
                }
            %>

        </div>

    </div>

</body>

</html>