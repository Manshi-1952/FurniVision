<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contract Submission | FurniVision</title>
  <link rel="stylesheet" href="./CSS/contract.css">

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
        <li><a href="chairs.jsp" onclick="return checkLogin(this)">Chairs</a></li>
        <li><a href="tables.jsp" onclick="return checkLogin(this)">Tables</a></li>
        <li><a href="cabinets.jsp" onclick="return checkLogin(this)">Cabinets</a></li>
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
<div class="container">
  <div class="form-header">
    <h2>Submit Your Contract</h2>
    <p>Fill in the details to get started with your custom furniture contract.</p>
  </div>

  <section class="contract-section">
    <div class="form-container">
      <form class="form" action="submit-contract" method="POST" onsubmit="showSuccessMessage()">

        <div class="form-group">
          <label for="name">Customer Name:</label>
          <input type="text" id="name" name="name" placeholder="Enter your name" required>
        </div>

        <div class="form-group">
          <label for="email">Email Address:</label>
          <input type="email" id="email" name="email" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
          <label for="phone">Phone Number:</label>
          <input type="text" id="phone" name="phone" placeholder="Enter your phone number">
        </div>

        <div class="form-group">
          <label for="propertyType">Property Type:</label>
          <select id="propertyType" name="propertyType">
            <option value="house">House</option>
            <option value="apartment">Apartment</option>
          </select>
        </div>

        <div class="form-group">
          <label>Rooms to Furnish:</label>
          <div class="checkbox-group">
            <input type="checkbox" name="rooms" value="livingRoom"> <label>Living room</label>
            <input type="checkbox" name="rooms" value="bedroom"> <label>Bedroom</label>
            <input type="checkbox" name="rooms" value="kitchen"> <label>kitchen</label>
          </div>
        </div>

        <div class="form-group">
          <label>Furniture Type(s):</label>
          <div class="checkbox-group">
            <input type="checkbox" name="furniture" value="sofa">
            <label>Sofa</label>
            <input type="checkbox" name="furniture" value="table"><label>Table</label>
            <input type="checkbox" name="furniture" value="bed"> <label>Bed</label>
          </div>
        </div>

        <div class="form-group">
          <label for="material">Material Preference:</label>
          <input type="text" id="material" name="material" placeholder="e.g., Wood, Metal, Glass">
        </div>

        <div class="form-group">
          <label for="budget">Budget Estimate:</label>
          <input type="number" id="budget" name="budget" placeholder="Enter your budget">
        </div>

        <div class="form-group">
          <label for="timeline">Timeline for Completion:</label>
          <input type="date" id="timeline" name="timeline">
        </div>

        <div class="form-group">
          <label for="notes">Additional Notes:</label>
          <textarea id="notes" name="notes" placeholder="Enter any special requests..."></textarea>
        </div>

<%--        <div class="form-group terms">--%>
<%--          <input type="checkbox" id="terms" name="terms" required>--%>
<%--          <label for="terms">I agree to the terms and condition.</label>--%>
<%--        </div>--%>

        <button type="submit" class="submit-btn1">Submit Contract</button>
      </form>
    </div>

  </section>
  <section class="past-work">
    <h2>Past Work of Custom Furnitures</h2>
    <div class="image-container">
      <div class="work-item">
        <img src="./Assets/dinning1.jpeg" alt="Custom Contract Step 1">
        <p><strong>Client:</strong> Mr. Sharma | <strong>Furniture:</strong> Custom Wooden Dining Table</p>
      </div>
      <div class="work-item">
        <img src="./Assets/set1.jpeg" alt="Custom Contract Step 2">
        <p><strong>Client:</strong> Ms. Patel | <strong>Furniture:</strong> Handcrafted Sofa Set</p>
      </div>
      <div class="work-item">
        <img src="./Assets/desk1.jpeg" alt="Custom Contract Step 3">
        <p><strong>Client:</strong> Mr. Verma | <strong>Furniture:</strong> Custom Office Desk</p>
      </div>
      <div class="work-item">
        <img src="./Assets/dinning2.jpeg" alt="Custom Contract Step 1">
        <p><strong>Client:</strong> Mr. Sharma | <strong>Furniture:</strong> Custom Wooden Dining Table</p>
      </div>
      <div class="work-item">
        <img src="./Assets/set2.jpeg" alt="Custom Contract Step 2">
        <p><strong>Client:</strong> Ms. Patel | <strong>Furniture:</strong> Handcrafted Sofa Set</p>
      </div>
      <div class="work-item">
        <img src="./Assets/desk2.jpeg" alt="Custom Contract Step 3">
        <p><strong>Client:</strong> Mr. Verma | <strong>Furniture:</strong> Custom Office Desk</p>
      </div>
      <div class="work-item">
        <img src="./Assets/dinning3.jpeg" alt="Custom Contract Step 1">
        <p><strong>Client:</strong> Mr. Sharma | <strong>Furniture:</strong> Custom Wooden Dining Table</p>
      </div>
      <div class="work-item">
        <img src="./Assets/set3.jpeg" alt="Custom Contract Step 2">
        <p><strong>Client:</strong> Ms. Patel | <strong>Furniture:</strong> Handcrafted Sofa Set</p>
      </div>
      <div class="work-item">
        <img src="./Assets/desk3.jpeg" alt="Custom Contract Step 3">
        <p><strong>Client:</strong> Mr. Verma | <strong>Furniture:</strong> Custom Office Desk</p>
      </div>
    </div>
  </section>
  <div id="error" class="error-message" style="display: none"></div>
</div>

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
  window.onload = function () {
    const errorMessage = "<%= request.getAttribute("errorMessage") %>";

    // Check if errorMessage is valid and not "null" or empty
    if (errorMessage && errorMessage.trim() !== "null") {
      const errorDiv = document.getElementById("error");
      errorDiv.textContent = errorMessage;
      errorDiv.style.display = "block";
    }
  };

  function showSuccessMessage() {
    alert("Your contract request has been successfully submitted!");
  }


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
