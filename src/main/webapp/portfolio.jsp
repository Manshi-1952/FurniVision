<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 02-04-2025
  Time: 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Our Portfolio | Akshay Furnitures</title>
  <link rel="stylesheet" href="./CSS/portfolio.css"> <!-- Link to CSS -->
</head>
<body>

<!-- 🔹 Header Section -->

<header>
  <nav>
    <!-- Hamburger Menu -->
    <div id="menu">
      <button id="hamburger">&#9776;</button>
      <ul id="category-list" style="display: none;">
        <li><a href="sofas.jsp" onclick="return checkLogin(this)">Sofas</a></li>
        <li><a href="beds.jsp" onclick="return checkLogin(this)">Beds</a></li>
        <li><a href="chairs.jsp" onclick="return checkLogin(this)">Chairs</a></li>
        <li><a href="tables.jsp" onclick="return checkLogin(this)">Tables</a></li>
        <li><a href="cabinets.jsp" onclick="return checkLogin(this)">Cabinets</a></li>
      </ul>
    </div>

    <!-- Logo -->
    <div id="logo">
      <h1>FurniVisions</h1>
    </div>

    <!-- Search Bar -->
    <div id="search-bar">
      <form id="searchForm">
        <input type="text" id="searchInput" name="query" placeholder="Search furniture...">
        <button type="submit" onclick="return checkLogin(this)">Search</button>
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


<section class="portfolio-header">
  <div class="left-image">
    <img src="./Assets/download.jpeg" alt="Furniture Showroom">
  </div>
  <div class="right-text">
    <h2>About Akshay Furnitures</h2>
    <p>We are a premium furniture brand specializing in high-quality wooden and modern furniture designs. With years of expertise, we bring elegance and durability to your home and office spaces.</p>
  </div>
</section>

<!-- 🔹 Portfolio Section -->
<section class="portfolio-gallery" style="margin-top: 10px">
  <hr>
  <h2 style="font-size: 5rem;text-align: center">Our Collection</h2>
  <hr>

  <div class="gallery">
    <div class="gallery-item">
      <img src="./Assets/p1.jpeg" alt="Luxury Sofa">
      <div class="overlay">Luxury Sofa</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p2.jpeg" alt="Modern Wooden Table">
      <div class="overlay">Modern Wooden Table</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p3.jpeg" alt="King Size Bed">
      <div class="overlay">King Size Bed</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p4.jpeg" alt="Elegant Chair">
      <div class="overlay">Elegant Chair</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p5.jpeg" alt="Dining Table Set">
      <div class="overlay">Dining Table Set</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p6.jpeg" alt="Wooden Wardrobe">
      <div class="overlay">Wooden Wardrobe</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p7.jpeg" alt="Bookshelf">
      <div class="overlay">Bookshelf</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p8.jpeg" alt="Recliner Sofa">
      <div class="overlay">Recliner Sofa</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p10.jpeg" alt="Luxury Sofa">
      <div class="overlay">Luxury Sofa</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p11.jpeg" alt="Modern Wooden Table">
      <div class="overlay">Modern Wooden Table</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p12.jpeg" alt="King Size Bed">
      <div class="overlay">King Size Bed</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p13.jpeg" alt="Elegant Chair">
      <div class="overlay">Elegant Chair</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p14.jpeg" alt="Dining Table Set">
      <div class="overlay">Dining Table Set</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p15.jpeg" alt="Wooden Wardrobe">
      <div class="overlay">Wooden Wardrobe</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p1.jpeg" alt="Bookshelf">
      <div class="overlay">Bookshelf</div>
    </div>
    <div class="gallery-item">
      <img src="./Assets/p2.jpeg" alt="Recliner Sofa">
      <div class="overlay">Recliner Sofa</div>
    </div>
  </div>
</section>

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
  function checkLogin(link) {
    let isLoggedIn = <%= session.getAttribute("username") != null %>; // Checks if the user is logged in

    if (!isLoggedIn) {
      alert("Please log in first!");
      window.location.href = "login.jsp"; // Redirect to login page
      return false; // Prevent navigation
    }
    return true; // Allow navigation if logged in
  }

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


</script>

<script src="./Javascript/app.js"></script>

</body>
</html>
