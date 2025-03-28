<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 11-02-2025
  Time: 19:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int currentPage = 1;
  int recordsPerPage = 5;
  if (request.getParameter("page") != null) {
    currentPage  = Integer.parseInt(request.getParameter("page"));
  }
  String searchQuery = request.getParameter("query") != null ? request.getParameter("query") : "";
  String categoryFilter = request.getParameter("category") != null ? request.getParameter("category") : "";

  Connection conn = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
  int totalRecords = 0;
  int start = (currentPage  - 1) * recordsPerPage;

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");

    String sql = "SELECT * FROM products WHERE name LIKE ?";
    if (!categoryFilter.isEmpty()) {
      sql += " AND category=?";
    }
    sql += " LIMIT ?, ?";

    stmt = conn.prepareStatement(sql);
    stmt.setString(1, "%" + searchQuery + "%");
    if (!categoryFilter.isEmpty()) {
      stmt.setString(2, categoryFilter);
      stmt.setInt(3, start);
      stmt.setInt(4, recordsPerPage);
    } else {
      stmt.setInt(2, start);
      stmt.setInt(3, recordsPerPage);
    }

    rs = stmt.executeQuery();

    Statement countStmt = conn.createStatement();
    ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) FROM products");
    if (countRs.next()) {
      totalRecords = countRs.getInt(1);
    }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Manage Products</title>
  <link rel="stylesheet" href="./CSS/admin.css">
  <link rel="stylesheet" href="./CSS/sofas.css">
</head>
<body>
<header>
  <nav>
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
    <div id="logo"><a href="index.jsp" style="text-decoration: none"><h1>FurniVision</h1></a></div>
    <div id="search-bar">
      <form action="search" method="GET">

        <button type="submit">Search</button>
      </form>
    </div>
    <div id="user-options">
      <a href="wishlist.jsp">Wishlist</a>
      <a href="cart.jsp">Cart</a>
    </div>
  </nav>
</header>
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
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% while (rs.next()) { %>
    <tr>
      <td><img src="<%= rs.getString("image_url") %>" width="80"></td>
      <td><%= rs.getString("name") %></td>
      <td>$<%= rs.getDouble("price") %></td>
      <td><%= rs.getString("description") %></td>
      <td><%= rs.getString("category") %></td>
      <td>
        <div class="div-container">
          <form action="deleteProduct" method="post" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <button type="submit" class="delete-btn">Delete</button>
          </form>
          <form action="editProduct.jsp" method="get" style="display:inline;">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
            <button type="submit" class="delete-btn">Edit</button>
          </form>
        </div>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <div class="pagination">
    <%
      int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
      int prevPage = currentPage - 1;
      int nextPage = currentPage + 1;
    %>

    <!-- Previous Button -->
    <% if (currentPage == 2) { %>
    <a href="admin.jsp?page=<%= prevPage %>" class="prevNext">Previous</a>
    <% } %>
    <% if (currentPage > 2) { %>
    <a href="manageProducts.jsp?page=<%= prevPage %>" class="prevNext">Previous</a>
    <% } %>

    <!-- Next Button -->
    <% if (currentPage < totalPages) { %>
    <a href="manageProducts.jsp?page=<%= nextPage %>" class="prevNext">Next</a>
    <% } %>
  </div>
</div>


</body>
</html>
<%
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
  }
%>

