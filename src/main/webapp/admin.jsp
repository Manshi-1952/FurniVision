<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 07-02-2025
  Time: 12:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Add Product</title>
    <link rel="stylesheet" href="./CSS/admin.css">
    <link rel="stylesheet" href="./CSS/sofas.css">
</head>
<body>
<header>
    <nav>
        <!-- Hamburger Menu -->
        <div id="menu">
            <button id="hamburger">&#9776;</button>
            <ul id="category-list" style="display: none;">
                <li><a href="sofas.jsp">Sofas</a></li>
                <li><a href="#">Beds</a></li>
                <li><a href="#">Chairs</a></li>
                <li><a href="#">Tables</a></li>
                <li><a href="#">Cabinets</a></li>
                <li><a href="#">Outdoor Furniture</a></li>
            </ul>
        </div>

        <!-- Logo -->
        <div id="logo">
            <h1>FurniVision</h1>
        </div>

        <!-- Search Bar -->
        <div id="search-bar">
            <form action="search" method="GET">
                <input type="text" name="query" placeholder="Search furniture...">
                <button type="submit">Search</button>
            </form>
        </div>

        <!-- User Icons -->
        <div id="user-options">
            <!-- User Profile Dropdown -->
            <div id="profile-dropdown" class="dropdown">
                <button class="dropbtn">Profile</button>
                <div class="dropdown-content">
                    <%
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                    %>
                    <p style="padding: 10px;font-weight: bold">Welcome, <%= username %>!</p>
                    <!-- Optionally add a logout link here -->
                    <a href="logout.jsp">Logout</a>
                    <%
                    } else {
                    %>
                    <a href="login.jsp">
                        <button class="signin-btn">Sign In</button>
                    </a>
                    <%
                        }
                    %>
                    <a href="profile.jsp">My Profile</a>
                    <a href="edit.jsp">Edit Profile</a>
                </div>
            </div>
            <a href="wishlist.jsp">Wishlist</a>
            <a href="cart.jsp">Cart</a>
        </div>
    </nav>
</header>


<div class="admin-container">
    <h2>Add New Product</h2>

    <!-- Display error messages -->
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <p style="color: red;"><%= errorMessage %></p>
    <% } %>

    <!-- Display success message -->
    <% String successMessage = request.getParameter("message"); %>
    <% if (successMessage != null) { %>
    <p style="color: green;"><%= successMessage %></p>
    <% } %>

    <form action="addProduct" method="post" enctype="multipart/form-data">
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required style="width:100%">

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="Sofas">Sofas</option>
            <option value="Beds">Beds</option>
            <option value="Chairs">Chairs</option>
            <option value="Tables">Tables</option>
            <option value="Cabinets">Cabinets</option>
            <option value="Outdoor Furniture">Outdoor Furniture</option>
        </select>

        <label for="image">Upload Image:</label>
        <input type="file" id="image" name="image" accept="image/*" required>

        <button type="submit">Add Product</button>
    </form>
</div>

<!-- Product List Section -->
<div class="product-list">
    <h2>Manage Products</h2>
    <table>
        <thead>
        <tr>
            <th>Image</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Category</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
                String sql = "SELECT * FROM products";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><img src="<%= rs.getString("image_url") %>" alt="Product Image" width="80"></td>
            <td><%= rs.getString("name") %></td>
            <td>$<%= rs.getDouble("price") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getString("category") %></td>
            <td>
                <form action="deleteProduct" method="post">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
</div>

<script src="./Javascript/app.js"></script>
</body>
</html>
