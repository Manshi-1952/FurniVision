package com.furnivision.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int productId = Integer.parseInt(request.getParameter("id"));

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");

      String sql = "DELETE FROM products WHERE id = ?";
      try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, productId);
        stmt.executeUpdate();
      }

      conn.close();
    } catch (Exception e) {
      e.printStackTrace();
    }

    response.sendRedirect("admin.jsp"); // Redirect back to admin page
  }
}
