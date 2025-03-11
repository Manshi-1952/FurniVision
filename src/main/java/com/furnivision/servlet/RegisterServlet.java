//package com.furnivision.servlet;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//
//@WebServlet("/register")
//public class RegisterServlet extends HttpServlet {
//
//    private String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
//    private String user = "root";
//    private String pwd = "0409";
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        String terms = request.getParameter("terms");
//
//        if (terms == null) {
//            request.setAttribute("errorMessage", "You must agree to the Terms & Conditions and Privacy Policy.");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
//                // Check if email or contact already exists
//                String checkQuery = "SELECT COUNT(*) FROM Users WHERE username = ? OR password = ?";
//                try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
//                    checkStmt.setString(1, username);
//                    checkStmt.setString(2, password);
//                    ResultSet rs = checkStmt.executeQuery();
//                    rs.next();
//                    int count = rs.getInt(1);
//
//                    if (count > 0) {
//                        request.setAttribute("errorMessage", "User already exists with given details. Try logging in.");
//                        request.getRequestDispatcher("register.jsp").forward(request, response);
//                        return;
//                    }
//
//                    String insertQuery = "INSERT INTO Users (username, password) VALUES (?, ?)";
//                    try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
//                        insertStmt.setString(1, username);
//                        insertStmt.setString(2, password);
//
//                        int rowsInserted = insertStmt.executeUpdate();
//                        if (rowsInserted > 0) {
//                            response.sendRedirect("login.jsp?message=Registration successful. Please log in.");
//                        } else {
//                            request.setAttribute("errorMessage", "Registration failed. Please try again.");
//                            request.getRequestDispatcher("register.jsp").forward(request, response);
//                        }
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("errorMessage", "Registration failed. Please try again.");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//        }
//    }
//}

package com.furnivision.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

  private final String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
  private final String user = "root";
  private final String pwd = "0409";

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    String role = request.getParameter("role");
    String terms = request.getParameter("terms");

    if (terms == null) {
      request.setAttribute("errorMessage", "You must agree to the Terms & Conditions.");
      request.getRequestDispatcher("register.jsp").forward(request, response);
      return;
    }

    if (!password.equals(confirmPassword)) {
      request.setAttribute("errorMessage", "Passwords do not match.");
      request.getRequestDispatcher("register.jsp").forward(request, response);
      return;
    }

    String hashedPassword = hashPassword(password); // Hash the password before storing


    try {
      Class.forName("com.mysql.cj.jdbc.Driver");

      try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
        // Check if username already exists
        String checkQuery = "SELECT COUNT(*) FROM users WHERE email = ? OR username = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
          checkStmt.setString(1, email);
          checkStmt.setString(2, username);
          ResultSet rs = checkStmt.executeQuery();
          rs.next();
          int count = rs.getInt(1);

          if (count > 0) {
            request.setAttribute("errorMessage", "Username already exists. Try logging in.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
          }
        }

        boolean isAdmin = "admin".equalsIgnoreCase(role);
        String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String status = "Active"; // Default status


        // Insert user into database
        String insertQuery = "INSERT INTO users (username, password, is_admin, email, role, created_at, status) VALUES (?, ?, ?, ?, ?, ?, ? )";
        try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery)) {
          insertStmt.setString(1, username);
          insertStmt.setString(2, hashedPassword);
          insertStmt.setInt(3, isAdmin ? 1 : 0);
          insertStmt.setString(4, email);
          insertStmt.setString(5, role); // Store role
          insertStmt.setString(6, createdAt); // Store created_at timestamp
          insertStmt.setString(7, status);

          int rowsInserted = insertStmt.executeUpdate();
          System.out.println("Rows inserted: " + rowsInserted);

          if (rowsInserted > 0) {
            System.out.println("User registered successfully!");
            response.sendRedirect("login.jsp?message=Registration successful. Please log in.");
          } else {
            System.out.println("User registration failed.");
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      System.out.println("Error occurred: " + e.getMessage());
      request.setAttribute("errorMessage", "Register failed. Please try again.");
      request.getRequestDispatcher("register.jsp").forward(request, response);
    }
  }

  // Password hashing function using SHA-256
  private String hashPassword(String password) {
    try{
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      byte[] hashedBytes = md.digest(password.getBytes());
      StringBuilder sb = new StringBuilder();
      for (byte b : hashedBytes) {
        sb.append(String.format("%02x", b));
      }
      return sb.toString();
    } catch (NoSuchAlgorithmException e) {
      throw new RuntimeException("Error hashing password", e);
    }
  }
}
