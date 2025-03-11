//  package com.furnivision.servlet;
//
//  import jakarta.servlet.*;
//  import jakarta.servlet.annotation.WebServlet;
//  import jakarta.servlet.http.*;
//  import java.io.IOException;
//  import java.sql.*;
//  @WebServlet("/login")
//  public class LoginServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//      String username = request.getParameter("username");
//      String password = request.getParameter("password");
//      String remember = request.getParameter("remember");
//
//      Connection connection = null;
//      PreparedStatement preparedStatement = null;
//      ResultSet resultSet = null;
//
//      try {
//        Class.forName("com.mysql.cj.jdbc.Driver");
//        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
//
//        // Use BINARY keyword for case-sensitive comparison
//        String sql = "SELECT * FROM Users WHERE BINARY username = ? AND BINARY password = ?";
//        preparedStatement = connection.prepareStatement(sql);
//        preparedStatement.setString(1, username);
//        preparedStatement.setString(2, password);
//        resultSet = preparedStatement.executeQuery();
//
//        if (resultSet.next()) {
//          HttpSession session = request.getSession();
//          int userId = resultSet.getInt("id"); // Fetch the user ID from the result set
//          boolean isAdmin = resultSet.getBoolean("is_admin");
//
//          session.setAttribute("username", username);
//          session.setAttribute("user_id", userId); // Store user ID in session
//          session.setAttribute("is_admin", isAdmin);
//
//
//          //System.out.println("User ID set in session: " + session.getAttribute("user_id"));
//
//          if ("on".equals(remember)) {
//            session.setMaxInactiveInterval(60 * 60 * 24 * 30); // 30 days
//          } else {
//            session.setMaxInactiveInterval(60 * 30); // 30 minutes
//          }
//
//          // Redirect based on user type
//          if (isAdmin) {
//            response.sendRedirect("admin.jsp"); // Redirect admin to admin panel
//          } else {
//            response.sendRedirect("index.jsp"); // Redirect normal user
//          }
//
//        } else {
//          response.sendRedirect("login.jsp?error=Invalid username/password");
//        }
//
//      } catch (ClassNotFoundException | SQLException e) {
//        e.printStackTrace();
//        response.sendRedirect("login.jsp?error=An error occurred. Please try again.");
//      } finally {
//        try {
//          if (resultSet != null) resultSet.close();
//          if (preparedStatement != null) preparedStatement.close();
//          if (connection != null) connection.close();
//        } catch (SQLException e) {
//          e.printStackTrace();
//        }
//      }
//    }
//  }

package com.furnivision.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

  private final String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
  private final String user = "root";
  private final String pwd = "0409";

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String remember = request.getParameter("remember");

    String hashedPassword = hashPassword(password); // Hash the entered password before checking

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");

      try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
        // Fetch user details
        String sql = "SELECT id, password, is_admin, role FROM Users WHERE BINARY username = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
          preparedStatement.setString(1, username);
          ResultSet resultSet = preparedStatement.executeQuery();

          if (resultSet.next()) {
            String storedPassword = resultSet.getString("password");
            boolean isAdmin = resultSet.getInt("is_admin") == 1; // Use getInt() for boolean values
            String role = resultSet.getString("role");

            if (storedPassword.equals(hashedPassword)) { // Compare hashed passwords
              HttpSession session = request.getSession();
              session.setAttribute("username", username);
              session.setAttribute("user_id", resultSet.getInt("id"));
              session.setAttribute("isAdmin", isAdmin); // Ensure correct session attribute name
              session.setAttribute("role", role);

              // Set session timeout based on "Remember Me"
              if ("on".equals(remember)) {
                session.setMaxInactiveInterval(60 * 60 * 24 * 30); // 30 days
              } else {
                session.setMaxInactiveInterval(60 * 30); // 30 minutes
              }

              // Redirect based on user type
              if (isAdmin) {
                response.sendRedirect("admin.jsp");
              } else {
                response.sendRedirect("index.jsp");
              }
            } else {
              response.sendRedirect("login.jsp?error=Invalid username/password");
            }
          } else {
            response.sendRedirect("login.jsp?error=Invalid username/password");
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      response.sendRedirect("login.jsp?error=An error occurred. Please try again.");
    }
  }


  // Secure password hashing function (SHA-256)
  private String hashPassword(String password) {
    try {
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
