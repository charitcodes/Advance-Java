<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.CartItem" %>

<%
    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Shopping Cart
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


        .cart-page {
            max-width: 1200px;
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
            max-width: 650px;
            color: #64748b;
            font-size: 16px;
        }


        .cart-card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 28px;
            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.09);
        }


        .cart-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 25px;
        }


        .cart-top h2 {
            margin: 0;
            font-size: 25px;
            font-weight: 800;
        }


        .cart-count {
            padding: 8px 14px;
            border-radius: 999px;
            background: #eef2ff;
            color: #4f46e5;
            font-size: 13px;
            font-weight: 800;
        }


        .cart-table-wrapper {
            overflow-x: auto;
        }


        .cart-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 700px;
        }


        .cart-table th {
            padding: 16px;
            text-align: left;
            background: #202020;
            color: white;
            font-size: 14px;
        }


        .cart-table th:first-child {
            border-radius: 12px 0 0 12px;
        }


        .cart-table th:last-child {
            border-radius: 0 12px 12px 0;
        }


        .cart-table td {
            padding: 18px 16px;
            border-bottom: 1px solid #e5e7eb;
            color: #334155;
            font-size: 15px;
            vertical-align: middle;
        }


        .cart-table tbody tr {
            transition: 0.2s ease;
        }


        .cart-table tbody tr:hover {
            background: #f8fafc;
        }


        .cart-id {
            font-weight: 800;
            color: #4f46e5;
        }


        .product-box {
            display: flex;
            align-items: center;
            gap: 13px;
        }


        .product-icon {
            width: 48px;
            height: 48px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 14px;

            background:
                linear-gradient(
                    135deg,
                    #dbeafe,
                    #c7d2fe
                );

            font-size: 24px;
        }


        .product-title {
            font-weight: 800;
            color: #111827;
        }


        .product-subtitle {
            margin-top: 4px;
            color: #64748b;
            font-size: 12px;
        }


        .quantity-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-width: 42px;
            height: 34px;

            padding: 0 12px;

            border-radius: 10px;

            background: #eef2ff;
            color: #4338ca;

            font-weight: 800;
        }


        .remove-form {
            margin: 0;
        }


        .remove-button {
            min-height: 40px;
            padding: 0 16px;

            border: none;
            border-radius: 10px;

            background: #fee2e2;
            color: #dc2626;

            font-size: 13px;
            font-weight: 800;

            cursor: pointer;

            transition: 0.2s ease;
        }


        .remove-button:hover {
            background: #fecaca;
            transform: translateY(-2px);
        }


        .cart-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            margin-top: 28px;
            padding-top: 25px;

            border-top: 1px solid #e5e7eb;
        }


        .continue-button,
        .checkout-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-height: 48px;

            padding: 0 22px;

            border-radius: 12px;

            text-decoration: none;

            font-size: 14px;
            font-weight: 800;

            transition: all 0.2s ease;
        }


        .continue-button {
            color: #334155;
            background: #f8fafc;
            border: 1px solid #cbd5e1;
        }


        .continue-button:hover {
            background: #eef2ff;
            border-color: #818cf8;
            transform: translateY(-2px);
        }


        .checkout-button {
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


        .checkout-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(22, 163, 74, 0.28);
        }


        .empty-cart {
            text-align: center;
            padding: 70px 25px;
        }


        .empty-icon {
            width: 90px;
            height: 90px;

            margin: 0 auto 22px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #eef2ff;

            font-size: 42px;
        }


        .empty-cart h2 {
            margin: 0 0 10px;
            font-size: 28px;
            font-weight: 800;
        }


        .empty-cart p {
            max-width: 520px;
            margin: 0 auto 25px;

            color: #64748b;
            line-height: 1.6;
        }


        .browse-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-height: 46px;
            padding: 0 22px;

            border-radius: 12px;

            text-decoration: none;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            font-size: 14px;
            font-weight: 800;

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.20);

            transition: 0.2s ease;
        }


        .browse-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(37, 99, 235, 0.28);
        }


        @media (max-width: 700px) {

            .cart-page {
                padding: 30px 15px 50px;
            }


            .page-header h1 {
                font-size: 32px;
            }


            .cart-card {
                padding: 18px;
            }


            .cart-top {
                align-items: flex-start;
                flex-direction: column;
            }


            .cart-actions {
                flex-direction: column;
                align-items: stretch;
            }


            .continue-button,
            .checkout-button {
                width: 100%;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="cart-page">


        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE
            </div>

            <h1>
                Shopping Cart
            </h1>

            <p>
                Review the products you've selected before
                continuing to checkout.
            </p>

        </div>


        <div class="cart-card">


            <%
                if (cartItems != null && !cartItems.isEmpty()) {
            %>


            <div class="cart-top">

                <h2>
                    Your Cart
                </h2>

                <div class="cart-count">

                    <%= cartItems.size() %>

                    Item<%= cartItems.size() == 1 ? "" : "s" %>

                </div>

            </div>


            <div class="cart-table-wrapper">


                <table class="cart-table">


                    <thead>

                        <tr>

                            <th>
                                Cart ID
                            </th>

                            <th>
                                Product
                            </th>

                            <th>
                                Quantity
                            </th>

                            <th>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <%
                        for (CartItem item : cartItems) {
                    %>


                        <tr>


                            <td class="cart-id">

                                #<%= item.getCartId() %>

                            </td>


                            <td>


                                <div class="product-box">


                                    <div class="product-icon">

                                        🛍️

                                    </div>


                                    <div>

                                        <div class="product-title">

                                            Product #<%= item.getProductId() %>

                                        </div>


                                        <div class="product-subtitle">

                                            ShopSphere Product

                                        </div>

                                    </div>


                                </div>


                            </td>


                            <td>

                                <span class="quantity-badge">

                                    <%= item.getQuantity() %>

                                </span>

                            </td>


                            <td>


                                <form
                                    class="remove-form"
                                    action="${pageContext.request.contextPath}/cart"
                                    method="post"
                                >


                                    <input
                                        type="hidden"
                                        name="action"
                                        value="remove"
                                    >


                                    <input
                                        type="hidden"
                                        name="cartId"
                                        value="<%= item.getCartId() %>"
                                    >


                                    <button
                                        type="submit"
                                        class="remove-button"
                                    >

                                        🗑 Remove

                                    </button>


                                </form>


                            </td>


                        </tr>


                    <%
                        }
                    %>


                    </tbody>


                </table>


            </div>


            <div class="cart-actions">


                <a
                    href="${pageContext.request.contextPath}/products"
                    class="continue-button"
                >

                    ← Continue Shopping

                </a>


                <a
                    href="${pageContext.request.contextPath}/checkout"
                    class="checkout-button"
                >

                    Proceed to Checkout →

                </a>


            </div>


            <%
                } else {
            %>


            <div class="empty-cart">


                <div class="empty-icon">

                    🛒

                </div>


                <h2>

                    Your Cart is Empty

                </h2>


                <p>

                    Looks like you haven't added anything to your
                    cart yet. Explore our products and find
                    something you like.

                </p>


                <a
                    href="${pageContext.request.contextPath}/products"
                    class="browse-button"
                >

                    🛍 Browse Products

                </a>


            </div>


            <%
                }
            %>


        </div>


    </div>


</body>

</html>