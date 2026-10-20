<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Category" %>

<%
    List<Category> categories =
            (List<Category>) request.getAttribute("categories");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Manage Categories - ShopSphere Admin</title>

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

        /* TOP BAR */

        .topbar {
            background: #202020;
            color: white;
            min-height: 68px;
            padding: 0 35px;

            display: flex;
            align-items: center;
            justify-content: space-between;

            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.18);
        }

        .logo {
            color: white;
            text-decoration: none;
            font-size: 27px;
            font-weight: 800;
        }

        .logo span {
            color: #3b82f6;
        }

        .admin-info {
            color: #d1d5db;
            font-size: 14px;
        }

        /* CONTAINER */

        .container {
            width: 100%;
            max-width: 1250px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* HEADER */

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;

            margin-bottom: 28px;
        }

        .page-title {
            margin: 0;
            font-size: 32px;
            color: #111827;
        }

        .page-subtitle {
            margin: 7px 0 0;
            color: #6b7280;
            font-size: 14px;
        }

        .add-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            padding: 12px 20px;

            background: #2563eb;
            color: white;

            text-decoration: none;
            border-radius: 8px;

            font-size: 14px;
            font-weight: 700;

            transition: 0.2s ease;
        }

        .add-button:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }

        /* STAT CARD */

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px 24px;
            margin-bottom: 25px;

            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);

            display: inline-flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 45px;
            height: 45px;

            border-radius: 10px;

            background: #eff6ff;
            color: #2563eb;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 22px;
            font-weight: 700;
        }

        .stat-number {
            font-size: 22px;
            font-weight: 800;
            color: #111827;
        }

        .stat-label {
            color: #6b7280;
            font-size: 13px;
            margin-top: 2px;
        }

        /* TABLE CARD */

        .table-card {
            background: white;
            border-radius: 14px;
            overflow: hidden;

            box-shadow: 0 7px 25px rgba(0, 0, 0, 0.07);
        }

        .table-header {
            padding: 20px 24px;
            border-bottom: 1px solid #e5e7eb;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            margin: 0;
            font-size: 18px;
            color: #111827;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 700px;
        }

        th {
            background: #f8fafc;
            color: #4b5563;

            text-align: left;

            padding: 15px 18px;

            font-size: 13px;
            font-weight: 700;

            border-bottom: 1px solid #e5e7eb;
        }

        td {
            padding: 17px 18px;

            border-bottom: 1px solid #eef0f3;

            font-size: 14px;
            color: #374151;
        }

        tbody tr {
            transition: 0.15s ease;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        /* CATEGORY ID */

        .category-id {
            font-weight: 700;
            color: #6b7280;
        }

        /* CATEGORY NAME */

        .category-name {
            font-weight: 700;
            color: #111827;
        }

        /* DESCRIPTION */

        .description {
            max-width: 420px;
            color: #6b7280;

            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* ACTIONS */

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            padding: 8px 13px;

            border-radius: 6px;

            text-decoration: none;

            font-size: 12px;
            font-weight: 700;

            border: none;
            cursor: pointer;

            transition: 0.2s ease;
        }

        .edit-button {
            background: #eff6ff;
            color: #2563eb;
        }

        .edit-button:hover {
            background: #dbeafe;
        }

        .delete-button {
            background: #fef2f2;
            color: #dc2626;
        }

        .delete-button:hover {
            background: #fee2e2;
        }

        /* EMPTY STATE */

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-icon {
            font-size: 45px;
            margin-bottom: 12px;
        }

        .empty-title {
            font-size: 20px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 8px;
        }

        .empty-text {
            color: #6b7280;
            margin-bottom: 20px;
        }

        /* BACK BUTTON */

        .dashboard-button {
    display: inline-flex;
    align-items: center;
    gap: 9px;

    margin-top: 22px;
    padding: 11px 17px;

    background: white;
    color: #2563eb;

    border: 1px solid #dbeafe;
    border-radius: 8px;

    text-decoration: none;

    font-size: 14px;
    font-weight: 700;

    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);

    transition: 0.2s ease;
}

        .dashboard-button:hover {
            background: #eff6ff;
            border-color: #93c5fd;
            transform: translateY(-1px);
        }

        .dashboard-icon {
            font-size: 18px;
            line-height: 1;
        }
        /* RESPONSIVE */

        @media (max-width: 700px) {

            .topbar {
                padding: 0 18px;
            }

            .logo {
                font-size: 22px;
            }

            .admin-info {
                font-size: 12px;
            }

            .container {
                margin-top: 25px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .add-button {
                width: 100%;
            }

            .page-title {
                font-size: 27px;
            }

        }

    </style>

</head>

<body>


<!-- TOP BAR -->

<div class="topbar">

    <a
        href="<%= request.getContextPath() %>/admin/dashboard.jsp"
        class="logo"
    >
        Shop<span>Sphere</span>
    </a>

    <div class="admin-info">
        Admin Panel
    </div>

</div>


<!-- MAIN CONTAINER -->

<div class="container">


    <!-- PAGE HEADER -->

    <div class="page-header">

        <div>

            <h1 class="page-title">
                Categories
            </h1>

            <p class="page-subtitle">
                Create, edit and manage product categories.
            </p>

        </div>


        <a
            href="<%= request.getContextPath() %>/admin/categories?action=add"
            class="add-button"
        >
            + Add Category
        </a>

    </div>


    <!-- STAT -->

    <div class="stat-card">

        <div class="stat-icon">
            #
        </div>

        <div>

            <div class="stat-number">
                <%= categories == null ? 0 : categories.size() %>
            </div>

            <div class="stat-label">
                Total Categories
            </div>

        </div>

    </div>


    <!-- CATEGORY TABLE -->

    <div class="table-card">

        <div class="table-header">

            <h2 class="table-title">
                All Categories
            </h2>

        </div>


        <% if (categories != null && !categories.isEmpty()) { %>


        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>
                            ID
                        </th>

                        <th>
                            Category Name
                        </th>

                        <th>
                            Description
                        </th>

                        <th>
                            Actions
                        </th>

                    </tr>

                </thead>


                <tbody>

                <% for (Category category : categories) { %>

                    <tr>

                        <td>

                            <span class="category-id">
                                #<%= category.getCategoryId() %>
                            </span>

                        </td>


                        <td>

                            <span class="category-name">
                                <%= category.getName() %>
                            </span>

                        </td>


                        <td>

                            <div class="description">

                                <%
                                    String description =
                                            category.getDescription();

                                    if (description == null ||
                                        description.trim().isEmpty()) {

                                        description =
                                                "No description available";
                                    }
                                %>

                                <%= description %>

                            </div>

                        </td>


                        <td>

                            <div class="actions">


                                <!-- EDIT -->

                                <a
                                    href="<%= request.getContextPath() %>/admin/categories?action=edit&id=<%= category.getCategoryId() %>"
                                    class="action-button edit-button"
                                >
                                    Edit
                                </a>


                                <!-- DELETE -->

                                <form
                                    method="POST"
                                    action="<%= request.getContextPath() %>/admin/categories"
                                    onsubmit="return confirmDelete();"
                                    style="margin: 0;"
                                >

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="delete"
                                    >

                                    <input
                                        type="hidden"
                                        name="categoryId"
                                        value="<%= category.getCategoryId() %>"
                                    >

                                    <button
                                        type="submit"
                                        class="action-button delete-button"
                                    >
                                        Delete
                                    </button>

                                </form>


                            </div>

                        </td>

                    </tr>

                <% } %>

                </tbody>

            </table>

        </div>


        <% } else { %>


        <!-- EMPTY STATE -->

        <div class="empty-state">

            <div class="empty-icon">
                📂
            </div>

            <div class="empty-title">
                No Categories Found
            </div>

            <div class="empty-text">
                Create your first product category to get started.
            </div>

            <a
                href="<%= request.getContextPath() %>/admin/categories?action=add"
                class="add-button"
            >
                + Add Category
            </a>

        </div>


        <% } %>

    </div>


    <!-- BACK -->

    <a
    href="<%= request.getContextPath() %>/admin/dashboard.jsp"
    class="dashboard-button"
>
    <span class="dashboard-icon">&#8962;</span>
    Back to Admin Dashboard
</a>


</div>


<script>

    function confirmDelete() {

        return confirm(
            "Are you sure you want to delete this category?"
        );

    }

</script>


</body>

</html>