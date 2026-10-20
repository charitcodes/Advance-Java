<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.WishlistItem" %>

<%
    List<WishlistItem> wishlist =
            (List<WishlistItem>) request.getAttribute("wishlistItems");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Wishlist
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


        .wishlist-page {
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


        .wishlist-card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid #e5e7eb;
            border-radius: 24px;
            padding: 28px;

            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.09);
        }


        .wishlist-top {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;
            margin-bottom: 25px;
        }


        .wishlist-top h2 {
            margin: 0;
            font-size: 25px;
            font-weight: 800;
        }


        .wishlist-count {
            padding: 8px 14px;
            border-radius: 999px;

            background: #fdf2f8;
            color: #db2777;

            font-size: 13px;
            font-weight: 800;
        }


        .wishlist-table-wrapper {
            overflow-x: auto;
        }


        .wishlist-table {
            width: 100%;
            min-width: 650px;

            border-collapse: separate;
            border-spacing: 0;
        }


        .wishlist-table th {
            padding: 16px;
            text-align: left;

            background: #202020;
            color: white;

            font-size: 14px;
        }


        .wishlist-table th:first-child {
            border-radius: 12px 0 0 12px;
        }


        .wishlist-table th:last-child {
            border-radius: 0 12px 12px 0;
        }


        .wishlist-table td {
            padding: 18px 16px;

            border-bottom: 1px solid #e5e7eb;

            color: #334155;
            font-size: 15px;

            vertical-align: middle;
        }


        .wishlist-table tbody tr {
            transition: 0.2s ease;
        }


        .wishlist-table tbody tr:hover {
            background: #fff7fb;
        }


        .wishlist-id {
            font-weight: 800;
            color: #db2777;
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
                    #fce7f3,
                    #fbcfe8
                );

            font-size: 24px;
        }


        .product-title {
            color: #111827;
            font-weight: 800;
        }


        .product-subtitle {
            margin-top: 4px;
            color: #64748b;
            font-size: 12px;
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


        .wishlist-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            margin-top: 28px;
            padding-top: 25px;

            border-top: 1px solid #e5e7eb;
        }


        .footer-text {
            color: #64748b;
            font-size: 14px;
        }


        .products-button {
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


        .products-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(37, 99, 235, 0.28);
        }


        .empty-wishlist {
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

            background: #fdf2f8;

            font-size: 42px;
        }


        .empty-wishlist h2 {
            margin: 0 0 10px;

            font-size: 28px;
            font-weight: 800;
        }


        .empty-wishlist p {
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

            .wishlist-page {
                padding: 30px 15px 50px;
            }


            .page-header h1 {
                font-size: 32px;
            }


            .wishlist-card {
                padding: 18px;
            }


            .wishlist-top {
                align-items: flex-start;
                flex-direction: column;
            }


            .wishlist-footer {
                flex-direction: column;
                align-items: stretch;
            }


            .products-button {
                width: 100%;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="wishlist-page">


        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE
            </div>

            <h1>
                My Wishlist
            </h1>

            <p>
                Save the products you love and come back to them
                whenever you're ready.
            </p>

        </div>


        <div class="wishlist-card">


            <%
                if (wishlist != null && !wishlist.isEmpty()) {
            %>


            <div class="wishlist-top">

                <h2>
                    Saved Products
                </h2>

                <div class="wishlist-count">

                    <%= wishlist.size() %>

                    Item<%= wishlist.size() == 1 ? "" : "s" %>

                </div>

            </div>


            <div class="wishlist-table-wrapper">


                <table class="wishlist-table">


                    <thead>

                        <tr>

                            <th>
                                Wishlist ID
                            </th>

                            <th>
                                Product
                            </th>

                            <th>
                                Action
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <%
                        for (WishlistItem item : wishlist) {
                    %>


                        <tr>


                            <td class="wishlist-id">

                                #<%= item.getWishlistId() %>

                            </td>


                            <td>


                                <div class="product-box">


                                    <div class="product-icon">

                                        ❤️

                                    </div>


                                    <div>

                                        <div class="product-title">

                                            Product #<%= item.getProductId() %>

                                        </div>


                                        <div class="product-subtitle">

                                            Saved to your wishlist

                                        </div>

                                    </div>


                                </div>


                            </td>


                            <td>


                                <form
                                    class="remove-form"
                                    action="${pageContext.request.contextPath}/wishlist"
                                    method="post"
                                >


                                    <input
                                        type="hidden"
                                        name="action"
                                        value="remove"
                                    >


                                    <input
                                        type="hidden"
                                        name="wishlistId"
                                        value="<%= item.getWishlistId() %>"
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


            <div class="wishlist-footer">

                <div class="footer-text">

                    ❤️ Your saved products are waiting for you.

                </div>


                <a
                    href="${pageContext.request.contextPath}/products"
                    class="products-button"
                >

                    🛍 Browse Products →

                </a>

            </div>


            <%
                } else {
            %>


            <div class="empty-wishlist">


                <div class="empty-icon">

                    ❤️

                </div>


                <h2>

                    Your Wishlist is Empty

                </h2>


                <p>

                    You haven't saved any products yet.
                    Browse our collection and add products
                    you would like to keep for later.

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