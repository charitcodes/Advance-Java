
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%

Integer totalProducts =
    (Integer) request.getAttribute("totalProducts");

Integer totalCustomers =
    (Integer) request.getAttribute("totalCustomers");

Integer totalOrders =
    (Integer) request.getAttribute("totalOrders");

Double totalSales =
    (Double) request.getAttribute("totalSales");

Integer lowStockProducts =
    (Integer) request.getAttribute("lowStockProducts");

totalProducts = (totalProducts == null) ? 0 : totalProducts;
totalCustomers = (totalCustomers == null) ? 0 : totalCustomers;
totalOrders = (totalOrders == null) ? 0 : totalOrders;
totalSales = (totalSales == null) ? 0.0 : totalSales;
lowStockProducts = (lowStockProducts == null) ? 0 : lowStockProducts;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere Admin Dashboard</title>
    <style>
        * { box-sizing: border-box; }

        :root {
            --ink: #171b2b;
            --muted: #64748b;
            --line: #e2e8f0;
            --blue: #4f63e9;
            --green: #56a05a;
            --orange: #c98128;
            --teal: #5595b3;
            --purple: #8b3fe5;
            --page: #f3f5ff;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Inter, "Segoe UI", Arial, sans-serif;
            color: var(--ink);
            background: radial-gradient(circle at top left, #eceeff 0, var(--page) 52%, #f8faff 100%);
        }

        a { color: inherit; }

        .admin-navbar {
            min-height: 72px;
            padding: 14px clamp(18px, 4vw, 52px);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            background: #171717;
            color: #fff;
            box-shadow: 0 5px 18px rgba(15, 23, 42, .16);
        }

        .admin-logo {
            color: #fff;
            font-size: clamp(22px, 2.2vw, 30px);
            font-weight: 850;
            letter-spacing: -.6px;
            text-decoration: none;
        }

        .admin-logo span { color: #83a8ff; }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 42px;
            padding: 0 18px;
            border: 1px solid #687080;
            border-radius: 12px;
            color: #fff;
            font-weight: 700;
            text-decoration: none;
            transition: background .18s ease, transform .18s ease;
        }

        .nav-button:hover {
            background: #303030;
            transform: translateY(-1px);
        }

        .dashboard {
            width: min(100% - 40px, 1500px);
            margin: 0 auto;
            padding: 34px 0 28px;
        }

        .dashboard-header {
            margin-bottom: 28px;
            max-width: 900px;
        }

        .small-title {
            margin-bottom: 12px;
            color: #5a4bea;
            font-size: 14px;
            font-weight: 900;
            letter-spacing: 4px;
        }

        .dashboard-header h1 {
            margin: 0;
            font-size: clamp(34px, 4vw, 52px);
            line-height: 1.12;
            letter-spacing: -1.7px;
            font-weight: 850;
        }

        .dashboard-header p {
            margin: 16px 0 0;
            color: var(--muted);
            font-size: 18px;
            line-height: 1.6;
            max-width: 820px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 38px;
        }

        .stat-card {
            --accent: var(--blue);
            position: relative;
            min-width: 0;
            min-height: 176px;
            overflow: hidden;
            padding: 24px 25px 27px;
            border: 1px solid rgba(226, 232, 240, .95);
            border-radius: 22px;
            background: rgba(255, 255, 255, .96);
            box-shadow: 0 14px 34px rgba(31, 41, 75, .08);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .stat-card::after {
            content: "";
            position: absolute;
            height: 5px;
            bottom: 0;
            left: 0;
            right: 0;
            background: var(--accent);
        }

        .products-stat { --accent: var(--blue); }
        .customers-stat { --accent: var(--teal); }
        .orders-stat { --accent: var(--orange); }
        .sales-stat { --accent: var(--green); }
        .stock-stat {
            --accent: #ce4032;
            text-decoration: none;
            transition: transform .18s ease, box-shadow .18s ease;
        }

        .stock-stat:hover {
            transform: translateY(-3px);
            box-shadow: 0 18px 38px rgba(31, 41, 75, .13);
        }

        .stat-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }

        .stat-label {
            color: var(--muted);
            font-size: 13px;
            font-weight: 850;
            letter-spacing: .7px;
            text-transform: uppercase;
        }

        .stat-icon {
            display: grid;
            place-items: center;
            flex: 0 0 52px;
            width: 52px;
            height: 52px;
            border-radius: 16px;
            font-size: 25px;
            background: #e3eaff;
        }

        .customers-stat .stat-icon { background: #ddf8fc; }
        .orders-stat .stat-icon { background: #fff4c9; }
        .sales-stat .stat-icon { background: #e1fae6; }
        .stock-stat .stat-icon { background: #fbe5e3; }

        .stat-value {
            margin-top: 18px;
            font-size: clamp(27px, 2.2vw, 36px);
            font-weight: 900;
            line-height: 1.1;
            letter-spacing: -.8px;
            overflow-wrap: anywhere;
        }

        .section-heading { margin: 0 0 20px; }

        .section-heading h2 {
            margin: 0;
            font-size: 28px;
            letter-spacing: -.5px;
        }

        .section-heading p {
            margin: 7px 0 0;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.5;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            align-items: stretch;
            gap: 22px;
        }

        .admin-card {
            --accent: var(--blue);
            min-width: 0;
            min-height: 300px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 30px;
            background: rgba(255, 255, 255, .97);
            border: 1px solid var(--line);
            border-radius: 25px;
            box-shadow: 0 14px 34px rgba(31, 41, 75, .08);
            position: relative;
            overflow: hidden;
            transition: transform .18s ease, box-shadow .18s ease;
        }

        .admin-card::after {
            content: "";
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;
            height: 5px;
            background: var(--accent);
        }

        .admin-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 18px 40px rgba(31, 41, 75, .12);
        }

        .products-card { --accent: var(--blue); }
        .categories-card { --accent: var(--green); }
        .orders-card { --accent: var(--orange); }
        .users-card { --accent: var(--teal); }
        .coupons-card { --accent: var(--purple); }

        .card-icon {
            width: 70px;
            height: 70px;
            display: grid;
            place-items: center;
            border-radius: 20px;
            background: #e3eaff;
            font-size: 32px;
            margin-bottom: 24px;
        }

        .categories-card .card-icon { background: #e4fae8; }
        .orders-card .card-icon { background: #fff4c9; }
        .users-card .card-icon { background: #ddf8fc; }
        .coupons-card .card-icon { background: #f2e7ff; }

        .admin-card h3 {
            margin: 0 0 12px;
            font-size: 27px;
            line-height: 1.2;
            letter-spacing: -.5px;
        }

        .admin-card p {
            margin: 0 0 22px;
            color: var(--muted);
            font-size: 16px;
            line-height: 1.6;
        }

        .card-button {
            margin-top: auto;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 48px;
            max-width: 100%;
            padding: 0 19px;
            border-radius: 12px;
            background: var(--accent);
            color: #fff;
            font-weight: 800;
            text-decoration: none;
            line-height: 1.3;
            transition: filter .18s ease, transform .18s ease;
        }

        .card-button:hover {
            filter: brightness(.94);
            transform: translateY(-1px);
        }

        .dashboard-footer {
            margin-top: 28px;
            padding: 18px 22px;
            text-align: center;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.5;
            border: 1px solid var(--line);
            border-radius: 16px;
            background: rgba(255, 255, 255, .75);
        }

        @media (max-width: 1200px) {
            .stats-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); }
            .admin-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        }

        @media (max-width: 700px) {
            .dashboard {
                width: min(100% - 28px, 1500px);
                padding-top: 26px;
            }

            .admin-navbar { padding: 14px; }

            .nav-button {
                padding: 0 12px;
                font-size: 13px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 12px;
            }

            .stat-card {
                padding: 17px;
                min-height: 150px;
                border-radius: 17px;
            }

            .stat-icon {
                width: 42px;
                height: 42px;
                flex-basis: 42px;
                font-size: 21px;
                border-radius: 13px;
            }

            .stat-label { font-size: 11px; }
            .admin-grid { grid-template-columns: 1fr; gap: 16px; }
            .admin-card { min-height: 265px; padding: 24px; }
            .dashboard-header p { font-size: 16px; }
        }

        @media (max-width: 420px) {
            .admin-logo { font-size: 20px; }
            .nav-actions { gap: 6px; }
            .nav-button { padding: 0 9px; }
            .stats-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <nav class="admin-navbar">
        <a class="admin-logo" href="${pageContext.request.contextPath}/admin/dashboard">Shop<span>Sphere</span> Admin</a>
        <div class="nav-actions">
            <a class="nav-button" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a class="nav-button" href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>

    <main class="dashboard">
        <header class="dashboard-header">
            <div class="small-title">ADMIN CONTROL CENTER</div>
            <h1>Admin Dashboard</h1>
            <p>Manage your ShopSphere store, monitor performance and control your complete e-commerce system from one place.</p>
        </header>

        <section class="stats-grid" aria-label="Store statistics">
            <div class="stat-card products-stat">
                <div class="stat-top">
                    <div class="stat-label">Products</div>
                    <div class="stat-icon">📦</div>
                </div>
                <div class="stat-value"><%= totalProducts %></div>
            </div>

            <div class="stat-card customers-stat">
                <div class="stat-top">
                    <div class="stat-label">Customers</div>
                    <div class="stat-icon">👥</div>
                </div>
                <div class="stat-value"><%= totalCustomers %></div>
            </div>

            <div class="stat-card orders-stat">
                <div class="stat-top">
                    <div class="stat-label">Orders</div>
                    <div class="stat-icon">🛒</div>
                </div>
                <div class="stat-value"><%= totalOrders %></div>
            </div>

            <div class="stat-card sales-stat">
                <div class="stat-top">
                    <div class="stat-label">Total Sales</div>
                    <div class="stat-icon">💰</div>
                </div>
                <div class="stat-value">&#8377;<%= String.format("%,.0f", totalSales) %></div>
            </div>

            <a class="stat-card stock-stat"
               href="${pageContext.request.contextPath}/admin/low-stock"
               title="View low stock products">
                <div class="stat-top">
                    <div class="stat-label">Low Stock</div>
                    <div class="stat-icon">⚠️</div>
                </div>
                <div class="stat-value"><%= lowStockProducts %></div>
            </a>
        </section>

        <section class="management-section" aria-labelledby="management-heading">
            <div class="section-heading">
                <h2 id="management-heading">Store Management</h2>
                <p>Manage products, categories, orders, customers and discount coupons.</p>
            </div>

            <div class="admin-grid">
                <article class="admin-card products-card">
                    <div class="card-icon">📦</div>
                    <h3>Products</h3>
                    <p>Add, update and manage products, prices, discounts and inventory.</p>
                    <a class="card-button" href="${pageContext.request.contextPath}/admin/products">Manage Products →</a>
                </article>

                <article class="admin-card categories-card">
                    <div class="card-icon">🗂️</div>
                    <h3>Categories</h3>
                    <p>Manage product categories and organize your store catalog.</p>
                    <a class="card-button" href="${pageContext.request.contextPath}/admin/categories">Manage Categories →</a>
                </article>

                <article class="admin-card orders-card">
                    <div class="card-icon">🛒</div>
                    <h3>Orders</h3>
                    <p>View customer orders and monitor the current order status.</p>
                    <a class="card-button" href="${pageContext.request.contextPath}/admin/orders">Manage Orders →</a>
                </article>

                <article class="admin-card users-card">
                    <div class="card-icon">👥</div>
                    <h3>Customers</h3>
                    <p>View registered customers and manage customer information.</p>
                    <a class="card-button" href="${pageContext.request.contextPath}/admin/users">Manage Users →</a>
                </article>

                <article class="admin-card coupons-card">
                    <div class="card-icon">🎟️</div>
                    <h3>Coupons</h3>
                    <p>Create, update and manage discount coupons for your customers.</p>
                    <a class="card-button" href="${pageContext.request.contextPath}/admin/coupons">Manage Coupons →</a>
                </article>
            </div>
        </section>

        <footer class="dashboard-footer">
            🔐 ShopSphere Administration Portal &nbsp; • &nbsp; Authorized administrators only
        </footer>
    </main>
</body>
</html>
