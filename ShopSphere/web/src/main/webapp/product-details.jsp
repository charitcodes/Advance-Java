<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.shopsphere.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Product Details
    </title>

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


        .product-page {
            max-width: 1100px;
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
            font-size: 40px;
            font-weight: 800;
        }


        .page-header p {
            margin: 10px auto 0;
            color: #64748b;
            font-size: 16px;
        }


        .product-card {
            display: grid;
            grid-template-columns: 0.85fr 1.15fr;
            gap: 35px;

            background: rgba(255, 255, 255, 0.96);

            border: 1px solid #e5e7eb;
            border-radius: 26px;

            padding: 30px;

            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.10);
        }


        .product-visual {
            min-height: 430px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 22px;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #c7d2fe
                );

            position: relative;
            overflow: hidden;
        }


        .product-visual::before {
            content: "";

            position: absolute;

            width: 260px;
            height: 260px;

            border-radius: 50%;

            background: rgba(255, 255, 255, 0.30);

            top: -70px;
            right: -70px;
        }


        .product-visual::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            border-radius: 50%;

            background: rgba(255, 255, 255, 0.25);

            bottom: -55px;
            left: -45px;
        }


        .product-icon {
            position: relative;
            z-index: 2;

            font-size: 125px;

            filter:
                drop-shadow(
                    0 15px 20px
                    rgba(30, 41, 59, 0.18)
                );
        }


        .product-info {
            padding: 8px 5px;
        }


        .discount-badge {
            display: inline-flex;
            align-items: center;

            padding: 7px 13px;

            border-radius: 999px;

            background: #2563eb;
            color: white;

            font-size: 12px;
            font-weight: 800;

            margin-bottom: 15px;
        }


        .product-name {
            margin: 0 0 10px;

            font-size: 38px;
            line-height: 1.15;

            font-weight: 800;

            color: #111827;
        }


        .brand {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 22px;
        }


        .brand strong {
            color: #334155;
        }


        .price-section {
            display: flex;
            align-items: center;
            gap: 15px;

            margin-bottom: 22px;
        }


        .price {
            color: #2563eb;
            font-size: 32px;
            font-weight: 800;
        }


        .discount-text {
            color: #16a34a;
            font-size: 14px;
            font-weight: 800;
        }


        .details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;

            margin-bottom: 22px;
        }


        .detail-box {
            padding: 15px;

            border-radius: 14px;

            background: #f8fafc;

            border: 1px solid #e2e8f0;
        }


        .detail-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 600;

            margin-bottom: 5px;
        }


        .detail-value {
            color: #111827;
            font-size: 16px;
            font-weight: 800;
        }


        .stock {
            color: #16a34a;
        }


        .description-box {
            margin-bottom: 25px;

            padding: 18px;

            border-radius: 16px;

            background: #f8fafc;

            border: 1px solid #e2e8f0;
        }


        .description-title {
            margin-bottom: 8px;

            color: #334155;

            font-size: 14px;
            font-weight: 800;
        }


        .description {
            margin: 0;

            color: #64748b;

            font-size: 14px;
            line-height: 1.65;
        }


        .action-group {
            display: flex;
            flex-direction: column;
            gap: 11px;
        }


        .action-button {
            width: 100%;
            min-height: 48px;

            border: none;
            border-radius: 12px;

            font-size: 14px;
            font-weight: 800;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .cart-button {
            color: white;

            background:
                linear-gradient(
                    135deg,
                    #16a34a,
                    #15803d
                );

            box-shadow:
                0 8px 18px rgba(22, 163, 74, 0.22);
        }


        .cart-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(22, 163, 74, 0.28);
        }


        .wishlist-button {
            color: #92400e;

            background:
                linear-gradient(
                    135deg,
                    #fef3c7,
                    #fde68a
                );
        }


        .wishlist-button:hover {
            transform: translateY(-2px);
        }


        .back-button {
            display: flex;
            align-items: center;
            justify-content: center;

            width: 100%;
            min-height: 48px;

            border-radius: 12px;

            text-decoration: none;

            color: white;

            background: #64748b;

            font-size: 14px;
            font-weight: 800;

            transition: all 0.2s ease;
        }


        .back-button:hover {
            background: #475569;
            transform: translateY(-2px);
        }


        .not-found {
            max-width: 650px;

            margin: 70px auto;

            padding: 45px 30px;

            text-align: center;

            background: white;

            border: 1px solid #e5e7eb;

            border-radius: 24px;

            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.09);
        }


        .not-found-icon {
            font-size: 55px;
            margin-bottom: 15px;
        }


        .not-found h2 {
            margin: 0 0 10px;

            font-size: 28px;
        }


        .not-found p {
            color: #64748b;
            margin-bottom: 25px;
        }


        @media (max-width: 850px) {

            .product-card {
                grid-template-columns: 1fr;
            }


            .product-visual {
                min-height: 300px;
            }


            .product-name {
                font-size: 32px;
            }

        }


        @media (max-width: 550px) {

            .product-page {
                padding: 30px 15px 50px;
            }


            .page-header h1 {
                font-size: 32px;
            }


            .product-card {
                padding: 18px;
            }


            .product-visual {
                min-height: 240px;
            }


            .product-icon {
                font-size: 90px;
            }


            .product-name {
                font-size: 28px;
            }


            .details-grid {
                grid-template-columns: 1fr;
            }


            .price {
                font-size: 27px;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="product-page">


        <%
            if (product == null) {
        %>


        <div class="not-found">

            <div class="not-found-icon">
                🔍
            </div>

            <h2>
                Product Not Found
            </h2>

            <p>
                The requested product could not be found.
            </p>

            <a
                href="${pageContext.request.contextPath}/products"
                class="back-button"
            >

                ← Back to Products

            </a>

        </div>


        <%
            } else {
        %>


        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE PRODUCT
            </div>

            <h1>
                Product Details
            </h1>

            <p>
                Explore product information before adding it
                to your cart or wishlist.
            </p>

        </div>


        <div class="product-card">


            <div class="product-visual">


                <div class="product-icon">

                    <%
                        String productName = product.getName();

                        if (productName != null &&
                            productName.contains("Galaxy S25")) {
                    %>

                        📱

                    <%
                        } else if (productName != null &&
                                   productName.contains("iPhone")) {
                    %>

                        📱

                    <%
                        } else if (productName != null &&
                                   productName.contains("IdeaPad")) {
                    %>

                        💻

                    <%
                        } else if (productName != null &&
                                   productName.contains("Inspiron")) {
                    %>

                        💻

                    <%
                        } else if (productName != null &&
                                   productName.contains("WH-1000XM5")) {
                    %>

                        🎧

                    <%
                        } else if (productName != null &&
                                   productName.contains("Galaxy Watch")) {
                    %>

                        ⌚

                    <%
                        } else if (productName != null &&
                                   productName.contains("Mouse")) {
                    %>

                        🖱️

                    <%
                        } else if (productName != null &&
                                   productName.contains("USB-C Hub")) {
                    %>

                        🔌

                    <%
                        } else {
                    %>

                        🛍️

                    <%
                        }
                    %>

                </div>


            </div>


            <div class="product-info">


                <%
                    if (product.getDiscount() > 0) {
                %>

                <div class="discount-badge">

                    <%= product.getDiscount() %>% OFF

                </div>

                <%
                    }
                %>


                <h2 class="product-name">

                    <%= product.getName() %>

                </h2>


                <div class="brand">

                    <strong>
                        Brand:
                    </strong>

                    <%= product.getBrand() %>

                </div>


                <div class="price-section">

                    <div class="price">

                        ₹<%= product.getPrice() %>

                    </div>


                    <%
                        if (product.getDiscount() > 0) {
                    %>

                    <div class="discount-text">

                        Save <%= product.getDiscount() %>%

                    </div>

                    <%
                        }
                    %>

                </div>


                <div class="details-grid">


                    <div class="detail-box">

                        <div class="detail-label">
                            Product ID
                        </div>

                        <div class="detail-value">
                            #<%= product.getProductId() %>
                        </div>

                    </div>


                    <div class="detail-box">

                        <div class="detail-label">
                            Stock Available
                        </div>

                        <div class="detail-value stock">

                            <%= product.getStock() %>

                        </div>

                    </div>


                </div>


                <div class="description-box">

                    <div class="description-title">

                        Product Description

                    </div>

                    <p class="description">

                        <%= product.getDescription() %>

                    </p>

                </div>


                <div class="action-group">


                    <%
                        if (product.getStock() > 0) {
                    %>


                    <form
                        action="${pageContext.request.contextPath}/cart"
                        method="post"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="add"
                        >

                        <input
                            type="hidden"
                            name="productId"
                            value="<%= product.getProductId() %>"
                        >

                        <input
                            type="hidden"
                            name="quantity"
                            value="1"
                        >

                        <button
                            type="submit"
                            class="action-button cart-button"
                        >

                            🛒 Add to Cart

                        </button>

                    </form>


                    <%
                        } else {
                    %>


                    <button
                        type="button"
                        class="action-button"
                        style="background:#fee2e2;color:#dc2626;"
                        disabled
                    >

                        Out of Stock

                    </button>


                    <%
                        }
                    %>


                    <form
                        action="${pageContext.request.contextPath}/wishlist"
                        method="post"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="add"
                        >

                        <input
                            type="hidden"
                            name="productId"
                            value="<%= product.getProductId() %>"
                        >

                        <button
                            type="submit"
                            class="action-button wishlist-button"
                        >

                            ❤️ Add to Wishlist

                        </button>

                    </form>


                    <a
                        href="${pageContext.request.contextPath}/products"
                        class="back-button"
                    >

                        ← Back to Products

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