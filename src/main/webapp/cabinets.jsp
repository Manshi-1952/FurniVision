<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 02-04-2025
  Time: 19:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="com.furnivision.util.DatabaseConnection" %>

<%
  HttpSession sessionObj = request.getSession(false);
  Integer userId = (sessionObj != null && sessionObj.getAttribute("user_id") != null)
      ? (Integer) sessionObj.getAttribute("user_id") : null;


  Connection connection = null;
  PreparedStatement preparedStatement = null;
  ResultSet resultSet = null;
%>
<html>
<head>
  <title>Furniture Store - Cabinets</title>
  <link rel="stylesheet" href="./CSS/tables.css">
</head>
<body>

<header>
  <nav>
    <!-- Hamburger Menu -->
    <div id="menu">
      <button id="hamburger">&#9776;</button>
      <ul id="category-list" style="display: none;">
        <li><a href="sofas.jsp" onclick="return checkLogin(this)">Sofas</a></li>
        <li><a href="beds.jsp" onclick="return checkLogin(this)">Beds</a></li>
        <li><a href="chairs.jsp">Chairs</a></li>
        <li><a href="tables.jsp">Tables</a></li>
        <li><a href="cabinets.jsp">Cabinets</a></li>
      </ul>
    </div>

    <!-- Logo -->

    <div id="logo">
      <h1><a href="index.jsp" style="text-decoration: none;color: black">FurniVision</a></h1>
    </div>

    <!-- Search Bar -->
    <div id="search-bar">
      <form id="searchForm">
        <input type="text" id="searchInput" name="query" placeholder="Search furniture...">
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
          <a href="login.jsp" class="signin-btn">Sign In</a>
          <%
            }
          %>
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
      <a href="portfolio.jsp">Portfolio</a>
      <a href="contract.jsp">Custom Furniture</a>
      <a href="cart.jsp">Cart</a>
      <% } %>
    </div>
  </nav>
</header>

<main>
  <section class="cabinet-section" >
    <div class="container">
      <!-- Left: Image -->
      <div class="image-container">
        <img src="./Assets/cabine.jpeg" alt="Dining Table">
      </div>

      <!-- Right: Text -->
      <div class="text-container">
        <h2>Elegant & Functional Cabinets for Every Space</h2>
        <p>Maximize your storage with stylish, durable cabinets designed for modern living. Whether for your kitchen, bedroom, or office, find the perfect fit for your space.</p>
      </div>
    </div>
  </section>
  <hr style="border: 2px solid black; width: 95%; margin: auto">
  <h1 style="font-size: 2rem;font-weight: bolder;text-align: center;margin: 20px">PRODUCTS</h1>
  <hr style="border: 2px solid black; width: 95%; margin: auto">
  <div class="product-container">
    <%
      try {
        connection = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM products WHERE category = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, "Cabinets");
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
        <p style="font-style: italic"><%= resultSet.getString("description") %></p>

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

<footer class="footer">
  <div class="footer-container">
    <!-- Column 1: Company Info -->
    <div class="footer-column">
      <h2>FurniVision</h2>
      <p>Crafting modern & elegant furniture tailored to your needs. Quality, design, and durability in every piece.</p>
      <div class="social-icons">
        <a href="https://www.facebook.com/"><i class="fab fa-facebook"></i></a>
        <a href="https://twitter.com/"><i class="fab fa-twitter"></i></a>
        <a href="https://www.instagram.com/"><i class="fab fa-instagram"></i></a>
        <a href="https://www.linkedin.com/"><i class="fab fa-linkedin"></i></a>
      </div>
    </div>

    <!-- Column 2: Quick Links -->
    <div class="footer-column">
      <h2>Quick Links</h2>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="portfolio.jsp">Portfolio</a></li>
        <li><a href="contract.jsp">Custom Furniture</a></li>
        <li><a href="cart.jsp">Cart</a></li>
      </ul>
    </div>

    <!-- Column 3: Contact & Map -->
    <div class="footer-column">
      <h2>Contact Us</h2>
      <p><i class="fas fa-map-marker-alt"></i> Sevasi, Vadodara</p>
      <p><i class="fas fa-phone"></i> +91 98765 43210</p>
      <p><i class="fas fa-envelope"></i> support@furnivision.com</p>

      <!-- Embedded Google Map -->
      <div class="map-container">
        <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3672.5175440187026!2d73.12073641500397!3d22.30866498531654!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395fc90205f1486b%3A0x29c3651db110c9c!2sSevasi%2C%20Vadodara%2C%20Gujarat!5e0!3m2!1sen!2sin!4v1698947617732"
            width="100%" height="150" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
      </div>
    </div>
  </div>

  <div class="footer-bottom">
    <p>&copy; 2025 FurniVision. All Rights Reserved.</p>
  </div>
</footer>

<script>
  document.getElementById("searchForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Stop default form submission

    let query = document.getElementById("searchInput").value.toLowerCase(); // Convert input to lowercase

    // Mapping search terms to pages
    let pages = {
      "bed": "beds.jsp",
      "beds": "beds.jsp",
      "chair": "chairs.jsp",
      "chairs": "chairs.jsp",
      "table": "tables.jsp",
      "tables": "tables.jsp",
      "cabinet": "cabinets.jsp",
      "cabinets": "cabinets.jsp",
      "sofa": "sofa.jsp",
      "sofas": "sofa.jsp"
    };

    // Redirect if search term matches
    for (let key in pages) {
      if (query.includes(key)) {
        window.location.href = pages[key];
        return;
      }
    }

    // If no match, show alert or redirect to a "Not Found" page
    alert("No matching furniture found.");
  });

  //deopdown
  document.addEventListener("DOMContentLoaded", function () {
    let dropdownBtn = document.querySelector(".dropbtn");
    let dropdownContent = document.querySelector(".dropdown-content");

    dropdownBtn.addEventListener("click", function (event) {
      event.stopPropagation();
      dropdownContent.style.display = dropdownContent.style.display === "block" ? "none" : "block";
    });

    document.addEventListener("click", function () {
      dropdownContent.style.display = "none";
    });
  });

  //hamburger
  document.getElementById("hamburger").addEventListener("click", function() {
    let menu = document.getElementById("category-list");
    if (menu.style.display === "none" || menu.style.display === "") {
      menu.style.display = "block";
    } else {
      menu.style.display = "none";
    }
  });

</script>

</body>
</html>
