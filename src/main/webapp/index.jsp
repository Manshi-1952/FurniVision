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
                <li><a href="#">Beds</a></li>
                <li><a href="#">Chairs</a></li>
                <li><a href="#">Tables</a></li>
                <li><a href="#">Cabinets</a></li>
                <li><a href="#">Outdoor Furniture</a></li>
            </ul>
        </div>

        <!-- Logo -->
        <div id="logo">
            <h1>FurniVision</h1>
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
                        <a href="login.jsp">
                            <button class="signin-btn">Sign In</button>
                        </a>
                    <%
                        }
                    %>
                    <a href="profile.jsp">My Profile</a>
                    <a href="edit.jsp">Edit Profile</a>
                </div>
            </div>
            <a href="wishlist.jsp">Wishlist</a>
            <a href="cart.jsp">Cart</a>
        </div>
    </nav>
</header>
<main style="display: flex;flex-direction: column">
    <!-- Slider -->
    <section class="main" id="slider-main">
    <div class="slider">
        <!-- list Items -->
        <div class="list">
            <div class="item active">
                <img src="./Assets/img1.jpeg">
                <div class="content">
                    <p>design</p>
                    <h2>Slider 01</h2>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, neque?
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsum, ex.
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img2.jpeg">
                <div class="content">
                    <p>design</p>
                    <h2>Slider 02</h2>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, neque?
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsum, ex.
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img3.jpeg">
                <div class="content">
                    <p>design</p>
                    <h2>Slider 03</h2>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, neque?
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsum, ex.
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img4.jpeg">
                <div class="content">
                    <p>design</p>
                    <h2>Slider 04</h2>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, neque?
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsum, ex.
                    </p>
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img5.jpeg">
                <div class="content">
                    <p>design</p>
                    <h2>Slider 05</h2>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Labore, neque?
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsum, ex.
                    </p>
                </div>
            </div>
        </div>
        <!-- button arrows -->
        <div class="arrows">
            <button id="prev"><</button>
            <button id="next">></button>
        </div>
        <!-- thumbnail -->
        <div class="thumbnail">
            <div class="item active">
                <img src="./Assets/img1.jpeg">
                <div class="content">
                    Name Slider
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img2.jpeg" alt="img 1">
                <div class="content">
                    Name Slider
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img3.jpeg">
                <div class="content">
                    Name Slider
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img4.jpeg">
                <div class="content">
                    Name Slider
                </div>
            </div>
            <div class="item">
                <img src="./Assets/img5.jpeg">
                <div class="content">
                    Name Slider
                </div>
            </div>
        </div>
    </div>
    </section>

    <!-- Why Choose Us? -->
    <section class="main" id="why-choose-us-main">
    <section id="why-choose-us" style="width: 100%; height:100%;">
        <h2 class="why-choose-us">Why Choose Us ?</h2>
        <div class="why-choose-container">
            <div class="why-card" style="background: #cdcdcd;">
                <img src="./Assets/pre.png" alt="High-Quality Materials">
                <h3>High-Quality Materials</h3>
                <p>We use the best materials to ensure durability and elegance.</p>
            </div>
            <div class="why-card" style="background-color: #fdfaf6">
                <img src="./Assets/Eddie_Boucle_Sofa_-_Green___Chair-removebg-preview.png" alt="Modern Designs" style="width: 250px;height: 300px">
                <h3>Modern Designs</h3>
                <p>Our designs blend style with comfort, fitting any home perfectly.</p>
            </div>
            <div class="why-card">
                <img src="./Assets/customization.jpeg" alt="Customizable Options">
                <h3>Customizable Options</h3>
                <p>Personalize your furniture to match your unique taste.</p>
            </div>
            <div class="why-card" style="background-color: #e9d0e5">
                <img src="./Assets/fast.jpeg" alt="Fast & Reliable Delivery">
                <h3>Fast & Reliable Delivery</h3>
                <p>We ensure timely delivery with top-notch customer service.</p>
            </div>
        </div>
    </section>
    </section>

    <!-- Top category -->
    <section class="main" id="top-categories-main">
        <h2 class="top-categories-title">Top Categories</h2>
        <div class="categories-container">
            <a href="sofas.jsp" onclick="return checkLogin(this)">
                <div class="category-card">
                    <img src="./Assets/sofa.jpeg" alt="Sofas">
                    <h1>Sofa</h1>
                </div>
            </a>

            <div class="category-card">
                <img src="./Assets/bed.jpeg" alt="Beds">
                <h1>
                    Bed
                </h1>
            </div>
            <div class="category-card">
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

</main>
<script src="./Javascript/app.js"></script>
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
</body>

</html>
