<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        ShopSphere - Register
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
                    rgba(99, 102, 241, 0.14),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 100% 100%,
                    rgba(59, 130, 246, 0.12),
                    transparent 30%
                ),
                linear-gradient(
                    135deg,
                    #f8fbff,
                    #eef3ff,
                    #f9fbff
                );
        }


        .register-wrapper {
            width: 100%;
            max-width: 520px;
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


        .register-card {
            background: rgba(255, 255, 255, 0.97);

            border: 1px solid #e5e7eb;

            border-radius: 25px;

            padding: 35px;

            box-shadow:
                0 20px 55px rgba(30, 41, 59, 0.12);
        }


        .register-title {
            margin: 0;

            text-align: center;

            color: #111827;

            font-size: 30px;
            font-weight: 800;
        }


        .register-description {
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
            margin-bottom: 18px;
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


        .register-button {
            width: 100%;

            min-height: 50px;

            margin-top: 6px;

            border: none;

            border-radius: 12px;

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


        .register-button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(22, 163, 74, 0.28);
        }


        .login-text {
            margin: 24px 0 0;

            text-align: center;

            color: #64748b;

            font-size: 14px;
        }


        .login-link {
            color: #4f46e5;

            font-weight: 800;

            text-decoration: none;
        }


        .login-link:hover {
            text-decoration: underline;
        }


        .footer-text {
            margin-top: 20px;

            text-align: center;

            color: #94a3b8;

            font-size: 11px;
        }


        @media (max-width: 550px) {

            .register-card {
                padding: 25px 20px;
            }


            .brand-name {
                font-size: 30px;
            }


            .register-title {
                font-size: 27px;
            }

        }

    </style>

</head>


<body>


    <div class="register-wrapper">


        <div class="brand">

            <h1 class="brand-name">

                Shop<span>Sphere</span>

            </h1>

            <div class="brand-subtitle">

                Create your account and start shopping

            </div>

        </div>


        <div class="register-card">


            <h2 class="register-title">

                Create Your Account

            </h2>


            <p class="register-description">

                Join ShopSphere and enjoy a simple,
                secure shopping experience.

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
                action="${pageContext.request.contextPath}/register"
                method="post"
            >


                <div class="form-group">

                    <label class="form-label">

                        Full Name

                    </label>


                    <input
                        type="text"
                        name="name"
                        class="form-input"
                        placeholder="Enter your full name"
                        autocomplete="name"
                        required
                    >

                </div>


                <div class="form-group">

                    <label class="form-label">

                        Email Address

                    </label>


                    <input
                        type="email"
                        name="email"
                        class="form-input"
                        placeholder="Enter your email"
                        autocomplete="email"
                        required
                    >

                </div>


                <div class="form-group">

                    <label class="form-label">

                        Mobile Number

                    </label>


                    <input
                        type="tel"
                        name="mobile"
                        class="form-input"
                        placeholder="Enter your mobile number"
                        autocomplete="tel"
                        pattern="[0-9]{10}"
                        maxlength="10"
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
                        placeholder="Create a password"
                        autocomplete="new-password"
                        minlength="6"
                        required
                    >

                </div>


                <button
                    type="submit"
                    class="register-button"
                >

                    ✓ Create Account

                </button>


            </form>


            <div class="login-text">

                Already have an account?

                <a
                    href="${pageContext.request.contextPath}/login"
                    class="login-link"
                >

                    Login

                </a>

            </div>


            <div class="footer-text">

                © ShopSphere • Secure Shopping

            </div>


        </div>


    </div>


</body>

</html>