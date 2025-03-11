<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String pwd = "0409";

    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin - Manage Users</title>
    <link rel="stylesheet" href="./CSS/sofas.css">

    <style>
        body {
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        h2 {
            margin-top: 20px;
            padding-bottom: 20px;
            text-align: center;
            color: #333;
        }

        table {
            margin: 0 auto;
            width: 95%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9f5e9;
            transition: 0.3s;
        }

        .btn {
            padding: 8px 14px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            transition: background 0.3s, transform 0.2s;
        }

        .delete {
            background: #e74c3c;
            color: white;
        }

        .delete:hover {
            background: #c0392b;
            transform: scale(1.05);
        }

        .update {
            background: #3498db;
            color: white;
        }

        .update:hover {
            background: #2980b9;
            transform: scale(1.05);
        }

        select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
            background: white;
        }

        /* Responsive Table */
        @media screen and (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            th, td {
                padding: 10px;
                font-size: 14px;
            }

            .btn {
                padding: 6px 10px;
                font-size: 12px;
            }
        }

    </style>
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
            <a href="admin.jsp">Admin</a>
            <a href="manageUsers.jsp">Manage Users</a>
        </div>
    </nav>
</header>
<h2>Admin - Manage Users</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Created At</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pwd);

//            String query = "SELECT id, username, email, role, created_at, status FROM users";
            String query = "SELECT id, username, email, is_admin, role, created_at, status FROM users ORDER BY id DESC";

            stmt = connection.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("role") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
        <td><%= rs.getString("status") %></td>
        <td>
            <form action="manageUsers" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="action" value="delete">
                <button type="submit" class="btn delete">Delete</button>
            </form>
            <form action="manageUsers" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="action" value="updateRole">
                <select name="new_role">
                    <option value="Customer" <%= rs.getInt("is_admin") == 0 ? "selected" : "" %>>Customer</option>
                    <option value="Admin" <%= rs.getInt("is_admin") == 1 ? "selected" : "" %>>Admin</option>
                </select>
                <button type="submit" class="btn update">Change Role</button>
            </form>
            <form action="manageUsers" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="action" value="updateStatus">
                <select name="new_status">
                    <option value="active" <%= "active".equals(rs.getString("status")) ? "selected" : "" %>>Active</option>
                    <option value="suspended" <%= "suspended".equals(rs.getString("status")) ? "selected" : "" %>>Suspended</option>
                </select>
                <button type="submit" class="btn update">Change Status</button>
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
            if (connection != null) connection.close();
        }
    %>
</table>

<script src="./Javascript/app.js"></script>

</body>
</html>
