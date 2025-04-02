
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*, java.util.*" %>
<%@ page import="com.furnivision.util.DatabaseConnection" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("user_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) sessionObj.getAttribute("user_id");
%>

<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="./CSS/cart.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

<h2 class="h2">Your Shopping Cart</h2>

<table>
    <tr>
        <th>Product Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
        <th>Action</th>
    </tr>

    <%
        double totalCartPrice = 0;
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT p.name AS product_name, p.price, c.quantity, c.id FROM Cart c JOIN Products p ON c.product_id = p.id WHERE c.user_id = ?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, userId);
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    double totalPrice = resultSet.getDouble("price") * resultSet.getInt("quantity");
                    totalCartPrice += totalPrice;
    %>
    <tr>
        <td><%= resultSet.getString("product_name") %></td>
        <td>$<%= resultSet.getDouble("price") %></td>
        <td>
            <input type="number" class="quantity-input"
                   data-id="<%= resultSet.getInt("id") %>"
                   data-price="<%= resultSet.getDouble("price") %>"
                   value="<%= resultSet.getInt("quantity") %>"
                   min="1">
        </td>
        <td class="total-price">₹<%= String.format("%.2f", totalPrice) %></td>
        <td>
            <form action="RemoveFromCartServlet" method="post" onsubmit="return confirm('Are you sure you want to remove this item?')">
                <input type="hidden" name="id" value="<%= resultSet.getInt("id") %>">
                <button type="submit" class="remove-btn">Remove</button>
            </form>

        </td>
    </tr>
    <%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
<h3>Total Cart Price: ₹<span id="total-cart-price"><%= String.format("%.2f", totalCartPrice) %></span></h3>

<%
    boolean isCartEmpty = (totalCartPrice == 0);
%>

<%--<form id="payment-form">--%>
<%--    <button type="button" class="payment-btn" id="pay-button" <% if (isCartEmpty) { %> disabled <% } %>>Proceed to Payment</button>--%>
<%--</form>--%>

<br>
<a href="index.jsp">Continue Shopping</a>
<script src="./Javascript/app.js"></script>

<script>
    $(document).ready(function () {
        $(".quantity-input").on("change", function () {
            let cartId = $(this).data("id");
            let price = parseFloat($(this).data("price"));
            let quantity = parseInt($(this).val());

            if (quantity < 1) {
                quantity = 1;
                $(this).val(1);
            }

            let totalPriceElement = $(this).closest("tr").find(".total-price");
            let newTotal = (price * quantity).toFixed(2);
            totalPriceElement.text("₹" + newTotal);

            updateCart(cartId, quantity);
        });

        function updateCart(cartId, quantity) {
            $.ajax({
                url: "UpdateCartServlet",
                type: "POST",
                data: {id: cartId, quantity: quantity},
                success: function (response) {
                    if (response.success) {
                        $("#total-cart-price").text(response.totalCartPrice.toFixed(2));
                    } else {
                        alert(response.error);
                    }
                },
                error: function () {
                    alert("Failed to update quantity. Try again.");
                }
            });
        }
    });

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

<script src="https://sdk.cashfree.com/js/v3/cashfree.js"></script>

</body>
</html>
