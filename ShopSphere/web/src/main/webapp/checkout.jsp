<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.CartItem" %>
<%@ page import="com.shopsphere.model.Address" %>

<%
    Double totalAmount =
            (Double) request.getAttribute("totalAmount");

    List<Address> addresses =
            (List<Address>) request.getAttribute("addresses");

    if (totalAmount == null) {
        totalAmount = 0.0;
    }

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Checkout
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


        .checkout-page {
            max-width: 1000px;
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


        .checkout-card {
            background: rgba(255, 255, 255, 0.96);

            border: 1px solid #e5e7eb;
            border-radius: 26px;

            padding: 30px;

            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.10);
        }


        .section {
            margin-bottom: 30px;
        }


        .section:last-child {
            margin-bottom: 0;
        }


        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;

            margin: 0 0 18px;

            font-size: 23px;
            font-weight: 800;
        }


        .section-number {
            width: 32px;
            height: 32px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #eef2ff;
            color: #4f46e5;

            font-size: 13px;
            font-weight: 800;
        }


        .summary-box {
            padding: 25px;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #eff6ff
                );

            border: 1px solid #c7d2fe;
        }


        .summary-row {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;
        }


        .summary-label {
            color: #475569;
            font-size: 15px;
            font-weight: 600;
        }


        .total-amount {
            color: #2563eb;
            font-size: 30px;
            font-weight: 800;
        }


        .security-text {
            margin-top: 8px;

            color: #64748b;
            font-size: 12px;
        }


        .address-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }


        .address-option {
            position: relative;

            display: block;

            padding: 20px 20px 20px 55px;

            border: 1px solid #e2e8f0;
            border-radius: 16px;

            background: #ffffff;

            cursor: pointer;

            transition: all 0.2s ease;
        }


        .address-option:hover {
            border-color: #818cf8;

            background: #f8fafc;

            transform: translateY(-2px);
        }


        .address-option input {
            position: absolute;

            left: 20px;
            top: 24px;

            width: 18px;
            height: 18px;

            accent-color: #4f46e5;

            cursor: pointer;
        }


        .address-id {
            display: block;

            margin-bottom: 7px;

            color: #111827;

            font-size: 15px;
            font-weight: 800;
        }


        .address-text {
            color: #64748b;

            font-size: 14px;

            line-height: 1.6;
        }


        .error-box {
            margin-bottom: 25px;

            padding: 15px 18px;

            border-radius: 14px;

            background: #fef2f2;

            border: 1px solid #fecaca;

            color: #dc2626;

            font-size: 14px;
            font-weight: 600;
        }


        .warning-box {
            padding: 20px;

            border-radius: 15px;

            background: #fffbeb;

            border: 1px solid #fde68a;

            color: #92400e;

            font-size: 14px;

            line-height: 1.6;
        }


        .checkout-actions {
            display: flex;
            gap: 12px;

            margin-top: 30px;

            padding-top: 25px;

            border-top: 1px solid #e5e7eb;
        }


        .back-button,
        .place-button {
            min-height: 50px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            text-decoration: none;

            font-size: 14px;
            font-weight: 800;

            transition: all 0.2s ease;
        }


        .back-button {
            flex: 1;

            color: #334155;

            background: #f8fafc;

            border: 1px solid #cbd5e1;
        }


        .back-button:hover {
            background: #eef2ff;
            border-color: #818cf8;

            transform: translateY(-2px);
        }


        .place-button {
            flex: 2;

            border: none;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #16a34a,
                    #15803d
                );

            box-shadow:
                0 8px 18px rgba(22, 163, 74, 0.22);

            cursor: pointer;
        }


        .place-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(22, 163, 74, 0.28);
        }


        .no-address-actions {
            margin-top: 20px;
        }


        @media (max-width: 650px) {

            .checkout-page {
                padding: 30px 15px 50px;
            }


            .page-header h1 {
                font-size: 32px;
            }


            .checkout-card {
                padding: 20px;
            }


            .summary-row {
                align-items: flex-start;
                flex-direction: column;
            }


            .total-amount {
                font-size: 26px;
            }


            .checkout-actions {
                flex-direction: column;
            }


            .back-button,
            .place-button {
                width: 100%;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="checkout-page">


        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE
            </div>

            <h1>
                Checkout
            </h1>

            <p>
                Review your order and select your delivery address.
            </p>

        </div>


        <div class="checkout-card">


            <%
                if (request.getAttribute("error") != null) {
            %>

                <div class="error-box">

                    ⚠
                    <%= request.getAttribute("error") %>

                </div>

            <%
                }
            %>


            <!-- ORDER SUMMARY -->

            <div class="section">

                <h2 class="section-title">

                    <span class="section-number">
                        1
                    </span>

                    Order Summary

                </h2>


                <div class="summary-box">

                    <div class="summary-row">

                        <div>

                            <div class="summary-label">
                                Total Amount
                            </div>

                            <div class="security-text">
                                Final amount is calculated securely
                                on the server.
                            </div>

                        </div>


                        <div class="total-amount">

                            ₹<%= String.format("%.2f", totalAmount) %>

                        </div>

                    </div>

                </div>

            </div>


            <!-- DELIVERY ADDRESS -->

            <div class="section">

                <h2 class="section-title">

                    <span class="section-number">
                        2
                    </span>

                    Delivery Address

                </h2>


                <%
                    if (addresses != null &&
                        !addresses.isEmpty()) {
                %>


                <form
                    action="${pageContext.request.contextPath}/checkout"
                    method="post"
                >


                    <input
                        type="hidden"
                        name="totalAmount"
                        value="<%= totalAmount %>"
                    >


                    <div class="address-list">


                        <%
                            for (Address address : addresses) {
                        %>


                        <label class="address-option">


                            <input
                                type="radio"
                                name="addressId"
                                value="<%= address.getAddressId() %>"
                                required
                            >


                            <span class="address-id">

                                Address #<%= address.getAddressId() %>

                            </span>


                            <span class="address-text">

                                <%= address.getAddressLine() %>,
                                <%= address.getCity() %>,
                                <%= address.getState() %>
                                -
                                <%= address.getPincode() %>

                            </span>


                        </label>


                        <%
                            }
                        %>


                    </div>


                    <div class="checkout-actions">


                        <a
                            href="${pageContext.request.contextPath}/cart"
                            class="back-button"
                        >

                            ← Back to Cart

                        </a>


                        <button
                            type="submit"
                            class="place-button"
                        >

                            ✓ Place Order

                        </button>


                    </div>


                </form>


                <%
                    } else {
                %>


                <div class="warning-box">

                    ⚠ No delivery address found.

                    <br>

                    Please add an address before placing
                    your order.

                </div>


                <div class="no-address-actions">

                    <a
                        href="${pageContext.request.contextPath}/cart"
                        class="back-button"
                        style="padding: 0 22px;"
                    >

                        ← Back to Cart

                    </a>

                </div>


                <%
                    }
                %>


            </div>


        </div>


    </div>


</body>

</html>