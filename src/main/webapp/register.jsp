<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="./CSS/register.css">
    <title>FurniVision - Register</title>
    <style>
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Let's create your account</h1>
    <p>Already a member? <a href="login.jsp" style="color: #893BAD">Sign in</a></p>
</div>

<div class="container">
    <h2>Register</h2>
    <form id="registrationForm" action="register" method="post" onsubmit="return validateForm()">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <div id="usernameError" class="error-message"></div>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <div id="passwordError" class="error-message"></div>

        <label for="confirm_password">Confirm Password:</label>
        <input type="password" id="confirm_password" name="confirm_password" required>

        <div class="checkbox-container">
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">Remember Me</label>
        </div>

        <div class="checkbox-container">
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">I agree to the <a href="#" style="color: #893BAD">Terms & Conditions</a> and <a href="#" style="color: #893BAD">Privacy Policy</a></label>
        </div>

        <button type="submit">Register</button>

        <div id="formError" class="error-message">
            <% if (request.getAttribute("errorMessage") != null) { %>
            <%= request.getAttribute("errorMessage") %>
            <% } %>
        </div>
    </form>
</div>

<script>
    function validateForm() {
        // Clear previous error messages
        document.getElementById('usernameError').innerText = '';
        document.getElementById('passwordError').innerText = '';
        document.getElementById('formError').innerText = '';

        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;
        const terms = document.getElementById('terms').checked;

        let isValid = true;

        // Validate fields
        const usernamePattern = /^[a-zA-Z0-9]+$/;
        if (!usernamePattern.test(username)) {
            document.getElementById('usernameError').innerText = 'Username must only contain alphanumeric characters.';
            isValid = false;
        }

        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{6,}$/;
        if (!passwordPattern.test(password)) {
            document.getElementById('passwordError').innerText = 'Password must be at least 6 characters long, contain one uppercase letter, one lowercase letter, and one special character.';
            isValid = false;
        }


        if (!terms) {
            document.getElementById('formError').innerText = 'You must agree to the Terms & Conditions and Privacy Policy.';
            isValid = false;
        }

        // If initial validation is successful, check for existing email/contact
        if (isValid) {
            // Simulated existing email and contact (should be replaced with actual AJAX call)
            const existingUsername = ['Manshi'];
            const existingPassword = ['M@nsi12'];

            if (existingUsername.includes(username) || existingPassword.includes(password)) {
                document.getElementById('formError').innerText = 'User already exists with given details. Try logging in.';
                isValid = false;
            }
        }

        return isValid;
    }

    function clearErrorMessages() {
        // Clear all error messages
        document.getElementById('usernameError').innerText = '';
        document.getElementById('passwordError').innerText = '';
        document.getElementById('formError').innerText = '';
    }

    // Add event listeners to input fields to clear error messages on focus
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', () => clearErrorMessages());
    });
</script>
</body>
</html>


