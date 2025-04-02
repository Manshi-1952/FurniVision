package com.furnivision.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/submit-contract")
public class ContractServlet extends HttpServlet {
  private static final String JDBC_URL = "jdbc:mysql://localhost:3306/furnivision";
  private static final String JDBC_USER = "root"; // Change this
  private static final String JDBC_PASSWORD = "0409"; // Change this

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String propertyType = request.getParameter("propertyType");
    String rooms = request.getParameterValues("rooms") != null ? String.join(", ", request.getParameterValues("rooms")) : "";
    String furniture = request.getParameterValues("furniture") != null ? String.join(", ", request.getParameterValues("furniture")) : "";
    String material = request.getParameter("material");
    String budget = request.getParameter("budget");
    String timeline = request.getParameter("timeline");
    String notes = request.getParameter("notes");

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
      String sql = "INSERT INTO contracts (name, email, phone, property_type, rooms, furniture, material, budget, timeline, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
      PreparedStatement stmt = conn.prepareStatement(sql);
      stmt.setString(1, name);
      stmt.setString(2, email);
      stmt.setString(3, phone);
      stmt.setString(4, propertyType);
      stmt.setString(5, rooms);
      stmt.setString(6, furniture);
      stmt.setString(7, material);
      stmt.setString(8, budget);
      stmt.setString(9, timeline);
      stmt.setString(10, notes);

      int rowsInserted = stmt.executeUpdate();
      stmt.close();
      conn.close();

      if (rowsInserted > 0) {
        response.sendRedirect("contract.jsp");
      } else {
        request.setAttribute("errorMessage", "Something went wrong! Please try again.");
        request.getRequestDispatcher("contract.jsp").forward(request, response);
      }
    } catch (Exception e) {
      e.printStackTrace();
      request.setAttribute("errorMessage", "Something went wrong! Please try again.");
      request.getRequestDispatcher("contract.jsp").forward(request, response);
    }
  }
}
