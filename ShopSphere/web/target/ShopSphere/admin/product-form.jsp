<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.shopsphere.model.Product" %>

<%
    Product product = (Product) request.getAttribute("product");

    boolean editMode = product != null;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        ShopSphere Admin -
        <%= editMode ? "Edit Product" : "Add Product" %>
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

        .navbar {
            height: 68px;
            background: #202020;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
        }

        .logo {
            color: white;
            text-decoration: none;
            font-size: 25px;
            font-weight: 800;
        }

        .logo span {
            color: #3b82f6;
        }

        .logout {
            background: #dc3545;
            color: white;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
        }

        .logout:hover {
            background: #bb2d3b;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .top-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .title {
            margin: 0;
            font-size: 30px;
            color: #111827;
        }

        .back-btn {
            text-decoration: none;
            background: #6b7280;
            color: white;
            padding: 11px 18px;
            border-radius: 7px;
            font-size: 14px;
            font-weight: 600;
        }

        .back-btn:hover {
            background: #4b5563;
        }

        .card {
            background: white;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        label {
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 700;
            color: #374151;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            background: #fff;
        }

        input:focus,
        textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .hint {
            margin-top: 6px;
            font-size: 12px;
            color: #6b7280;
        }

        .buttons {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 28px;
        }

        .btn {
            border: none;
            cursor: pointer;
            padding: 12px 22px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }

        .btn-cancel {
            background: #e5e7eb;
            color: #374151;
        }

        .btn-cancel:hover {
            background: #d1d5db;
        }

        .btn-save {
            background: #2563eb;
            color: white;
        }

        .btn-save:hover {
            background: #1d4ed8;
        }

        .section-title {
            margin: 0 0 22px;
            font-size: 18px;
            color: #111827;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 0 15px;
            }

            .container {
                margin-top: 25px;
            }

            .top-section {
                align-items: flex-start;
                gap: 15px;
                flex-direction: column;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            .card {
                padding: 20px;
            }

            .buttons {
                flex-direction: column;
            }

            .btn {
                text-align: center;
            }
        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="<%= request.getContextPath() %>/admin/dashboard.jsp"
       class="logo">
        Shop<span>Sphere</span> Admin
    </a>

    <a href="<%= request.getContextPath() %>/logout"
       class="logout">
        Logout
    </a>

</nav>


<div class="container">

    <div class="top-section">

        <h1 class="title">
            <%= editMode ? "Edit Product" : "Add Product" %>
        </h1>

        <a href="<%= request.getContextPath() %>/admin/products"
           class="back-btn">
            ← Back to Products
        </a>

    </div>


    <div class="card">

        <h2 class="section-title">
            Product Information
        </h2>


        <form method="post"
              action="<%= request.getContextPath() %>/admin/products">


            <% if (editMode) { %>

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="productId"
                       value="<%= product.getProductId() %>">

            <% } else { %>

                <input type="hidden"
                       name="action"
                       value="add">

            <% } %>


            <div class="form-grid">


                <!-- Category -->

                <div class="form-group">

                    <label for="categoryId">
                        Category ID
                    </label>

                    <input type="number"
                           id="categoryId"
                           name="categoryId"
                           min="1"
                           required
                           value="<%= editMode ? product.getCategoryId() : "" %>">

                    <span class="hint">
                        Enter the existing category ID.
                    </span>

                </div>


                <!-- Product Name -->

                <div class="form-group">

                    <label for="name">
                        Product Name
                    </label>

                    <input type="text"
                           id="name"
                           name="name"
                           maxlength="150"
                           required
                           value="<%= editMode ? product.getName() : "" %>">

                </div>


                <!-- Brand -->

                <div class="form-group">

                    <label for="brand">
                        Brand
                    </label>

                    <input type="text"
                           id="brand"
                           name="brand"
                           maxlength="100"
                           value="<%= editMode ? product.getBrand() : "" %>">

                </div>


                <!-- Price -->

                <div class="form-group">

                    <label for="price">
                        Price (₹)
                    </label>

                    <input type="number"
                           id="price"
                           name="price"
                           min="0"
                           step="0.01"
                           required
                           value="<%= editMode ? product.getPrice() : "" %>">

                </div>


                <!-- Discount -->

                <div class="form-group">

                    <label for="discount">
                        Discount (%)
                    </label>

                    <input type="number"
                           id="discount"
                           name="discount"
                           min="0"
                           max="100"
                           step="0.01"
                           value="<%= editMode ? product.getDiscount() : "0" %>">

                </div>


                <!-- Stock -->

                <div class="form-group">

                    <label for="stock">
                        Stock
                    </label>

                    <input type="number"
                           id="stock"
                           name="stock"
                           min="0"
                           required
                           value="<%= editMode ? product.getStock() : "0" %>">

                </div>


                <!-- Image -->

                <div class="form-group full-width">

                    <label for="image">
                        Image URL / Path
                    </label>

                    <input type="text"
                           id="image"
                           name="image"
                           maxlength="500"
                           placeholder="images/product.jpg"
                           value="<%= editMode && product.getImage() != null
                                   ? product.getImage()
                                   : "" %>">

                    <span class="hint">
                        Example: images/galaxy-s25.jpg
                    </span>

                </div>


                <!-- Description -->

                <div class="form-group full-width">

                    <label for="description">
                        Description
                    </label>

                    <textarea id="description"
                              name="description"
                              maxlength="1000"
                              placeholder="Enter product description..."><%= editMode && product.getDescription() != null
                                    ? product.getDescription()
                                    : "" %></textarea>

                </div>


            </div>


            <div class="buttons">

                <a href="<%= request.getContextPath() %>/admin/products"
                   class="btn btn-cancel">
                    Cancel
                </a>

                <button type="submit"
                        class="btn btn-save">
                    <%= editMode ? "Update Product" : "Add Product" %>
                </button>

            </div>


        </form>

    </div>

</div>

</body>

</html>