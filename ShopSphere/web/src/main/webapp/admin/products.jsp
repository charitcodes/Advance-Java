<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Product" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ShopSphere - Admin Products</title>

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
                    rgba(59, 130, 246, 0.10),
                    transparent 25%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef3ff,
                    #f9fbff
                );
        }


        /* =========================
           NAVBAR
        ========================= */

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


        /* =========================
           MAIN
        ========================= */

        .products-page {
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


        .header-left {
            flex: 1;
        }


        .small-title {
            display: inline-block;
            margin-bottom: 9px;

            color: #4f46e5;

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


        /* =========================
           HEADER ACTIONS
        ========================= */

        .header-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }


        .product-count {
            min-width: 120px;
            padding: 14px 18px;

            text-align: center;

            background: white;

            border: 1px solid #e5e7eb;
            border-radius: 14px;

            box-shadow:
                0 8px 22px rgba(30, 41, 59, 0.07);
        }


        .product-count strong {
            display: block;

            color: #2563eb;
            font-size: 24px;
        }


        .product-count span {
            color: #64748b;

            font-size: 11px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: 1px;
        }


        /* =========================
           ADD PRODUCT BUTTON
        ========================= */

        .add-product-button {
            min-height: 48px;

            padding: 0 20px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            background: #2563eb;
            color: white;

            border: 1px solid #2563eb;
            border-radius: 10px;

            text-decoration: none;

            font-size: 14px;
            font-weight: 800;

            white-space: nowrap;

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.22);

            transition: all 0.2s ease;
        }


        .add-product-button:hover {
            background: #1d4ed8;
            border-color: #1d4ed8;

            transform: translateY(-1px);

            box-shadow:
                0 10px 22px rgba(37, 99, 235, 0.28);
        }


        /* =========================
           TABLE CARD
        ========================= */

        .table-card {
            max-width: 1250px;
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
            background: #ffffff;
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

            min-width: 1050px;
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
            padding: 16px 18px;

            border-bottom: 1px solid #e5e7eb;

            color: #334155;

            font-size: 14px;

            vertical-align: middle;
        }


        tbody tr {
            transition: background 0.15s ease;
        }


        tbody tr:hover {
            background: #f8fafc;
        }


        tbody tr:last-child td {
            border-bottom: none;
        }


        /* =========================
           PRODUCT DATA
        ========================= */

        .product-id {
            color: #64748b;
            font-weight: 700;
        }


        .product-name {
            color: #111827;
            font-weight: 800;
        }


        .brand {
            color: #64748b;
            font-weight: 600;
        }


        .category-id {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            min-width: 34px;
            height: 28px;

            padding: 0 8px;

            border-radius: 8px;

            background: #eef2ff;
            color: #4338ca;

            font-size: 12px;
            font-weight: 800;
        }


        .price {
            color: #111827;

            font-size: 15px;
            font-weight: 800;

            white-space: nowrap;
        }


        .discount {
            display: inline-flex;

            align-items: center;

            padding: 6px 9px;

            border-radius: 999px;

            background: #dcfce7;
            color: #15803d;

            font-size: 11px;
            font-weight: 800;
        }


        .no-discount {
            color: #94a3b8;

            font-size: 12px;
            font-weight: 600;
        }


        .stock {
            display: inline-flex;

            align-items: center;

            padding: 6px 10px;

            border-radius: 999px;

            font-size: 11px;
            font-weight: 800;
        }


        .stock-good {
            background: #dcfce7;
            color: #15803d;
        }


        .stock-low {
            background: #fef3c7;
            color: #b45309;
        }


        .stock-out {
            background: #fee2e2;
            color: #dc2626;
        }


        /* =========================
           ACTION BUTTONS
        ========================= */

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 7px;
            white-space: nowrap;
        }


        .action-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            min-height: 34px;

            padding: 0 11px;

            border-radius: 7px;

            text-decoration: none;

            font-size: 12px;
            font-weight: 700;

            border: none;

            cursor: pointer;
        }


        .edit-button {
            background: #dbeafe;
            color: #1d4ed8;
        }


        .edit-button:hover {
            background: #bfdbfe;
        }


        .delete-button {
            background: #fee2e2;
            color: #dc2626;
        }


        .delete-button:hover {
            background: #fecaca;
        }


        .stock-button {
            background: #fef3c7;
            color: #b45309;
        }


        .stock-button:hover {
            background: #fde68a;
        }


        .delete-form {
            display: inline;
            margin: 0;
        }


        /* =========================
           EMPTY STATE
        ========================= */

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


        /* =========================
           FOOTER
        ========================= */

        .page-footer {
            max-width: 1250px;

            margin: 25px auto 0;

            padding: 18px;

            text-align: center;

            color: #94a3b8;

            font-size: 12px;
        }


        /* =========================
           RESPONSIVE
        ========================= */

        @media (max-width: 900px) {

            .page-header {
                align-items: flex-start;
                flex-direction: column;
            }


            .header-actions {
                width: 100%;
                justify-content: space-between;
            }


            .product-count {
                flex: 1;
            }


            .add-product-button {
                flex: 1;
            }
        }


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


            .products-page {
                padding: 32px 15px 50px;
            }


            .page-header h1 {
                font-size: 34px;
            }


            .header-actions {
                flex-direction: column;
                width: 100%;
            }


            .product-count,
            .add-product-button {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =========================
     ADMIN NAVBAR
========================= -->

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
            ← Dashboard
        </a>


        <a
            href="<%= request.getContextPath() %>/logout"
            class="nav-button logout-button"
        >
            Logout
        </a>

    </div>

</nav>


<!-- =========================
     MAIN PAGE
========================= -->

<main class="products-page">


<%

    List<Product> products =
            (List<Product>) request.getAttribute("products");

    int productCount =
            products == null ? 0 : products.size();

%>


<!-- =========================
     PAGE HEADER
========================= -->

<div class="page-header">


    <div class="header-left">

        <div class="small-title">
            INVENTORY MANAGEMENT
        </div>


        <h1>
            Products
        </h1>


        <p>
            View and manage all products in your ShopSphere store.
        </p>

    </div>


    <div class="header-actions">


        <!-- ADD PRODUCT -->

        <a
            href="<%= request.getContextPath() %>/admin/products?action=add"
            class="add-product-button"
        >
            + Add Product
        </a>


        <!-- PRODUCT COUNT -->

        <div class="product-count">

            <strong>
                <%= productCount %>
            </strong>

            <span>
                Products
            </span>

        </div>


    </div>

</div>


<%

    if (products != null && !products.isEmpty()) {

%>


<!-- =========================
     PRODUCT TABLE
========================= -->

<div class="table-card">


    <div class="table-header">

        <h2>
            Product Inventory
        </h2>

        <span>
            Current catalog
        </span>

    </div>


    <div class="table-responsive">


        <table>


            <thead>

                <tr>

                    <th>
                        ID
                    </th>

                    <th>
                        PRODUCT
                    </th>

                    <th>
                        BRAND
                    </th>

                    <th>
                        CATEGORY
                    </th>

                    <th>
                        PRICE
                    </th>

                    <th>
                        DISCOUNT
                    </th>

                    <th>
                        STOCK
                    </th>

                    <th>
                        ACTIONS
                    </th>

                </tr>

            </thead>


            <tbody>


            <%

                for (Product product : products) {

            %>


                <tr>


                    <!-- ID -->

                    <td>

                        <span class="product-id">
                            #<%= product.getProductId() %>
                        </span>

                    </td>


                    <!-- PRODUCT -->

                    <td>

                        <div class="product-name">
                            <%= product.getName() %>
                        </div>

                    </td>


                    <!-- BRAND -->

                    <td>

                        <span class="brand">
                            <%= product.getBrand() %>
                        </span>

                    </td>


                    <!-- CATEGORY -->

                    <td>

                        <span class="category-id">
                            #<%= product.getCategoryId() %>
                        </span>

                    </td>


                    <!-- PRICE -->

                    <td>

                        <span class="price">

                            ₹<%= String.format(
                                "%.2f",
                                product.getPrice()
                            ) %>

                        </span>

                    </td>


                    <!-- DISCOUNT -->

                    <td>

                        <%

                            if (product.getDiscount() > 0) {

                        %>

                            <span class="discount">

                                <%= product.getDiscount() %>% OFF

                            </span>

                        <%

                            } else {

                        %>

                            <span class="no-discount">
                                No Discount
                            </span>

                        <%

                            }

                        %>

                    </td>


                    <!-- STOCK -->

                    <td>

                        <%

                            int stock =
                                    product.getStock();

                            if (stock <= 0) {

                        %>

                            <span class="stock stock-out">
                                Out of Stock
                            </span>

                        <%

                            } else if (stock <= 5) {

                        %>

                            <span class="stock stock-low">
                                Low: <%= stock %>
                            </span>

                        <%

                            } else {

                        %>

                            <span class="stock stock-good">
                                In Stock: <%= stock %>
                            </span>

                        <%

                            }

                        %>

                    </td>


                    <!-- ACTIONS -->

                    <td>

                        <div class="action-buttons">


                            <!-- EDIT -->

                            <a
                                href="<%= request.getContextPath() %>/admin/products?action=edit&id=<%= product.getProductId() %>"
                                class="action-button edit-button"
                            >
                                Edit
                            </a>


                            <!-- STOCK -->

                            <button
                                type="button"
                                class="action-button stock-button"
                                data-product-id="<%= product.getProductId() %>"
                                data-current-stock="<%= product.getStock() %>"
                                onclick="updateStock(this)"
                            >
                                Stock
                            </button>


                            <!-- DELETE -->

                            <form
                                method="post"
                                action="<%= request.getContextPath() %>/admin/products"
                                class="delete-form"
                                onsubmit="return confirmDelete();"
                            >

                                <input
                                    type="hidden"
                                    name="action"
                                    value="delete"
                                >

                                <input
                                    type="hidden"
                                    name="productId"
                                    value="<%= product.getProductId() %>"
                                >

                                <button
                                    type="submit"
                                    class="action-button delete-button"
                                >
                                    Delete
                                </button>

                            </form>


                        </div>

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


<!-- =========================
     EMPTY STATE
========================= -->

<div class="empty-state">

    <div class="empty-icon">
        📦
    </div>

    <h2>
        No Products Found
    </h2>

    <p>
        There are currently no products in the catalog.
    </p>

</div>


<%

    }

%>


<div class="page-footer">

    ShopSphere Admin Panel
    &nbsp; • &nbsp;
    Product Inventory Management

</div>


</main>


<!-- =========================
     JAVASCRIPT
========================= -->

<script>


    // ==========================================
    // UPDATE STOCK
    // ==========================================

    function updateStock(button) {

        const productId =
            button.getAttribute("data-product-id");

        const currentStock =
            button.getAttribute("data-current-stock");


        const newStock = prompt(
            "Enter new stock quantity:",
            currentStock
        );


        if (newStock === null) {
            return;
        }


        const stock =
            parseInt(newStock, 10);


        if (isNaN(stock) || stock < 0) {

            alert(
                "Please enter a valid stock quantity."
            );

            return;
        }


        const form =
            document.createElement("form");


        form.method = "POST";


        form.action =
            "<%= request.getContextPath() %>/admin/products";


        // ACTION

        const actionInput =
            document.createElement("input");

        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = "stock";


        // PRODUCT ID

        const productInput =
            document.createElement("input");

        productInput.type = "hidden";
        productInput.name = "productId";
        productInput.value = productId;


        // STOCK

        const stockInput =
            document.createElement("input");

        stockInput.type = "hidden";
        stockInput.name = "stock";
        stockInput.value = stock;


        form.appendChild(actionInput);
        form.appendChild(productInput);
        form.appendChild(stockInput);


        document.body.appendChild(form);


        form.submit();
    }


    // ==========================================
    // DELETE CONFIRMATION
    // ==========================================

    function confirmDelete() {

        return confirm(
            "Are you sure you want to delete this product?"
        );
    }


</script>


</body>

</html>