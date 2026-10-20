<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Payment Successful
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
                    rgba(34, 197, 94, 0.10),
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


        .success-page {
            max-width: 850px;
            margin: 0 auto;
            padding: 60px 20px 80px;
        }


        .success-card {
            position: relative;

            overflow: hidden;

            background: rgba(255, 255, 255, 0.97);

            border: 1px solid #e5e7eb;
            border-radius: 28px;

            padding: 50px 35px;

            text-align: center;

            box-shadow:
                0 20px 55px rgba(30, 41, 59, 0.12);
        }


        .success-card::before {
            content: "";

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;
            height: 6px;

            background:
                linear-gradient(
                    90deg,
                    #16a34a,
                    #22c55e,
                    #4f46e5
                );
        }


        .success-icon {
            width: 95px;
            height: 95px;

            margin: 5px auto 25px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #dcfce7;

            color: #16a34a;

            font-size: 48px;
            font-weight: 800;

            box-shadow:
                0 12px 30px rgba(22, 163, 74, 0.15);
        }


        .small-title {
            display: inline-block;

            margin-bottom: 12px;

            color: #16a34a;

            font-size: 13px;
            font-weight: 800;

            letter-spacing: 4px;
        }


        .success-title {
            margin: 0;

            color: #15803d;

            font-size: 40px;
            font-weight: 800;
        }


        .success-message {
            max-width: 560px;

            margin: 15px auto 28px;

            color: #64748b;

            font-size: 16px;
            line-height: 1.6;
        }


        .order-box {
            max-width: 500px;

            margin: 0 auto 30px;

            padding: 20px;

            border-radius: 16px;

            background:
                linear-gradient(
                    135deg,
                    #f0fdf4,
                    #ecfdf5
                );

            border: 1px solid #bbf7d0;
        }


        .order-label {
            color: #64748b;

            font-size: 12px;
            font-weight: 700;

            letter-spacing: 1px;

            margin-bottom: 7px;
        }


        .order-id {
            color: #111827;

            font-size: 24px;
            font-weight: 800;
        }


        .actions {
            display: flex;

            justify-content: center;

            gap: 12px;

            flex-wrap: wrap;
        }


        .action-button {
            min-height: 48px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            padding: 0 23px;

            border-radius: 12px;

            text-decoration: none;

            font-size: 14px;
            font-weight: 800;

            transition: all 0.2s ease;
        }


        .orders-button {
            color: white;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            box-shadow:
                0 8px 18px rgba(37, 99, 235, 0.20);
        }


        .orders-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(37, 99, 235, 0.28);
        }


        .shopping-button {
            color: #334155;

            background: #f8fafc;

            border: 1px solid #cbd5e1;
        }


        .shopping-button:hover {
            background: #eef2ff;

            border-color: #818cf8;

            transform: translateY(-2px);
        }


        .secure-note {
            margin-top: 30px;

            color: #64748b;

            font-size: 12px;
        }


        @media (max-width: 600px) {

            .success-page {
                padding: 35px 15px 60px;
            }


            .success-card {
                padding: 40px 20px;
            }


            .success-title {
                font-size: 31px;
            }


            .success-message {
                font-size: 14px;
            }


            .actions {
                flex-direction: column;
            }


            .action-button {
                width: 100%;
            }

        }

    </style>

</head>


<body>


    <jsp:include page="fragments/navbar.jspf" />


    <div class="success-page">


        <div class="success-card">


            <div class="success-icon">

                ✓

            </div>


            <div class="small-title">

                SHOPSPHERE PAYMENT

            </div>


            <h1 class="success-title">

                Payment Successful

            </h1>


            <p class="success-message">

                Your payment has been processed successfully.
                Thank you for shopping with ShopSphere!

            </p>


            <div class="order-box">


                <div class="order-label">

                    ORDER ID

                </div>


                <div class="order-id">

                    #<%= request.getParameter("orderId") %>

                </div>


            </div>


            <div class="actions">


                <a
                    href="${pageContext.request.contextPath}/orders"
                    class="action-button orders-button"
                >

                    📦 My Orders

                </a>


                <a
                    href="${pageContext.request.contextPath}/products"
                    class="action-button shopping-button"
                >

                    🛍 Continue Shopping

                </a>


            </div>


            <div class="secure-note">

                ✓ Your order has been recorded successfully.

            </div>


        </div>


    </div>


</body>

</html>