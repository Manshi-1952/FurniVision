<%--
  Created by IntelliJ IDEA.
  User: Manshi Gohil
  Date: 23-01-2025
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./CSS/style.css">
  <link rel="icon" type="image/png" href="./Assets/s1.jpg">
  <!-- AOS Library -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

  <title>FurniVision - Home</title>

</head>
<body>
<!-- Navigation Bar -->
<header>
  <nav>
    <!-- Hamburger Menu -->
    <div id="menu">
      <button id="hamburger">&#9776;</button>
      <ul id="category-list" style="display: none;">
        <li><a href="sofas.jsp" onclick="return checkLogin(this)">Sofas</a></li>
        <li><a href="beds.jsp" onclick="return checkLogin(this)">Beds</a></li>
        <li><a href="chairs.jsp">Chairs</a></li>
        <li><a href="#">Tables</a></li>
        <li><a href="#">Cabinets</a></li>
        <li><a href="#">Outdoor Furniture</a></li>
      </ul>
    </div>

    <!-- Logo -->
    <div id="logo">
      <h1>FurniVisions</h1>
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
      <a href="#">Portfolio</a>
      <a href="#">Contact page</a>
      <a href="cart.jsp">Cart</a>
      <% } %>
    </div>
  </nav>
</header>
<div class="scroll-container" style="display: flex;flex-direction: column">
  <!-- Slider -->
  <section class="main1" id="slider-main">
    <div class="slider">
      <!-- list Items -->
      <div class="list">
        <div class="item active" style="background-color: #3b2333">
          <img src="./Assets/premiumss.png" style="float: right;width: 900px">
          <div class="content">
            <h2 style="font-size: 7rem;font-weight: bolder; text-transform: uppercase;-webkit-text-stroke: 3px white;text-align: left;white-space: nowrap;text-shadow: 2px 2px 10px rgba(255, 255, 255, 0.2);">ELEGANT BEDS</h2>
            <p style="font-size: 2rem;color: #b0a6a4;font-style: italic">
              Where Comfort Meets Elegance!
              Sleep in Style, Wake Up in Comfort.
            </p>
          </div>
        </div>
        <div class="item" style="background-color: #48704c">
          <img src="./Assets/sofa1.jpeg" style="float: right;width: 900px">
          <div class="content">
            <h2 style="font-size: 8rem;font-weight:bolder ;-webkit-text-stroke: 3px #213426;text-align: left;white-space: nowrap;">COMFY SOFAS</h2>
            <p style="font-size: 2rem;color: #b0a6a4;font-style: italic">
              Sofas That Speak Style – Comfort You’ll Love, Design You’ll Adore
            </p>
          </div>
        </div>
        <div class="item" style="background-color: #26150b">
          <img src="./Assets/chair11.png"  style="float: right;width: 800px">
          <div class="content">
            <h2 style="font-size: 8rem;font-weight:bolder ;-webkit-text-stroke: 3px white;text-align: left;white-space: nowrap;">TIMELESS CHAIRS</h2>
            <p style="font-size: 2rem;color: #b0a6a4;font-style: italic">
              Experience the perfect blend of style and support.
            </p>
          </div>
        </div>
        <div class="item" style="background-color: #292b20">
          <img src="./Assets/dinning.png" style="float: right;width: 800px">
          <div class="content">
            <h2 style="font-size: 8rem;font-weight:bolder ;-webkit-text-stroke: 3px white;text-align: left;white-space: nowrap;">DINE IN STYLE</h2>
            <p style="font-size: 2rem;color: #b0a6a4;font-style: italic">
              Where Every Meal Becomes a Special Occasion.
            </p>
          </div>
        </div>
        <div class="item" style="background-color: #826c56">
          <img src="./Assets/cabinet.png" style="float: right;width: 450px;padding-right: 30px;padding-top: 30px">
          <div class="content">
            <h2 style="font-size: 8rem;font-weight:bolder ;-webkit-text-stroke: 3px white;text-align: left;white-space: nowrap;">SPACE SAVVY</h2>
            <p style="font-size: 2rem;color: #b0a6a4;font-style: italic">
              Smart Wardrobes & Storage for Every Home.
            </p>
          </div>
        </div>
      </div>
      <!-- button arrows -->
      <div class="arrows" style="display: none;">
        <button id="prev" aria-label="Previous Slide">&lt;</button>
        <button id="next" aria-label="Next Slide">&gt;</button>
      </div>
    </div>
<%--      <!-- thumbnail -->--%>
<%--      <div class="thumbnail">--%>
<%--        <div class="item active">--%>
<%--          <img src="./Assets/s1.jpg">--%>
<%--          <div class="content">--%>
<%--            Name Slider--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--          <img src="./Assets/s2.jpg" alt="img 1">--%>
<%--          <div class="content">--%>
<%--            Name Slider--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--          <img src="./Assets/s3.jpg">--%>
<%--          <div class="content">--%>
<%--            Name Slider--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--          <img src="./Assets/s4.jpg">--%>
<%--          <div class="content">--%>
<%--            Name Slider--%>
<%--          </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--          <img src="./Assets/s5.jpg">--%>
<%--          <div class="content">--%>
<%--            Name Slider--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </div>--%>

  </section>

  <!-- Why Choose Us? -->
  <section class="main1" id="why-choose-us-main">
    <section id="why-choose-us" style="width: 100%; height:100%;">
      <h2 class="why-choose-us" data-aos="fade-up" data-aos-duration="1500"><span class="text">Why Choose Us</span> <span class="question-mark">?</span></h2>
      <div class="why-choose-container">
        <div class="why-card" style="background: #cdcdcd;" data-aos="flip-left" data-aos-duration="1200">
          <img src="./Assets/chair1.png" alt="High-Quality Materials">
          <h3>High-Quality Materials</h3>
          <p>We use the best materials to ensure durability and elegance.</p>
        </div>
        <div class="why-card" style="background-color: #fdfaf6" data-aos="flip-right" data-aos-duration="1200">
          <img src="./Assets/Eddie_Boucle_Sofa_-_Green___Chair-removebg-preview.png" alt="Modern Designs" style="width: 250px;height: 300px">
          <h3>Modern Designs</h3>
          <p>Our designs blend style with comfort, fitting any home perfectly.</p>
        </div>
        <div class="why-card" data-aos="zoom-in" data-aos-duration="1300">
          <img src="./Assets/customization.jpeg" alt="Customizable Options">
          <h3>Customizable Options</h3>
          <p>Personalize your furniture to match your unique taste.</p>
        </div>
        <div class="why-card" style="background-color: #e9d0e5" data-aos="fade-up" data-aos-duration="1400">
          <img src="./Assets/fast.jpeg" alt="Fast & Reliable Delivery">
          <h3>Fast & Reliable Delivery</h3>
          <p>We ensure timely delivery with top-notch customer service.</p>
        </div>
      </div>
    </section>
  </section>

  <!-- Top category -->
  <section class="main1" id="top-categories-main">
    <h2 class="top-categories-title" data-aos="fade-up">Top Categories</h2>
    <div class="categories-container">
      <a href="sofas.jsp" onclick="return checkLogin(this)">
        <div class="category-card" data-aos="flip-left">
          <img src="./Assets/sofa.jpeg" alt="Sofas">
          <h1>Sofa</h1>
        </div>
      </a>

      <div class="category-card" data-aos="zoom-in">
        <img src="./Assets/bed.jpeg" alt="Beds">
        <h1>
          Bed
        </h1>
      </div>
      <div class="category-card" data-aos="fade-up">
        <img src="./Assets/dinning.jpeg" alt="Chairs">
        <h1>
          Dining
        </h1>
      </div>
      <div class="category-card">
        <img src="./Assets/living-removebg-preview.png" alt="Tables">
        <h1>
          Living
        </h1>
      </div>
    </div>
  </section>

  <section class=" portfolio-container main1" id="portfolio-main">
    <h1 style="background-color: #212121;font-size: 5rem;font-weight: bolder;letter-spacing: 3px;color: #eeeeee;padding: 30px">OUR WORK</h1>
    <div class="grid-container">
      <!-- Left Image Grid -->
      <div class="grid-item nested-grid">
        <div class="nested-item"><img src="./Assets/exp1.jpeg" alt="Work 1"></div>
        <div class="nested-item"><img src="./Assets/exp2.jpeg" alt="Work 2"></div>
        <div class="nested-item"><img src="./Assets/exp3.jpeg" alt="Work 3"></div>
        <div class="nested-item"><img src="./Assets/exp4.jpeg" alt="Work 3"></div>
        <div class="nested-item"><img src="./Assets/exp6.jpeg" alt="Work 3"></div>
        <div class="nested-item"><img src="./Assets/exp7.jpeg" alt="Work 3"></div>

      </div>

      <!-- Middle Content Grid (Wider) -->
      <div class="grid-item middle-grid">
        <h2>Our Past Projects</h2>
        <p>We have successfully designed and built custom furniture for modern homes, apartments, and offices. Our team ensures top-notch quality with exquisite craftsmanship.</p>
        <a href="portfolio.html" class="btn-explore">Explore Our Work</a>
      </div>

    </div>
  </section>

  <hr style="background-color: #212121;padding: 3px;margin-bottom: 30px">

  <section class="contact-section" style="background-color: #212121;color: #eeeeee">

    <div class="contact-container">

      <!-- Left Side: Contact Details -->
      <div class="contact-info">
        <h2>Contact Us</h2>
        <p>We’d love to hear from you! Reach out with any questions or inquiries.</p>

        <div class="info-item">
          <i class="fas fa-map-marker-alt"></i>
          <p>123 Street, City, Country</p>
        </div>

        <div class="info-item">
          <i class="fas fa-phone"></i>
          <p>+1 234 567 890</p>
        </div>

        <div class="info-item">
          <i class="fas fa-envelope"></i>
          <p>info@yourwebsite.com</p>
        </div>

        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
      </div>

      <!-- Right Side: Contact Form -->
      <div class="contact-form">
        <h2>Send Us a Message</h2>
        <form>
          <div class="input-group">
            <input type="text" placeholder="Your Name" required>
          </div>
          <div class="input-group">
            <input type="email" placeholder="Your Email" required>
          </div>
          <div class="input-group">
            <textarea placeholder="Your Message" rows="5" required></textarea>
          </div>
          <button type="submit" class="btn-submit">Send Message</button>
        </form>
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
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About Us</a></li>
          <li><a href="portfolio.html">Portfolio</a></li>
          <li><a href="contact.html">Contact</a></li>
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

</div>
<script src="./Javascript/app.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script>
    // Initialize AOS
    AOS.init({
        easing: 'ease-in-out', // Optional: Smooth easing
    })
</script>

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

</script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

</body>

</html>
