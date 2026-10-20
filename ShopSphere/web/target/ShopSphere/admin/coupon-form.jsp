<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.shopsphere.model.Coupon" %>

<%
    Coupon coupon = (Coupon) request.getAttribute("coupon");

    boolean editMode = coupon != null;
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>
        <%= editMode ? "Edit Coupon" : "Add Coupon" %> - ShopSphere
    </title>

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

        .container {
            max-width: 750px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.10);
        }

        .title {
            margin-bottom: 25px;
        }

        .title h2 {
            margin: 0 0 8px;
            font-size: 26px;
        }

        .title p {
            margin: 0;
            color: #666;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
        }

        input,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 7px;
            font-size: 14px;
            outline: none;
        }

        input:focus,
        select:focus {
            border-color: #3b82f6;
        }

        .row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .button {
            border: none;
            padding: 12px 20px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }

        .save-button {
            background: #198754;
            color: white;
            flex: 1;
        }

        .save-button:hover {
            background: #157347;
        }

        .cancel-button {
            background: #6c757d;
            color: white;
            flex: 1;
        }

        .cancel-button:hover {
            background: #5c636a;
        }

        .info {
            background: #eef5ff;
            border-left: 4px solid #3b82f6;
            padding: 12px;
            margin-bottom: 25px;
            border-radius: 5px;
            color: #333;
            font-size: 13px;
        }

        @media(max-width: 650px) {

            .header {
                padding: 18px;
            }

            .container {
                margin: 20px auto;
            }

            .card {
                padding: 20px;
            }

            .row {
                grid-template-columns: 1fr;
                gap: 0;
            }

            .buttons {
                flex-direction: column;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <h1>
        Shop<span>Sphere</span>
    </h1>

    <div>
        Admin Panel
    </div>

</div>


<div class="container">

    <div class="card">

        <div class="title">

            <h2>
                <%= editMode ? "Edit Coupon" : "Add New Coupon" %>
            </h2>

            <p>
                <%= editMode
                        ? "Update the coupon details below."
                        : "Create a new discount coupon for customers." %>
            </p>

        </div>


        <div class="info">

            Coupon codes should be unique.
            Enter the discount, minimum order value and expiry date carefully.

        </div>


        <form method="post"
              action="<%= request.getContextPath() %>/admin/coupons">


            <% if (editMode) { %>

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="couponId"
                       value="<%= coupon.getCouponId() %>">

            <% } else { %>

                <input type="hidden"
                       name="action"
                       value="add">

            <% } %>


            <!-- Coupon Code -->

            <div class="form-group">

                <label for="code">
                    Coupon Code
                </label>

                <input
                    type="text"
                    id="code"
                    name="code"
                    placeholder="Example: SAVE20"
                    value="<%= editMode ? coupon.getCode() : "" %>"
                    required>

            </div>


            <!-- Discount Type -->

            <div class="form-group">

                <label for="discountType">
                    Discount Type
                </label>

                <select
                    id="discountType"
                    name="discountType"
                    required>

                    <option value="PERCENTAGE"
                        <%= editMode &&
                            "PERCENTAGE".equalsIgnoreCase(
                                coupon.getDiscountType()
                            )
                            ? "selected"
                            : "" %>>
                        Percentage
                    </option>

                    <option value="FIXED"
                        <%= editMode &&
                            "FIXED".equalsIgnoreCase(
                                coupon.getDiscountType()
                            )
                            ? "selected"
                            : "" %>>
                        Fixed Amount
                    </option>

                </select>

            </div>


            <!-- Discount + Minimum Order -->

            <div class="row">

                <div class="form-group">

                    <label for="discountValue">
                        Discount Value
                    </label>

                    <input
                        type="number"
                        id="discountValue"
                        name="discountValue"
                        step="0.01"
                        min="0"
                        placeholder="Example: 10"
                        value="<%= editMode
                                ? coupon.getDiscountValue()
                                : "" %>"
                        required>

                </div>


                <div class="form-group">

                    <label for="minimumOrder">
                        Minimum Order
                    </label>

                    <input
                        type="number"
                        id="minimumOrder"
                        name="minimumOrder"
                        step="0.01"
                        min="0"
                        placeholder="Example: 500"
                        value="<%= editMode
                                ? coupon.getMinimumOrder()
                                : "0" %>"
                        required>

                </div>

            </div>


            <!-- Maximum Discount + Expiry -->

            <div class="row">

                <div class="form-group">

                    <label for="maximumDiscount">
                        Maximum Discount
                    </label>

                    <input
                        type="number"
                        id="maximumDiscount"
                        name="maximumDiscount"
                        step="0.01"
                        min="0"
                        placeholder="Leave 0 for no limit"
                        value="<%= editMode
                                ? coupon.getMaximumDiscount()
                                : "0" %>">

                </div>


                <div class="form-group">

                    <label for="expiryDate">
                        Expiry Date
                    </label>

                    <input
                        type="date"
                        id="expiryDate"
                        name="expiryDate"
                        value="<%= editMode &&
                                coupon.getExpiryDate() != null
                                ? coupon.getExpiryDate()
                                : "" %>">

                </div>

            </div>


            <% if (editMode) { %>

                <!-- Status -->

                <div class="form-group">

                    <label for="status">
                        Status
                    </label>

                    <select
                        id="status"
                        name="status">

                        <option value="true"
                            <%= coupon.isStatus()
                                    ? "selected"
                                    : "" %>>
                            Active
                        </option>

                        <option value="false"
                            <%= !coupon.isStatus()
                                    ? "selected"
                                    : "" %>>
                            Inactive
                        </option>

                    </select>

                </div>

            <% } %>


            <!-- Buttons -->

            <div class="buttons">

                <button
                    type="submit"
                    class="button save-button">

                    <%= editMode
                            ? "Update Coupon"
                            : "Create Coupon" %>

                </button>


                <a
                    href="<%= request.getContextPath() %>/admin/coupons"
                    class="button cancel-button">

                    Cancel

                </a>

            </div>


        </form>

    </div>

</div>

</body>
</html>