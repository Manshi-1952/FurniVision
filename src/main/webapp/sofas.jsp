
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="com.furnivision.util.DatabaseConnection" %>

<%
  HttpSession sessionObj = request.getSession(false);
  Integer userId = (sessionObj != null && sessionObj.getAttribute("user_id") != null)
      ? (Integer) sessionObj.getAttribute("user_id") : null;

  String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : null;


  Connection connection = null;
  PreparedStatement preparedStatement = null;
  ResultSet resultSet = null;
%>

<html>
<head>
  <title>Furniture Store - Sofas</title>
  <link rel="stylesheet" href="./CSS/sofas.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

<header>
  <nav>
    <div id="menu">
      <button id="hamburger">&#9776;</button>
      <ul id="category-list" style="display: none;">
        <li><a href="sofas.jsp">Sofas</a></li>
        <li><a href="beds.jsp">Beds</a></li>
        <li><a href="chairs.jsp">Chairs</a></li>
        <li><a href="tables.jsp">Tables</a></li>
        <li><a href="cabinets.jsp">Cabinets</a></li>
        <li><a href="outdoor.jsp">Outdoor Furniture</a></li>
      </ul>
    </div>

    <div id="logo">
      <h1><a href="index.jsp" style="text-decoration: none;color: black">FurniVision</a></h1>
    </div>

    <div id="search-bar">
      <form action="search" method="GET">
        <input type="text" name="query" placeholder="Search furniture...">
        <button type="submit">Search</button>
      </form>
    </div>

    <div id="user-options">
      <div id="profile-dropdown" class="dropdown">
        <button class="dropbtn">Profile</button>
        <div class="dropdown-content">
          <%
            if (username != null) {
          %>
          <p style="padding: 10px;font-weight: bold">Welcome, <%= username %>!</p>
          <a href="logout.jsp">Logout</a>
          <%
          } else {
          %>
          <a href="login.jsp"><button class="signin-btn">Sign In</button></a>
          <% } %>
        </div>
      </div>
      <%
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin != null && isAdmin) {
      %>
      <!-- Show Admin Options -->
      <a href="admin.jsp">Admin</a>
      <a href="manageUsers.jsp">Manage Users</a>
      <% } else { %>
      <!-- Show Customer Options -->
      <a href="wishlist.jsp">Wishlist</a>
      <a href="cart.jsp">Cart</a>
      <% } %>
    </div>
  </nav>
</header>

<main>
  <section class="sofa-section" style="background-color: #d1abaa">
    <img src="./Assets/Furniture.png" style="width: 60%;height: 140%; position:relative;left: -30px">
    <div class="sofa-info">
      <h2>YOUR</h2>
      <h2>DREAM</h2>
      <h1>OUR</h1>
      <h1>CREATION</h1>
      <button class="check-now">Check Now.</button>
    </div>
  </section>

  <div class="product-container">
    <%
      try {
        connection = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM products WHERE category = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, "Sofas");
        resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
    %>
    <div class="product-card">
      <!-- First Section: Image -->
      <div class="product-image">
        <% if (resultSet.getString("image_url") != null && !resultSet.getString("image_url").isEmpty()) { %>
        <img src="<%= resultSet.getString("image_url") %>" alt="Product Image">
        <% } else { %>
        <p>No Image Available</p>
        <% } %>
      </div>

      <!-- Second Section: Product Details -->
      <div class="product-info">
        <h3><%= resultSet.getString("name") %></h3>
        <p><%= resultSet.getString("description") %></p>

        <% if (userId != null && !"admin".equals(username)) { %>
        <form class="add-to-cart-form" data-product-id="<%= resultSet.getInt("id") %>">
          <input type="hidden" name="product_id" value="<%= resultSet.getInt("id") %>">
          <input type="hidden" name="user_id" value="<%= userId %>">
          <input type="hidden" name="price" value="<%= resultSet.getInt("price") %>">

          <div class="price-quantity">
            <p>Price: $<%= resultSet.getDouble("price") %></p>
          </div>

          <button type="button" class="add-cart-btn">Add to Cart</button>
        </form>



        <% } else if ("admin".equals(username)) { %>
        <p style="color: red; font-weight: bold;">Admin cannot add items to the cart</p>
        <% } else { %>
        <p class="auth-warning">⚠ You must <a href="login.jsp">log in</a> to add items to your cart.</p>
        <% } %>
      </div>
    </div>
    <%
        }
      } catch (Exception e) {
        out.println("<p>Error fetching products. Please try again later.</p>");
      } finally {
        try {
          if (resultSet != null) resultSet.close();
          if (preparedStatement != null) preparedStatement.close();
          if (connection != null) connection.close();
        } catch (SQLException e) {
          out.println("<p>Error closing database resources.</p>");
        }
      }
    %>
  </div>

</main>


<script src="./Javascript/app-2.js"></script>
<script src="./Javascript/app.js"></script>

</body>
</html>
