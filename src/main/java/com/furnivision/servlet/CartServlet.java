package com.furnivision.servlet;

import com.furnivision.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
//  private static final long serialVersionUID = 1L;

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
        // Check if product already exists in the cart
        String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        boolean isInCart = false;

        try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
          checkStmt.setInt(1, userId);
          checkStmt.setInt(2, productId);
          ResultSet resultSet = checkStmt.executeQuery();

          if (resultSet.next()) {
            isInCart = true; // Product is already in the cart
          }
        }

        JSONObject json = new JSONObject();
        if (isInCart) {
          json.put("success", true);
          json.put("isInCart", true);
          json.put("message", "Already in Cart");
        } else {
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

          json.put("success", true);
          json.put("isInCart", false);
          json.put("message", "Added to Cart");
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
      }

    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
    } catch (SQLException e) {
      e.printStackTrace();
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
    }
  }
}

