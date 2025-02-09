package com.furnivision.servlet;

import com.furnivision.util.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    JSONObject jsonResponse = new JSONObject();

    String cartIdStr = request.getParameter("id");
    String quantityStr = request.getParameter("quantity");

    if (cartIdStr == null || quantityStr == null) {
      jsonResponse.put("error", "Invalid request");
      out.print(jsonResponse);
      out.flush();
      return;
    }

    try {
      int cartId = Integer.parseInt(cartIdStr);
      int quantity = Integer.parseInt(quantityStr);
      if (quantity < 1) quantity = 1;

      try (Connection connection = DatabaseConnection.getConnection()) {
        String updateQuery = "UPDATE cart SET quantity = ? WHERE id = ?";
        try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
          updateStmt.setInt(1, quantity);
          updateStmt.setInt(2, cartId);
          updateStmt.executeUpdate();
        }

        double totalCartPrice = 0;
        String totalQuery = "SELECT SUM(p.price * c.quantity) AS total_price " +
            "FROM cart c JOIN Products p ON c.product_id = p.id WHERE c.user_id = " +
            "(SELECT user_id FROM cart WHERE id = ?)";

        try (PreparedStatement totalStmt = connection.prepareStatement(totalQuery)) {
          totalStmt.setInt(1, cartId);
          ResultSet rs = totalStmt.executeQuery();
          if (rs.next()) {
            totalCartPrice = rs.getDouble("total_price");
          }
        }

        jsonResponse.put("success", true);
        jsonResponse.put("totalCartPrice", totalCartPrice);
      }

    } catch (Exception e) {
      e.printStackTrace();
      jsonResponse.put("error", "Something went wrong");
    } finally {
      out.print(jsonResponse);
      out.flush();
    }
  }
}
