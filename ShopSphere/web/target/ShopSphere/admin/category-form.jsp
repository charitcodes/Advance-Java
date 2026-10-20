<%@ page import="com.shopsphere.model.Category" %>

<%
    Category category =
            (Category) request.getAttribute("category");

    boolean editMode = category != null;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= editMode ? "Edit Category" : "Add Category" %>
        - ShopSphere Admin
    </title>

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

        .topbar {
            background: #202020;
            color: white;
            padding: 18px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 26px;
            font-weight: 800;
        }

        .logo span {
            color: #3b82f6;
        }

        .admin-label {
            font-size: 14px;
            color: #d1d5db;
        }

        .container {
            width: 100%;
            max-width: 850px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #2563eb;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .card {
            background: white;
            border-radius: 14px;
            padding: 35px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .title {
            margin: 0 0 8px;
            font-size: 30px;
            color: #111827;
        }

        .subtitle {
            margin: 0 0 30px;
            color: #6b7280;
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: #374151;
        }

        .required {
            color: #dc3545;
        }

        input,
        textarea {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: 0.2s;
        }

        input:focus,
        textarea:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        textarea {
            min-height: 140px;
            resize: vertical;
        }

        .button-row {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .button {
            border: none;
            border-radius: 8px;
            padding: 13px 24px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .save-button {
            background: #2563eb;
            color: white;
        }

        .save-button:hover {
            background: #1d4ed8;
        }

        .cancel-button {
            background: #e5e7eb;
            color: #374151;
        }

        .cancel-button:hover {
            background: #d1d5db;
        }

        @media (max-width: 600px) {

            .topbar {
                padding: 15px 20px;
            }

            .logo {
                font-size: 22px;
            }

            .card {
                padding: 25px 20px;
            }

            .title {
                font-size: 25px;
            }

            .button-row {
                flex-direction: column;
            }

            .button {
                width: 100%;
            }
        }

    </style>

</head>

<body>

    <div class="topbar">

        <div class="logo">
            Shop<span>Sphere</span>
        </div>

        <div class="admin-label">
            Admin Panel
        </div>

    </div>


    <div class="container">

        <a
            href="<%= request.getContextPath() %>/admin/categories"
            class="back-link"
        >
            ← Back to Categories
        </a>


        <div class="card">

            <h1 class="title">

                <%= editMode
                        ? "Edit Category"
                        : "Add New Category" %>

            </h1>

            <p class="subtitle">

                <%= editMode
                        ? "Update the category information below."
                        : "Create a new product category for ShopSphere." %>

            </p>


            <form
                method="POST"
                action="<%= request.getContextPath() %>/admin/categories"
            >

                <% if (editMode) { %>

                    <input
                        type="hidden"
                        name="action"
                        value="update"
                    >

                    <input
                        type="hidden"
                        name="categoryId"
                        value="<%= category.getCategoryId() %>"
                    >

                <% } else { %>

                    <input
                        type="hidden"
                        name="action"
                        value="add"
                    >

                <% } %>


                <div class="form-group">

                    <label for="name">
                        Category Name
                        <span class="required">*</span>
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Enter category name"
                        value="<%= editMode
                                ? category.getName()
                                : "" %>"
                        required
                        maxlength="100"
                    >

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Enter category description"
                        maxlength="500"
                    ><%= editMode
                            && category.getDescription() != null
                            ? category.getDescription()
                            : "" %></textarea>

                </div>


                <div class="button-row">

                    <button
                        type="submit"
                        class="button save-button"
                    >
                        <%= editMode
                                ? "Update Category"
                                : "Add Category" %>
                    </button>


                    <a
                        href="<%= request.getContextPath() %>/admin/categories"
                        class="button cancel-button"
                    >
                        Cancel
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>