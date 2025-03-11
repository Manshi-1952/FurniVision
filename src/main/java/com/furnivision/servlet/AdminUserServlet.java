package com.furnivision.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

import static java.lang.System.out;

@WebServlet("/manageUsers")
public class AdminUserServlet extends HttpServlet {

  private final String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
  private final String user = "root";
  private final String pwd = "0409";

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("isAdmin") == null || !(Boolean) session.getAttribute("isAdmin")) {
      response.sendRedirect("login.jsp?error=Unauthorized Access");
      return;
    }
    out.println("isAdmin: " + session.getAttribute("isAdmin"));


    String action = request.getParameter("action");
    int userId = Integer.parseInt(request.getParameter("id"));

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
        if ("delete".equals(action)) {
          String deleteQuery = "DELETE FROM users WHERE id = ?";
          try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
          }
        } else if ("updateRole".equals(action)) {
          String newRole = request.getParameter("new_role");

          int isAdmin = newRole.equalsIgnoreCase("Admin") ? 1 : 0;

          String sql = "UPDATE users SET role = ?, is_admin = ? WHERE id = ?";
          try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, newRole);
            stmt.setInt(2, isAdmin);
            stmt.setInt(3, userId);
            stmt.executeUpdate();
          }
        } else if ("updateStatus".equals(action)) {
          String newStatus = request.getParameter("new_status"); // Should be "active" or "suspended"
          String updateQuery = "UPDATE users SET status = ? WHERE id = ?";
          try (PreparedStatement stmt = connection.prepareStatement(updateQuery)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, userId);
            int rowsAffected = stmt.executeUpdate();
            out.println("Rows affected: " + rowsAffected);
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    response.sendRedirect("manageUsers.jsp");
  }
}
