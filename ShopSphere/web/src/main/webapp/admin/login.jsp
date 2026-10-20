<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Admin Login
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            font-family: Arial, Helvetica, sans-serif;

            color: #172033;

            min-height: 100vh;

            display: flex;
            align-items: center;
            justify-content: center;

            padding: 30px 15px;

            background:
                radial-gradient(
                    circle at 0% 0%,
                    rgba(30, 41, 59, 0.12),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 100% 100%,
                    rgba(79, 70, 229, 0.10),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef3ff,
                    #f9fbff
                );
        }


        .admin-wrapper {
            width: 100%;
            max-width: 470px;
        }


        .brand {
            text-align: center;

            margin-bottom: 25px;
        }


        .brand-name {
            margin: 0;

            color: #111827;

            font-size: 34px;
            font-weight: 800;

            letter-spacing: -1px;
        }


        .brand-name span {
            color: #2563eb;
        }


        .brand-subtitle {
            margin-top: 7px;

            color: #64748b;

            font-size: 14px;
        }


        .admin-card {
            position: relative;

            overflow: hidden;

            background: rgba(255, 255, 255, 0.97);

            border: 1px solid #e5e7eb;

            border-radius: 25px;

            padding: 35px;

            box-shadow:
                0 20px 55px rgba(30, 41, 59, 0.12);
        }


        .admin-card::before {
            content: "";

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;
            height: 5px;

            background:
                linear-gradient(
                    90deg,
                    #1f2937,
                    #4f46e5
                );
        }


        .admin-icon {
            width: 65px;
            height: 65px;

            margin: 5px auto 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 18px;

            background: #eef2ff;

            color: #4338ca;

            font-size: 30px;
        }


        .admin-title {
            margin: 0;

            text-align: center;

            color: #111827;

            font-size: 30px;
            font-weight: 800;
        }


        .admin-description {
            margin: 10px 0 28px;

            text-align: center;

            color: #64748b;

            font-size: 14px;

            line-height: 1.5;
        }


        .error-box {
            margin-bottom: 20px;

            padding: 13px 15px;

            border-radius: 12px;

            background: #fef2f2;

            border: 1px solid #fecaca;

            color: #dc2626;

            font-size: 13px;

            font-weight: 600;
        }


        .form-group {
            margin-bottom: 19px;
        }


        .form-label {
            display: block;

            margin-bottom: 8px;

            color: #334155;

            font-size: 14px;

            font-weight: 700;
        }


        .form-input {
            width: 100%;

            height: 50px;

            padding: 0 15px;

            border: 1px solid #cbd5e1;

            border-radius: 11px;

            background: #f8fafc;

            color: #111827;

            font-size: 14px;

            outline: none;

            transition: all 0.2s ease;
        }


        .form-input:focus {
            border-color: #6366f1;

            background: white;

            box-shadow:
                0 0 0 4px rgba(99, 102, 241, 0.10);
        }


        .admin-login-button {
            width: 100%;

            min-height: 50px;

            margin-top: 5px;

            border: none;

            border-radius: 12px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #1f2937,
                    #111827
                );

            font-size: 15px;

            font-weight: 800;

            cursor: pointer;

            box-shadow:
                0 8px 18px rgba(15, 23, 42, 0.20);

            transition: all 0.2s ease;
        }


        .admin-login-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(15, 23, 42, 0.28);
        }


        .divider {
            display: flex;

            align-items: center;

            gap: 12px;

            margin: 25px 0 18px;
        }


        .divider-line {
            flex: 1;

            height: 1px;

            background: #e2e8f0;
        }


        .divider-text {
            color: #94a3b8;

            font-size: 12px;

            font-weight: 600;
        }


        .customer-link {
            display: flex;

            align-items: center;
            justify-content: center;

            min-height: 46px;

            border: 1px solid #cbd5e1;

            border-radius: 11px;

            color: #334155;

            background: #f8fafc;

            text-decoration: none;

            font-size: 14px;

            font-weight: 700;

            transition: all 0.2s ease;
        }


        .customer-link:hover {
            background: #eef2ff;

            border-color: #818cf8;

            color: #4338ca;

            transform: translateY(-1px);
        }


        .security-note {
            margin-top: 20px;

            text-align: center;

            color: #94a3b8;

            font-size: 11px;
        }


        @media (max-width: 520px) {

            .admin-card {
                padding: 25px 20px;
            }


            .brand-name {
                font-size: 30px;
            }


            .admin-title {
                font-size: 27px;
            }

        }

    </style>

</head>


<body>


    <div class="admin-wrapper">


        <div class="brand">

            <h1 class="brand-name">

                Shop<span>Sphere</span>

            </h1>

            <div class="brand-subtitle">

                Administration Portal

            </div>

        </div>


        <div class="admin-card">


            <div class="admin-icon">

                🛡

            </div>


            <h2 class="admin-title">

                Admin Login

            </h2>


            <p class="admin-description">

                Sign in to manage your ShopSphere store.

            </p>


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


            <form
                action="${pageContext.request.contextPath}/admin/login"
                method="post"
            >


                <div class="form-group">

                    <label class="form-label">

                        Admin Email

                    </label>


                    <input
                        type="email"
                        name="email"
                        class="form-input"
                        placeholder="Enter admin email"
                        autocomplete="email"
                        required
                    >

                </div>


                <div class="form-group">

                    <label class="form-label">

                        Password

                    </label>


                    <input
                        type="password"
                        name="password"
                        class="form-input"
                        placeholder="Enter admin password"
                        autocomplete="current-password"
                        required
                    >

                </div>


                <button
                    type="submit"
                    class="admin-login-button"
                >

                    🔐 Admin Login

                </button>


            </form>


            <div class="divider">

                <div class="divider-line"></div>

                <div class="divider-text">
                    CUSTOMER AREA
                </div>

                <div class="divider-line"></div>

            </div>


            <a
                href="${pageContext.request.contextPath}/login"
                class="customer-link"
            >

                ← Customer Login

            </a>


            <div class="security-note">

                🔒 Authorized administrators only

            </div>


        </div>


    </div>


</body>

</html>