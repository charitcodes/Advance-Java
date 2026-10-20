<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Product" %>

<%
    List<Product> products =
        (List<Product>) request.getAttribute("lowStockProducts");

    if (products == null) {
        products = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Low Stock Products | ShopSphere Admin</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            color: #172033;
            background: linear-gradient(135deg, #f8fbff, #eef3ff);
            min-height: 100vh;
        }

        .navbar {
            min-height: 68px;
            padding: 0 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #202020;
            box-shadow: 0 4px 15px rgba(0,0,0,.15);
        }

        .logo {
            color: white;
            font-size: 25px;
            font-weight: 800;
            text-decoration: none;
        }

        .logo span {
            color: #60a5fa;
        }

        .nav-actions {
            display: flex;
            gap: 10px;
        }

        .nav-button {
            padding: 11px 15px;
            color: white;
            border: 1px solid #64748b;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
        }

        .nav-button:hover {
            background: white;
            color: #202020;
        }

        .container {
            max-width: 1250px;
            margin: 40px auto;
            padding: 0 22px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
        }

        .eyebrow {
            color: #dc2626;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 3px;
            margin-bottom: 10px;
        }

        h1 {
            margin: 0;
            color: #111827;
            font-size: 34px;
        }

        .subtitle {
            margin: 10px 0 0;
            color: #64748b;
            line-height: 1.6;
        }

        .count-card {
            min-width: 150px;
            padding: 20px;
            background: white;
            border: 1px solid #fecaca;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(30,41,59,.06);
        }

        .count-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
        }

        .count-value {
            color: #dc2626;
            font-size: 30px;
            font-weight: 800;
            margin-top: 8px;
        }

        .notice {
            padding: 15px 18px;
            margin-bottom: 22px;
            border: 1px solid #fecaca;
            border-radius: 12px;
            background: #fff1f2;
            color: #991b1b;
            font-size: 14px;
            line-height: 1.6;
        }

        .table-card {
            overflow: hidden;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            box-shadow: 0 12px 32px rgba(30,41,59,.07);
        }

        .table-heading {
            padding: 22px 24px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-heading h2 {
            margin: 0;
            font-size: 19px;
        }

        .table-heading p {
            margin: 7px 0 0;
            color: #64748b;
            font-size: 13px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 750px;
            border-collapse: collapse;
        }

        th {
            padding: 15px 18px;
            text-align: left;
            background: #f8fafc;
            color: #64748b;
            font-size: 12px;
            letter-spacing: .5px;
            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 17px 18px;
            border-bottom: 1px solid #edf0f4;
            font-size: 14px;
        }

        tbody tr:hover {
            background: #fafbff;
        }

        .product-name {
            font-weight: 700;
            color: #111827;
        }

        .product-brand {
            color: #64748b;
            font-size: 12px;
            margin-top: 5px;
        }

        .stock-badge {
            display: inline-block;
            padding: 7px 11px;
            border-radius: 20px;
            background: #fee2e2;
            color: #b91c1c;
            font-size: 12px;
            font-weight: 800;
        }

        .price {
            font-weight: 700;
            white-space: nowrap;
        }

        .empty-state {
            padding: 60px 20px;
            text-align: center;
        }

        .empty-icon {
            font-size: 42px;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            margin: 0 0 10px;
            color: #166534;
        }

        .empty-state p {
            color: #64748b;
            margin: 0;
        }

        .footer {
            margin-top: 24px;
            padding: 18px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            background: rgba(255,255,255,.7);
            text-align: center;
            color: #64748b;
            font-size: 12px;
        }

        @media (max-width: 650px) {
            .navbar {
                padding: 14px 18px;
                gap: 12px;
                flex-wrap: wrap;
            }

            .logo {
                font-size: 21px;
            }

            .container {
                margin: 28px auto;
                padding: 0 14px;
            }

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }

            h1 {
                font-size: 29px;
            }

            .count-card {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="logo"
       href="<%= request.getContextPath() %>/admin/dashboard">
        Shop<span>Sphere</span> Admin
    </a>

    <div class="nav-actions">
        <a class="nav-button"
           href="<%= request.getContextPath() %>/admin/dashboard">
            Dashboard
        </a>

        <a class="nav-button"
           href="<%= request.getContextPath() %>/logout">
            Logout
        </a>
    </div>
</nav>

<main class="container">

    <div class="page-header">
        <div>
            <div class="eyebrow">INVENTORY MONITORING</div>
            <h1>Low Stock Products</h1>
            <p class="subtitle">
                Review products that need restocking before inventory runs out.
            </p>
        </div>

        <div class="count-card">
            <div class="count-label">PRODUCTS NEEDING ATTENTION</div>
            <div class="count-value"><%= products.size() %></div>
        </div>
    </div>

    <div class="notice">
        <strong>Inventory alert:</strong>
        Products with 5 or fewer units are listed here.
        Review their stock and restock when necessary.
    </div>

    <section class="table-card">

        <div class="table-heading">
            <h2>Inventory Overview</h2>
            <p>Products are ordered from the lowest stock level upwards.</p>
        </div>

        <% if (products.isEmpty()) { %>

            <div class="empty-state">
                <div class="empty-icon">&#9989;</div>
                <h3>Inventory Looks Good!</h3>
                <p>No active products currently have stock of 5 or less.</p>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>PRODUCT ID</th>
                            <th>PRODUCT</th>
                            <th>PRICE</th>
                            <th>AVAILABLE STOCK</th>
                            <th>INVENTORY STATUS</th>
                        </tr>
                    </thead>

                    <tbody>
                    <% for (Product product : products) { %>
                        <tr>
                            <td>#<%= product.getProductId() %></td>

                            <td>
                                <div class="product-name">
                                    <%= product.getName() %>
                                </div>
                                <div class="product-brand">
                                    <%= product.getBrand() == null
                                            ? "No brand"
                                            : product.getBrand() %>
                                </div>
                            </td>

                            <td class="price">
                                &#8377;<%= String.format(
                                        "%,.2f",
                                        product.getPrice()) %>
                            </td>

                            <td>
                                <strong><%= product.getStock() %></strong>
                            </td>

                            <td>
                                <span class="stock-badge">
                                    <%= product.getStock() == 0
                                            ? "Out of Stock"
                                            : "Low Stock" %>
                                </span>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>

    </section>

    <div class="footer">
        ShopSphere Administration Portal
        &nbsp; • &nbsp;
        Inventory Monitoring
    </div>

</main>

</body>
</html>