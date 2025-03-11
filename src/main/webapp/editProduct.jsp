<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 11-02-2025
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="jakarta.servlet.*" %>
<%
    // Get the product ID from the request
    String productId = request.getParameter("id");

    // Database connection setup
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
    Connection conn = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

    // Fetch product details based on ID
    PreparedStatement ps = null;
    try {
        ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    try {
        ps.setInt(1, Integer.parseInt(productId));
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    ResultSet rs = null;
    try {
        rs = ps.executeQuery();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

    if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="stylesheet" href="./CSS/editProduct.css">
</head>
<body>
<h2>Edit Product</h2>
<form action="editProduct" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

    <div>
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required>
    </div>

    <div>
        <label for="price">Price:</label>
        <input type="number" step="0.01" id="price" name="price" value="<%= rs.getDouble("price") %>" required>
    </div>

    <div>
        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= rs.getString("description") %></textarea>
    </div>

    <div>
        <label for="category">Category:</label>
        <select id="category" name="category" value="<%= rs.getString("category") %>" required>
            <option value="Sofas">Sofas</option>
            <option value="Beds">Beds</option>
            <option value="Chairs">Chairs</option>
            <option value="Tables">Tables</option>
            <option value="Cabinets">Cabinets</option>
            <option value="Outdoor Furniture">Outdoor Furniture</option>
        </select>
    </div>

    <div>
        <label for="image">Upload Image:</label>
        <input type="file" id="image" name="image" accept="image/*">
        <input type="hidden" name="existingImage" value="<%= rs.getString("image_url") %>">
        <p>Leave this field empty to keep the existing image.</p>

    </div>

    <button type="submit">Update Product</button>
</form>

<a href="admin.jsp">Back to Admin Panel</a>
</body>
</html>
<%
    } else {
        out.println("<p>Product not found!</p>");
    }

    // Close resources
    rs.close();
    ps.close();
    conn.close();
%>