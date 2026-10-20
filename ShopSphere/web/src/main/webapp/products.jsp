<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <title>ShopSphere - Products</title>

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


        .products-page {
            padding: 42px 5% 70px;
        }


        .page-heading {
            text-align: center;
            margin-bottom: 42px;
        }


        .small-title {
            display: inline-block;

            color: #4f46e5;

            font-size: 13px;
            font-weight: bold;

            letter-spacing: 4px;

            margin-bottom: 10px;
        }


        .page-heading h1 {
            margin: 0;

            font-size: 42px;
            font-weight: 800;

            letter-spacing: -1px;
        }


        .page-heading p {
            margin: 12px auto 0;

            max-width: 620px;

            color: #64748b;

            font-size: 17px;
        }


        .products {
            max-width: 1250px;

            margin: 0 auto;

            display: grid;

            grid-template-columns:
                repeat(4, minmax(0, 1fr));

            gap: 24px;
        }


        .product-card {
            position: relative;

            overflow: hidden;

            background: rgba(255, 255, 255, 0.95);

            border: 1px solid #e5e7eb;

            border-radius: 24px;

            padding: 18px;

            box-shadow:
                0 15px 40px
                rgba(30, 41, 59, 0.08);

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }


        .product-card:hover {
            transform: translateY(-8px);

            box-shadow:
                0 22px 50px
                rgba(30, 41, 59, 0.14);
        }


        .product-top {
            height: 155px;

            border-radius: 18px;

            margin-bottom: 18px;

            display: flex;

            align-items: center;

            justify-content: center;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #c7d2fe
                );

            overflow: hidden;
        }


        .product-icon {
            font-size: 62px;
            line-height: 1;
        }


        .product-card:nth-child(2) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #e0e7ff,
                    #dbeafe
                );
        }


        .product-card:nth-child(3) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #dcfce7,
                    #d1fae5
                );
        }


        .product-card:nth-child(4) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #fef3c7,
                    #fde68a
                );
        }


        .product-card:nth-child(5) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #fce7f3,
                    #fbcfe8
                );
        }


        .product-card:nth-child(6) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #e0f2fe,
                    #bae6fd
                );
        }


        .product-card:nth-child(7) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #f3e8ff,
                    #e9d5ff
                );
        }


        .product-card:nth-child(8) .product-top {
            background:
                linear-gradient(
                    135deg,
                    #ffedd5,
                    #fed7aa
                );
        }


        .discount-badge {
            position: absolute;

            top: 28px;
            left: 28px;

            padding: 7px 11px;

            border-radius: 999px;

            background: #2563eb;

            color: white;

            font-size: 12px;

            font-weight: bold;

            box-shadow:
                0 8px 18px
                rgba(37, 99, 235, 0.25);
        }


        .stock-badge {
            position: absolute;

            top: 28px;
            right: 28px;

            padding: 7px 10px;

            border-radius: 999px;

            background: rgba(255, 255, 255, 0.92);

            color: #475569;

            font-size: 12px;

            font-weight: bold;
        }


        .product-name {
            margin: 0 0 8px;

            font-size: 22px;

            line-height: 1.2;
        }


        .brand {
            margin-bottom: 12px;

            color: #64748b;

            font-size: 14px;
        }


        .description {
            min-height: 50px;

            margin-bottom: 16px;

            color: #64748b;

            font-size: 14px;

            line-height: 1.45;
        }


        .price-row {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 12px;

            margin-bottom: 18px;
        }


        .price {
            color: #111827;

            font-size: 24px;

            font-weight: 800;
        }


        .discount-text {
            color: #16a34a;

            font-size: 13px;

            font-weight: bold;
        }


        .product-actions {
            display: flex;

            gap: 10px;
        }


        .view-button,
        .cart-button {
            flex: 1;

            min-height: 44px;

            border-radius: 12px;

            font-size: 14px;

            font-weight: bold;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .view-button {
            display: flex;

            align-items: center;

            justify-content: center;

            text-decoration: none;

            color: #334155;

            background: #f8fafc;

            border: 1px solid #cbd5e1;
        }


        .view-button:hover {
            background: #eef2ff;

            border-color: #818cf8;
        }


        .cart-button {
            border: none;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            box-shadow:
                0 8px 18px
                rgba(37, 99, 235, 0.22);
        }


        .cart-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 24px
                rgba(37, 99, 235, 0.28);
        }


        .out-stock {
            text-align: center;

            padding: 12px;

            border-radius: 12px;

            background: #fef2f2;

            color: #dc2626;

            font-weight: bold;
        }


        .empty-products {
            max-width: 600px;

            margin: 50px auto;

            padding: 30px;

            text-align: center;

            background: white;

            border-radius: 18px;

            box-shadow:
                0 10px 30px
                rgba(0, 0, 0, 0.08);
        }


        @media (max-width: 1100px) {

            .products {
                grid-template-columns:
                    repeat(3, minmax(0, 1fr));
            }

        }


        @media (max-width: 820px) {

            .products {
                grid-template-columns:
                    repeat(2, minmax(0, 1fr));
            }

        }


        @media (max-width: 560px) {

            .products-page {
                padding: 30px 16px 50px;
            }

            .page-heading h1 {
                font-size: 32px;
            }

            .products {
                grid-template-columns: 1fr;
            }

            .product-actions {
                flex-direction: column;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="products-page">


        <div class="page-heading">

            <div class="small-title">
                SHOPSPHERE COLLECTION
            </div>

            <h1>
                Explore Our Products
            </h1>

            <p>
                Discover quality products at attractive prices,
                curated for your everyday needs.
            </p>

        </div>


        <c:choose>

            <c:when test="${empty products}">

                <div class="empty-products">

                    <h2>
                        No Products Found
                    </h2>

                    <p>
                        There are currently no products available.
                    </p>

                </div>

            </c:when>


            <c:otherwise>

                <div class="products">

                    <c:forEach
                        var="product"
                        items="${products}">

                        <div class="product-card">


                            <c:if test="${product.discount > 0}">

                                <div class="discount-badge">
                                    ${product.discount}% OFF
                                </div>

                            </c:if>


                            <div class="stock-badge">
                                Stock: ${product.stock}
                            </div>


                            <div class="product-top">

                                <c:choose>

                                    <c:when test="${product.name.contains('Galaxy S25')}">

                                        <div class="product-icon">
                                            📱
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('iPhone')}">

                                        <div class="product-icon">
                                            📱
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('IdeaPad')}">

                                        <div class="product-icon">
                                            💻
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('Inspiron')}">

                                        <div class="product-icon">
                                            💻
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('WH-1000XM5')}">

                                        <div class="product-icon">
                                            🎧
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('Galaxy Watch')}">

                                        <div class="product-icon">
                                            ⌚
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('Mouse')}">

                                        <div class="product-icon">
                                            🖱️
                                        </div>

                                    </c:when>


                                    <c:when test="${product.name.contains('USB-C Hub')}">

                                        <div class="product-icon">
                                            🔌
                                        </div>

                                    </c:when>


                                    <c:otherwise>

                                        <div class="product-icon">
                                            🛍️
                                        </div>

                                    </c:otherwise>

                                </c:choose>

                            </div>


                            <h2 class="product-name">
                                ${product.name}
                            </h2>


                            <div class="brand">

                                <strong>
                                    Brand:
                                </strong>

                                ${product.brand}

                            </div>


                            <div class="description">
                                ${product.description}
                            </div>


                            <div class="price-row">

                                <div class="price">
                                    ₹${product.price}
                                </div>


                                <c:if test="${product.discount > 0}">

                                    <div class="discount-text">
                                        Save ${product.discount}%
                                    </div>

                                </c:if>

                            </div>


                            <c:choose>

                                <c:when test="${product.stock > 0}">

                                    <div class="product-actions">


                                        <a
                                            class="view-button"
                                            href="${pageContext.request.contextPath}/products?id=${product.productId}">
                                            View Details
                                        </a>


                                        <form
                                            action="${pageContext.request.contextPath}/cart"
                                            method="post"
                                            style="flex:1; margin:0;">

                                            <input
                                                type="hidden"
                                                name="action"
                                                value="add">


                                            <input
                                                type="hidden"
                                                name="productId"
                                                value="${product.productId}">


                                            <input
                                                type="hidden"
                                                name="quantity"
                                                value="1">


                                            <button
                                                class="cart-button"
                                                type="submit">

                                                🛒 Add to Cart

                                            </button>

                                        </form>

                                    </div>

                                </c:when>


                                <c:otherwise>

                                    <div class="out-stock">
                                        Out of Stock
                                    </div>

                                </c:otherwise>

                            </c:choose>


                        </div>

                    </c:forEach>

                </div>

            </c:otherwise>

        </c:choose>


    </div>


    


</body>

</html>