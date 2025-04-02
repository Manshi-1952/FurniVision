

<%--<%@ page import="java.sql.Connection" %>--%>
<%--<%@ page import="java.sql.PreparedStatement" %>--%>
<%--<%@ page import="java.sql.ResultSet" %>--%>
<%--<%@ page import="java.sql.DriverManager" %>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Admin Panel - Manage Products</title>--%>
<%--    <link rel="stylesheet" href="./CSS/admin.css">--%>
<%--    <link rel="stylesheet" href="./CSS/sofas.css">--%>
<%--</head>--%>
<%--<body>--%>
<%--<header>--%>
<%--    <nav>--%>
<%--        <div id="menu">--%>
<%--            <button id="hamburger">&#9776;</button>--%>
<%--            <ul id="category-list" style="display: none;">--%>
<%--                <li><a href="sofas.jsp">Sofas</a></li>--%>
<%--                <li><a href="#">Beds</a></li>--%>
<%--                <li><a href="#">Chairs</a></li>--%>
<%--                <li><a href="#">Tables</a></li>--%>
<%--                <li><a href="#">Cabinets</a></li>--%>
<%--                <li><a href="#">Outdoor Furniture</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>
<%--        <div id="logo"><h1>FurniVision</h1></div>--%>
<%--        <div id="search-bar">--%>
<%--            <form action="search" method="GET">--%>
<%--                <input type="text" name="query" placeholder="Search furniture...">--%>
<%--                <button type="submit">Search</button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--        <div id="user-options">--%>
<%--            <a href="wishlist.jsp">Wishlist</a>--%>
<%--            <a href="cart.jsp">Cart</a>--%>
<%--        </div>--%>
<%--    </nav>--%>
<%--</header>--%>

<%--<div class="admin-container">--%>
<%--    <h2>Add New Product</h2>--%>
<%--    <form action="addProduct" method="post" enctype="multipart/form-data">--%>
<%--        <label for="name">Product Name:</label>--%>
<%--        <input type="text" id="name" name="name" required>--%>

<%--        <label for="price">Price:</label>--%>
<%--        <input type="number" id="price" name="price" step="0.01" required>--%>

<%--        <label for="description">Description:</label>--%>
<%--        <textarea id="description" name="description" required></textarea>--%>

<%--        <label for="category">Category:</label>--%>
<%--        <select id="category" name="category" required>--%>
<%--            <option value="Sofas">Sofas</option>--%>
<%--            <option value="Beds">Beds</option>--%>
<%--            <option value="Chairs">Chairs</option>--%>
<%--            <option value="Tables">Tables</option>--%>
<%--            <option value="Cabinets">Cabinets</option>--%>
<%--            <option value="Outdoor Furniture">Outdoor Furniture</option>--%>
<%--        </select>--%>

<%--        <label for="image">Upload Image:</label>--%>
<%--        <input type="file" id="image" name="image" accept="image/*" required>--%>

<%--        <button type="submit">Add Product</button>--%>
<%--    </form>--%>
<%--</div>--%>

<%--<div class="product-list">--%>
<%--    <h2>Manage Products</h2>--%>
<%--    <table>--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--            <th>Image</th>--%>
<%--            <th>Product Name</th>--%>
<%--            <th>Price</th>--%>
<%--            <th>Description</th>--%>
<%--            <th>Category</th>--%>
<%--            <th>Actions</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <%--%>
<%--            Connection conn = null;--%>
<%--            PreparedStatement stmt = null;--%>
<%--            ResultSet rs = null;--%>
<%--            try {--%>
<%--                Class.forName("com.mysql.cj.jdbc.Driver");--%>
<%--                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");--%>
<%--                stmt = conn.prepareStatement("SELECT * FROM products");--%>
<%--                rs = stmt.executeQuery();--%>
<%--                while (rs.next()) {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <td><img src="<%= rs.getString("image_url") %>" alt="Product Image" width="80"></td>--%>
<%--            <td><%= rs.getString("name") %></td>--%>
<%--            <td>$<%= rs.getDouble("price") %></td>--%>
<%--            <td><%= rs.getString("description") %></td>--%>
<%--            <td><%= rs.getString("category") %></td>--%>
<%--            <td>--%>
<%--                <form action="deleteProduct" method="post" style="display:inline;">--%>
<%--                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">--%>
<%--                    <button type="submit" class="delete-btn">Delete</button>--%>
<%--                </form>--%>
<%--                <form action="editProduct.jsp" method="get" style="display:inline;">--%>
<%--                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">--%>
<%--                    <button type="submit" class="delete-btn">Edit</button>--%>
<%--                </form>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--                }--%>
<%--            } catch (Exception e) {--%>
<%--                e.printStackTrace();--%>
<%--            } finally {--%>
<%--                if (rs != null) rs.close();--%>
<%--                if (stmt != null) stmt.close();--%>
<%--                if (conn != null) conn.close();--%>
<%--            }--%>
<%--        %>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>

<%--<script src="./Javascript/app.js"></script>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Manage Products</title>
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
            <a href="admin.jsp">Admin</a>
            <a href="manageUsers.jsp">admin-user</a>
            <a href="Contracts-todo.jsp">Contracts</a>
        </div>
    </nav>
</header>
<div class="admin-container">
    <h2>Add New Product</h2>
    <form action="addProduct" method="post" enctype="multipart/form-data">
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required>

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


<div class="product-list">
    <h2>Manage Products</h2>
    <table>
        <thead>
        <tr>
            <th>Image</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Category</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int currentPage = 1;
            int recordsPerPage = 5;
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }
            int start = (currentPage - 1) * recordsPerPage;
            String query = request.getParameter("query");
            String category = request.getParameter("category");

            String sql = "SELECT * FROM products WHERE 1=1";
            if (query != null && !query.isEmpty()) {
                sql += " AND name LIKE ?";
            }
            if (category != null && !category.isEmpty()) {
                sql += " AND category = ?";
            }
            sql += " LIMIT ?, ?";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
                stmt = conn.prepareStatement(sql);
                int paramIndex = 1;
                if (query != null && !query.isEmpty()) {
                    stmt.setString(paramIndex++, "%" + query + "%");
                }
                if (category != null && !category.isEmpty()) {
                    stmt.setString(paramIndex++, category);
                }
                stmt.setInt(paramIndex++, start);
                stmt.setInt(paramIndex, recordsPerPage);

                rs = stmt.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><img src="<%= rs.getString("image_url") %>" width="80"></td>
            <td><%= rs.getString("name") %></td>
            <td>$<%= rs.getDouble("price") %></td>
            <td><%= rs.getString("category") %></td>
            <td>
                <form action="deleteProduct" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
                <form action="editProduct.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-btn">Edit</button>
                </form>
            </td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

    <div class="pagination">
<%--        <a href="manageProducts.jsp?page=<%= currentPage - 1 %>">Previous</a>--%>
        <a href="manageProducts.jsp?page=<%= currentPage + 1 %>" class="prevNext">Next</a>
    </div>
</div>
<script src="./Javascript/app.js"></script>
</body>
</html>