<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.shopsphere.model.Order" %>

<%
    Order order =
            (Order) request.getAttribute("order");

    response.setBufferSize(65536);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Payment
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


        .payment-page {
            max-width: 850px;
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


        .payment-card {
            background: rgba(255, 255, 255, 0.96);

            border: 1px solid #e5e7eb;
            border-radius: 26px;

            padding: 30px;

            box-shadow:
                0 18px 45px rgba(30, 41, 59, 0.10);
        }


        .order-summary {
            padding: 25px;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #eff6ff
                );

            border: 1px solid #c7d2fe;

            margin-bottom: 30px;
        }


        .summary-top {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            margin-bottom: 18px;
        }


        .summary-title {
            margin: 0;

            font-size: 21px;
            font-weight: 800;
        }


        .order-badge {
            padding: 7px 12px;

            border-radius: 999px;

            background: white;
            color: #4f46e5;

            font-size: 12px;
            font-weight: 800;
        }


        .summary-row {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 15px;

            padding-top: 18px;

            border-top: 1px solid #c7d2fe;
        }


        .amount-label {
            color: #64748b;

            font-size: 14px;
            font-weight: 600;
        }


        .amount {
            color: #2563eb;

            font-size: 30px;
            font-weight: 800;
        }


        .section-title {
            margin: 0 0 18px;

            font-size: 23px;
            font-weight: 800;
        }


        .payment-methods {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;

            margin-bottom: 25px;
        }


        .method-option {
            position: relative;

            cursor: pointer;
        }


        .method-option input {
            position: absolute;

            opacity: 0;
        }


        .method-content {
            min-height: 115px;

            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;

            gap: 8px;

            text-align: center;

            border: 2px solid #e2e8f0;
            border-radius: 16px;

            background: white;

            transition: all 0.2s ease;
        }


        .method-icon {
            font-size: 30px;
        }


        .method-name {
            color: #334155;

            font-size: 14px;
            font-weight: 800;
        }


        .method-description {
            color: #94a3b8;

            font-size: 11px;
        }


        .method-option:hover .method-content {
            border-color: #818cf8;

            background: #f8fafc;

            transform: translateY(-2px);
        }


        .method-option input:checked + .method-content {
            border-color: #4f46e5;

            background: #eef2ff;

            box-shadow:
                0 8px 20px rgba(79, 70, 229, 0.12);
        }


        .pay-button {
            width: 100%;
            min-height: 52px;

            border: none;
            border-radius: 13px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #16a34a,
                    #15803d
                );

            font-size: 15px;
            font-weight: 800;

            cursor: pointer;

            box-shadow:
                0 8px 18px rgba(22, 163, 74, 0.22);

            transition: all 0.2s ease;
        }


        .pay-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(22, 163, 74, 0.28);
        }


        .secure-note {
            margin-top: 16px;

            text-align: center;

            color: #64748b;

            font-size: 12px;
        }


        .not-found {
            text-align: center;

            padding: 50px 30px;

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
            margin: 0 0 25px;

            color: #64748b;
        }


        .orders-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            min-height: 45px;

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
        }


        @media (max-width: 650px) {

            .payment-page {
                padding: 30px 15px 50px;
            }


            .page-header h1 {
                font-size: 32px;
            }


            .payment-card {
                padding: 20px;
            }


            .summary-top {
                align-items: flex-start;

                flex-direction: column;
            }


            .summary-row {
                align-items: flex-start;

                flex-direction: column;
            }


            .payment-methods {
                grid-template-columns: 1fr;
            }


            .amount {
                font-size: 26px;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="payment-page">


        <div class="page-header">

            <div class="small-title">
                SHOPSPHERE SECURE CHECKOUT
            </div>

            <h1>
                Payment
            </h1>

            <p>
                Choose your preferred payment method to
                complete your order.
            </p>

        </div>


        <%
            if (order == null) {
        %>


        <div class="not-found">

            <div class="not-found-icon">
                🔍
            </div>

            <h2>
                Order Not Found
            </h2>

            <p>
                The requested order could not be found.
            </p>

            <a
                href="${pageContext.request.contextPath}/orders"
                class="orders-button"
            >

                ← Back to My Orders

            </a>

        </div>


        <%
            } else {
        %>


        <div class="payment-card">


            <div class="order-summary">


                <div class="summary-top">

                    <h2 class="summary-title">
                        Order Summary
                    </h2>

                    <div class="order-badge">

                        Order #<%= order.getOrderId() %>

                    </div>

                </div>


                <div class="summary-row">

                    <div class="amount-label">

                        Amount to Pay

                    </div>

                    <div class="amount">

                        ₹<%= order.getTotalAmount() %>

                    </div>

                </div>


            </div>


            <form
                action="${pageContext.request.contextPath}/payment"
                method="post"
            >


                <input
                    type="hidden"
                    name="orderId"
                    value="<%= order.getOrderId() %>"
                >


                <h2 class="section-title">

                    Select Payment Method

                </h2>


                <div class="payment-methods">


                    <label class="method-option">


                        <input
                            type="radio"
                            name="paymentMethod"
                            value="UPI"
                            required
                        >


                        <div class="method-content">

                            <div class="method-icon">
                                📱
                            </div>

                            <div class="method-name">
                                UPI
                            </div>

                            <div class="method-description">
                                Fast & convenient
                            </div>

                        </div>


                    </label>


                    <label class="method-option">


                        <input
                            type="radio"
                            name="paymentMethod"
                            value="CARD"
                            required
                        >


                        <div class="method-content">

                            <div class="method-icon">
                                💳
                            </div>

                            <div class="method-name">
                                Card
                            </div>

                            <div class="method-description">
                                Debit / Credit Card
                            </div>

                        </div>


                    </label>


                    <label class="method-option">


                        <input
                            type="radio"
                            name="paymentMethod"
                            value="COD"
                            required
                        >


                        <div class="method-content">

                            <div class="method-icon">
                                📦
                            </div>

                            <div class="method-name">
                                Cash on Delivery
                            </div>

                            <div class="method-description">
                                Pay when delivered
                            </div>

                        </div>


                    </label>


                </div>


                <button
                    type="submit"
                    class="pay-button"
                >

                    💳 Pay ₹<%= order.getTotalAmount() %>

                </button>


                <div class="secure-note">

                    🔒 Secure mock payment • Your order information
                    is protected.

                </div>


            </form>


        </div>


        <%
            }
        %>


    </div>


</body>

</html>