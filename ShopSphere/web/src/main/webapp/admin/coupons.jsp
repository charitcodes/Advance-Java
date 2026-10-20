<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Coupon" %>

<%
    List<Coupon> coupons =
            (List<Coupon>) request.getAttribute("coupons");

    if (coupons == null) {
        coupons = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Coupon Management - ShopSphere</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #222;
        }

        .header {
            background: #202020;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
        }

        .header span {
            color: #3b82f6;
        }

        .admin-label {
            font-size: 14px;
            color: #ddd;
        }

        .container {
            max-width: 1250px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .top-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .title h2 {
            margin: 0 0 7px;
            font-size: 28px;
        }

        .title p {
            margin: 0;
            color: #666;
        }

        .add-button {
            background: #198754;
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 7px;
            font-weight: 600;
            font-size: 14px;
        }

        .add-button:hover {
            background: #157347;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 25px;
        }

        .summary-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .summary-card .label {
            color: #666;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .summary-card .value {
            font-size: 26px;
            font-weight: 700;
        }

        .table-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
        }

        .table-header {
            padding: 20px 22px;
            border-bottom: 1px solid #eee;
        }

        .table-header h3 {
            margin: 0;
            font-size: 18px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 900px;
        }

        th {
            background: #f8f9fa;
            padding: 14px 16px;
            text-align: left;
            font-size: 13px;
            color: #555;
            border-bottom: 1px solid #ddd;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }

        tr:hover {
            background: #fafafa;
        }

        .code {
            font-weight: 700;
            color: #3b82f6;
        }

        .discount {
            font-weight: 700;
        }

        .badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .active {
            background: #d1e7dd;
            color: #0f5132;
        }

        .inactive {
            background: #f8d7da;
            color: #842029;
        }

        .actions {
            display: flex;
            gap: 7px;
            align-items: center;
        }

        .action-button {
            display: inline-block;
            padding: 7px 11px;
            border-radius: 6px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }

        .edit-button {
            background: #0d6efd;
            color: white;
        }

        .edit-button:hover {
            background: #0b5ed7;
        }

        .delete-button {
            background: #dc3545;
            color: white;
        }

        .delete-button:hover {
            background: #bb2d3b;
        }

        .status-button {
            background: #6c757d;
            color: white;
        }

        .status-button:hover {
            background: #5c636a;
        }

        .empty {
            text-align: center;
            padding: 50px 20px;
            color: #777;
        }

        .empty h3 {
            margin-bottom: 8px;
            color: #444;
        }

        .footer-buttons {
            margin-top: 25px;
            display: flex;
            gap: 10px;
        }

        .back-button,
        .logout-button {
            text-decoration: none;
            padding: 10px 16px;
            border-radius: 7px;
            font-size: 13px;
            font-weight: 600;
        }

        .back-button {
            background: #343a40;
            color: white;
        }

        .logout-button {
            background: #dc3545;
            color: white;
        }

        @media(max-width: 750px) {

            .header {
                padding: 18px;
            }

            .container {
                margin-top: 25px;
            }

            .top-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .summary {
                grid-template-columns: 1fr;
            }

            .add-button {
                width: 100%;
                text-align: center;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <h1>
        Shop<span>Sphere</span>
    </h1>

    <div class="admin-label">
        Admin Panel
    </div>

</div>


<div class="container">


    <!-- TOP SECTION -->

    <div class="top-section">

        <div class="title">

            <h2>Coupon Management</h2>

            <p>
                Create and manage customer discount coupons.
            </p>

        </div>

        <a
            href="<%= request.getContextPath() %>/admin/coupons?action=add"
            class="add-button">

            + Add New Coupon

        </a>

    </div>


    <!-- SUMMARY -->

    <%
        int totalCoupons = coupons.size();
        int activeCoupons = 0;
        int inactiveCoupons = 0;

        for (Coupon coupon : coupons) {

            if (coupon.isStatus()) {
                activeCoupons++;
            } else {
                inactiveCoupons++;
            }
        }
    %>


    <div class="summary">

        <div class="summary-card">

            <div class="label">
                Total Coupons
            </div>

            <div class="value">
                <%= totalCoupons %>
            </div>

        </div>


        <div class="summary-card">

            <div class="label">
                Active Coupons
            </div>

            <div class="value">
                <%= activeCoupons %>
            </div>

        </div>


        <div class="summary-card">

            <div class="label">
                Inactive Coupons
            </div>

            <div class="value">
                <%= inactiveCoupons %>
            </div>

        </div>

    </div>


    <!-- COUPON TABLE -->

    <div class="table-card">

        <div class="table-header">

            <h3>
                All Coupons
            </h3>

        </div>


        <% if (coupons.isEmpty()) { %>

            <div class="empty">

                <h3>No Coupons Found</h3>

                <p>
                    Create your first coupon using the
                    "Add New Coupon" button.
                </p>

            </div>

        <% } else { %>


            <div class="table-wrapper">

                <table>

                    <thead>

                    <tr>

                        <th>ID</th>

                        <th>CODE</th>

                        <th>TYPE</th>

                        <th>DISCOUNT</th>

                        <th>MINIMUM ORDER</th>

                        <th>MAX DISCOUNT</th>

                        <th>EXPIRY DATE</th>

                        <th>STATUS</th>

                        <th>ACTION</th>

                    </tr>

                    </thead>


                    <tbody>

                    <% for (Coupon coupon : coupons) { %>

                        <tr>

                            <td>
                                <%= coupon.getCouponId() %>
                            </td>


                            <td class="code">
                                <%= coupon.getCode() %>
                            </td>


                            <td>
                                <%= coupon.getDiscountType() %>
                            </td>


                            <td class="discount">

                                <%
                                    if ("PERCENTAGE".equalsIgnoreCase(
                                            coupon.getDiscountType())) {
                                %>

                                    <%= String.format(
                                            "%.2f",
                                            coupon.getDiscountValue()
                                    ) %>%

                                <%
                                    } else {
                                %>

                                    &#8377;<%= String.format(
                                            "%.2f",
                                            coupon.getDiscountValue()
                                    ) %>

                                <%
                                    }
                                %>

                            </td>


                            <td>

                                &#8377;<%= String.format(
                                        "%.2f",
                                        coupon.getMinimumOrder()
                                ) %>

                            </td>


                            <td>

                                <% if (coupon.getMaximumDiscount() > 0) { %>

                                    &#8377;<%= String.format(
                                            "%.2f",
                                            coupon.getMaximumDiscount()
                                    ) %>

                                <% } else { %>

                                    No Limit

                                <% } %>

                            </td>


                            <td>

                                <%= coupon.getExpiryDate() == null
                                        ? "No Expiry"
                                        : coupon.getExpiryDate() %>

                            </td>


                            <td>

                                <% if (coupon.isStatus()) { %>

                                    <span class="badge active">
                                        Active
                                    </span>

                                <% } else { %>

                                    <span class="badge inactive">
                                        Inactive
                                    </span>

                                <% } %>

                            </td>


                            <td>

                                <div class="actions">


                                    <!-- EDIT -->

                                    <a
                                        href="<%= request.getContextPath() %>/admin/coupons?action=edit&id=<%= coupon.getCouponId() %>"
                                        class="action-button edit-button">

                                        Edit

                                    </a>


                                    <!-- STATUS -->

                                    <form
                                        method="post"
                                        action="<%= request.getContextPath() %>/admin/coupons"
                                        style="display:inline;">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="status">

                                        <input
                                            type="hidden"
                                            name="couponId"
                                            value="<%= coupon.getCouponId() %>">

                                        <input
                                            type="hidden"
                                            name="status"
                                            value="<%= !coupon.isStatus() %>">

                                        <button
                                            type="submit"
                                            class="action-button status-button">

                                            <%= coupon.isStatus()
                                                    ? "Disable"
                                                    : "Enable" %>

                                        </button>

                                    </form>


                                    <!-- DELETE -->

                                    <form
                                        method="post"
                                        action="<%= request.getContextPath() %>/admin/coupons"
                                        style="display:inline;"
                                        onsubmit="return confirm('Are you sure you want to delete this coupon?');">

                                        <input
                                            type="hidden"
                                            name="action"
                                            value="delete">

                                        <input
                                            type="hidden"
                                            name="couponId"
                                            value="<%= coupon.getCouponId() %>">

                                        <button
                                            type="submit"
                                            class="action-button delete-button">

                                            Delete

                                        </button>

                                    </form>


                                </div>

                            </td>

                        </tr>

                    <% } %>

                    </tbody>

                </table>

            </div>

        <% } %>

    </div>


    <!-- FOOTER BUTTONS -->

    <div class="footer-buttons">

        <a
            href="<%= request.getContextPath() %>/admin/dashboard.jsp"
            class="back-button">

            ← Dashboard

        </a>

        <a href="${pageContext.request.contextPath}/logout"
   class="btn btn-danger">
    Logout
</a>

    </div>


</div>

</body>
</html>