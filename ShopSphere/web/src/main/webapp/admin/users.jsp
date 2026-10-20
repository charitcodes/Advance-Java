<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.User" %>

<%
    List<User> users = (List<User>) request.getAttribute("users");

    if (users == null) {
        users = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Users - ShopSphere Admin</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #1f2937;
        }

        .admin-navbar {
            min-height: 68px;
            padding: 0 35px;

            background: #202020;
            color: white;

            display: flex;
            align-items: center;
            justify-content: space-between;

            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.18);
        }

        .admin-logo {
            color: white;
            text-decoration: none;
            font-size: 27px;
            font-weight: 800;
        }

        .admin-logo span {
            color: #3b82f6;
        }

        .nav-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .nav-button {
            text-decoration: none;
            padding: 10px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            transition: 0.2s ease;
        }

        .dashboard-button {
            color: white;
            border: 1px solid #6b7280;
            background: transparent;
        }

        .dashboard-button:hover {
            background: white;
            color: #202020;
        }

        .logout-button {
            color: white;
            background: #dc3545;
        }

        .logout-button:hover {
            background: #bb2d3b;
        }

        .users-page {
            max-width: 1250px;
            margin: 0 auto;
            padding: 45px 25px 60px;
        }

        .small-title {
            color: #4f46e5;
            font-size: 13px;
            font-weight: 800;
            letter-spacing: 5px;
            margin-bottom: 10px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 20px;
            margin-bottom: 30px;
        }

        .page-header h1 {
            margin: 0;
            font-size: 38px;
            color: #111827;
        }

        .page-header p {
            margin: 10px 0 0;
            color: #64748b;
            font-size: 15px;
        }

        .user-count {
            min-width: 150px;
            padding: 15px 20px;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.05);
        }

        .user-count strong {
            display: block;
            color: #2563eb;
            font-size: 25px;
        }

        .user-count span {
            color: #64748b;
            font-size: 13px;
        }

        .table-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.07);
            border: 1px solid #e8edf3;
        }

        .table-header {
            padding: 22px 25px;
            border-bottom: 1px solid #edf0f4;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            margin: 0;
            font-size: 20px;
            color: #111827;
        }

        .table-header span {
            color: #64748b;
            font-size: 13px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        thead {
            background: #f8fafc;
        }

        th {
            padding: 15px 18px;
            text-align: left;
            color: #64748b;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 17px 18px;
            border-bottom: 1px solid #eef1f5;
            color: #334155;
            font-size: 14px;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .user-id {
            color: #2563eb;
            font-weight: 800;
        }

        .user-name {
            color: #111827;
            font-weight: 700;
        }

        .email {
            color: #475569;
        }

        .mobile {
            color: #475569;
        }

        .role-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
        }

        .customer-role {
            background: #eff6ff;
            color: #2563eb;
        }

        .admin-role {
            background: #fef2f2;
            color: #dc2626;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 800;
        }

        .active-status {
            background: #dcfce7;
            color: #15803d;
        }

        .inactive-status {
            background: #fee2e2;
            color: #b91c1c;
        }

        .empty-state {
            padding: 70px 25px;
            text-align: center;
        }

        .empty-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 18px;
            border-radius: 50%;
            background: #eff6ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
        }

        .empty-state h3 {
            margin: 0 0 8px;
            color: #111827;
            font-size: 21px;
        }

        .empty-state p {
            margin: 0;
            color: #64748b;
        }

        @media (max-width: 700px) {

            .admin-navbar {
                padding: 0 18px;
            }

            .admin-logo {
                font-size: 22px;
            }

            .users-page {
                padding: 30px 15px 50px;
            }

            .page-header {
                flex-direction: column;
                align-items: stretch;
            }

            .user-count {
                width: 100%;
            }

        }

    </style>

</head>


<body>


<!-- ADMIN NAVBAR -->

<nav class="admin-navbar">

    <a
        href="<%= request.getContextPath() %>/admin/dashboard.jsp"
        class="admin-logo"
    >
        Shop<span>Sphere</span> Admin
    </a>


    <div class="nav-actions">

        <a
            href="<%= request.getContextPath() %>/admin/dashboard.jsp"
            class="nav-button dashboard-button"
        >
            &#8592; Dashboard
        </a>

        <a
            href="<%= request.getContextPath() %>/logout"
            class="nav-button logout-button"
        >
            Logout
        </a>

    </div>

</nav>


<!-- USERS PAGE -->

<main class="users-page">


    <!-- HEADER -->

    <div class="page-header">

        <div>

            <div class="small-title">
                CUSTOMER MANAGEMENT
            </div>

            <h1>
                Users
            </h1>

            <p>
                View all registered ShopSphere users and their account status.
            </p>

        </div>


        <div class="user-count">

            <strong>
                <%= users.size() %>
            </strong>

            <span>
                Registered Users
            </span>

        </div>

    </div>


    <!-- USERS TABLE -->

    <div class="table-card">

        <div class="table-header">

            <h2>
                User Directory
            </h2>

            <span>
                Account information
            </span>

        </div>


        <% if (users.isEmpty()) { %>


            <div class="empty-state">

                <div class="empty-icon">
                    &#128100;
                </div>

                <h3>
                    No Users Found
                </h3>

                <p>
                    There are currently no registered users.
                </p>

            </div>


        <% } else { %>


            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                User ID
                            </th>

                            <th>
                                Name
                            </th>

                            <th>
                                Email
                            </th>

                            <th>
                                Mobile
                            </th>

                            <th>
                                Role
                            </th>

                            <th>
                                Status
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (User user : users) { %>

                        <tr>

                            <td>
                                <span class="user-id">
                                    #<%= user.getUserId() %>
                                </span>
                            </td>


                            <td>
                                <span class="user-name">
                                    <%= user.getName() %>
                                </span>
                            </td>


                            <td>
                                <span class="email">
                                    <%= user.getEmail() %>
                                </span>
                            </td>


                            <td>
                                <span class="mobile">
                                    <%= user.getMobile() == null
                                            ? "-"
                                            : user.getMobile() %>
                                </span>
                            </td>


                            <td>

                                <% if ("ADMIN".equalsIgnoreCase(user.getRole())) { %>

                                    <span class="role-badge admin-role">
                                        ADMIN
                                    </span>

                                <% } else { %>

                                    <span class="role-badge customer-role">
                                        CUSTOMER
                                    </span>

                                <% } %>

                            </td>


                            <td>

                                <% if (user.isStatus()) { %>

                                    <span class="status-badge active-status">
                                        ● Active
                                    </span>

                                <% } else { %>

                                    <span class="status-badge inactive-status">
                                        ● Inactive
                                    </span>

                                <% } %>

                            </td>

                        </tr>

                    <% } %>


                    </tbody>

                </table>

            </div>


        <% } %>


    </div>


</main>


</body>

</html>