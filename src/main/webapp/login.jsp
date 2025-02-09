<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Forum&family=Nunito:ital,wght@0,200..1000;1,200..1000&family=Quicksand:wght@300..700&display=swap');
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Forum", sans-serif;
      letter-spacing: 1px;
      line-height: 1.4;
    }

    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .container {
      padding: 20px;
      background-color: #ffffff; /* Darker background for container */
      border-radius: 15px;
      box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
      width: 400px;
      text-align: center;
      backdrop-filter: blur(10px); /* Blur effect */
    }

    h2{
      font-size: 2rem;
      margin-bottom: 10px;
      color: #171616;
      text-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
    }


    .login-form {
      margin-top: 20px;
    }

    label {
      display: block;
      margin-bottom: 5px;
      text-align: left;
      font-weight: bold;
      padding-bottom: 5px;
      color: #aaa;
    }

    input[type="text"], input[type="password"] {
      width: 100%;
      padding: 10px; /* Increased padding for better spacing */
      margin-bottom: 15px;
      border: 1px solid #333; /* Darker border */
      border-radius: 5px;
      font-size: 16px;
      background-color: #ffffff; /* Darker background for input fields */
      color: #171616; /* White text for input fields */
      transition: border 0.3s ease;
    }

    input[type="text"]:focus, input[type="password"]:focus {
      outline: none; /* Remove default focus outline */
      border-color: rgba(38, 173, 38, 0.92); /* Highlight border on focus */
      box-shadow: 0 0 10px #26b226;
    }

    button{
      width: 100%;
      padding: 10px;
      background-color: #26ad26;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      margin-bottom: 10px;
      margin-top: 10px;
      transition: box-shadow 0.3s ease, transform 0.3s ease;

    }

    button:hover {
      transform: translateY(-3px);
    }

    .links {
      margin-top: 10px;
    }

    .links a {
      color: #26b226;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s ease;
    }
    .links a:hover {
      color: #176917; /* White text on hover */
    }

    .error-message {
      color: red;
      margin-bottom: 15px;
      font-size: 14px;
      display: none;
      text-align: left;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="login-form">
    <h2 class="heading">Login</h2>
    <form action="login" method="post">
      <input type="hidden" name="action" value="login">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username"
             required>
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required>

      <div id="error-message" class="error-message">

        <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
      </div>

      <button type="submit">Login</button>
    </form>

    <div class="links">
      <a href="forgot-password.jsp">Forgot Password?</a><br>
      <a href="register.jsp">Don't have an account? Register here</a>
    </div>
  </div>
</div>
<script>
  function hideErrorMessage() {
    document.getElementById("error-message").style.display = "none";
  }

  document.addEventListener("DOMContentLoaded", function () {
    const inputs = document.querySelectorAll("input");
    inputs.forEach(input => {
      input.addEventListener("focus", hideErrorMessage);
    });

    // Show error message if it exists
    const errorMessage = document.getElementById("error-message");
    if (errorMessage.innerText.trim() !== "") {
      errorMessage.style.display = "block";
    }
  });
</script>
</body>
</html>
