package com.furnivision.servlet;

import com.furnivision.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("user_id") == null) {
      response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in.");
      return;
    }

    int userId = (int) session.getAttribute("user_id");
    String productIdStr = request.getParameter("product_id");
    String quantityStr = request.getParameter("quantity");


    if (productIdStr == null || productIdStr.isEmpty()) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product details");
      return;
    }

    try {
      int productId = Integer.parseInt(productIdStr);
      int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

      try (Connection connection = DatabaseConnection.getConnection()) {

        // Fetch product details from Products table
        String productQuery = "SELECT name, price FROM Products WHERE id = ?";
        String productName = null;
        int price = 0;

        try (PreparedStatement productStmt = connection.prepareStatement(productQuery)) {
          productStmt.setInt(1, productId);
          ResultSet productRs = productStmt.executeQuery();

          if (productRs.next()) {
            productName = productRs.getString("name");
            price = productRs.getInt("price");
          } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
          }
        }

        // Check if product already exists in the cart
        String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
          checkStmt.setInt(1, userId);
          checkStmt.setInt(2, productId);
          ResultSet resultSet = checkStmt.executeQuery();

          if (resultSet.next()) {
            // Product exists, update quantity
            int newQuantity = resultSet.getInt("quantity") + quantity;
            String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
              updateStmt.setInt(1, newQuantity);
              updateStmt.setInt(2, userId);
              updateStmt.setInt(3, productId);
              updateStmt.executeUpdate();
            }
          } else {
            // Insert new product into cart
            String insertQuery = "INSERT INTO cart (user_id, product_id, product_name, price, quantity) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
              insertStmt.setInt(1, userId);
              insertStmt.setInt(2, productId);
              insertStmt.setString(3, productName);
              insertStmt.setInt(4, price);
              insertStmt.setInt(5, quantity);
              insertStmt.executeUpdate();
            }
          }
        }
      }

      response.getWriter().write("success");


    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
    } catch (Exception e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
    }
  }
}
