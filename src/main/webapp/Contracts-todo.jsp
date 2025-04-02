<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 02-04-2025
  Time: 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Admin Dashboard</title>
</head>
<body>
<h2>Pending Contracts</h2>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Property Type</th>
    <th>Rooms</th>
    <th>Furniture</th>
    <th>Budget</th>
  </tr>
  <%
    String jdbcUrl = "jdbc:mysql://localhost:3306/furnivision";
    String jdbcUser = "root"; // Change this
    String jdbcPassword = "0409"; // Change this

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM contracts ORDER BY id DESC");

      while (rs.next()) {
  %>
  <tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("phone") %></td>
    <td><%= rs.getString("property_type") %></td>
    <td><%= rs.getString("rooms") %></td>
    <td><%= rs.getString("furniture") %></td>
    <td><%= rs.getDouble("budget") %></td>
  </tr>
  <%
      }
      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  %>
</table>
</body>
</html>

