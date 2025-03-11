//package com.furnivision.servlet;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.sql.*;
//import java.util.UUID;
//import java.util.Properties;
//import jakarta.mail.*;
//import jakarta.mail.internet.*;
//
//
//@WebServlet("/forgotPassword")
//public class ForgotPasswordServlet extends HttpServlet {
//
//  private final String url = "jdbc:mysql://localhost:3306/furnivision";
//  private final String user = "root";
//  private final String pwd = "0409";
//
//  @Override
//  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    String email = request.getParameter("email");
//
//    try {
//      Class.forName("com.mysql.cj.jdbc.Driver");
//      Connection connection = DriverManager.getConnection(url, user, pwd);
//
//      // Check if email exists in the database
//      String sql = "SELECT id FROM Users WHERE email = ?";
//      PreparedStatement ps = connection.prepareStatement(sql);
//      ps.setString(1, email);
//      ResultSet rs = ps.executeQuery();
//
//      if (rs.next()) {
//        int userId = rs.getInt("id");
//        String token = UUID.randomUUID().toString(); // Generate a unique token
//
//        // Store the token in the database
//        String updateQuery = "UPDATE Users SET reset_token = ? WHERE id = ?";
//        PreparedStatement updatePs = connection.prepareStatement(updateQuery);
//        updatePs.setString(1, token);
//        updatePs.setInt(2, userId);
//        updatePs.executeUpdate();
//
//        // Send reset email
//        sendResetEmail(email, token);
//
//        response.sendRedirect("forgot-password.jsp?message=Reset link sent to your email");
//      } else {
//        response.sendRedirect("forgot-password.jsp?error=Email not found");
//      }
//
//    } catch (Exception e) {
//      e.printStackTrace();
//      response.sendRedirect("forgot-password.jsp?error=An error occurred.");
//    }
//  }
//
//  private void sendResetEmail(String email, String token) {
//    String from = "your-email@gmail.com"; // Update with your email
//    String password = "your-email-password"; // Update with your email password
//    String subject = "Password Reset Request";
//    String resetLink = "http://localhost:8080/reset-password.jsp?token=" + token;
//    String message = "Click the link to reset your password: " + resetLink;
//
//    Properties properties = new Properties();
//    properties.put("mail.smtp.host", "smtp.gmail.com");
//    properties.put("mail.smtp.port", "587");
//    properties.put("mail.smtp.auth", "true");
//    properties.put("mail.smtp.starttls.enable", "true");
//
//    Session session = Session.getInstance(properties, new Authenticator() {
//      @Override
//      protected PasswordAuthentication getPasswordAuthentication() {
//        return new PasswordAuthentication(from, password);
//      }
//    });
//
//    try {
//      Message msg = new MimeMessage(session);
//      msg.setFrom(new InternetAddress(from));
//      msg.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
//      msg.setSubject(subject);
//      msg.setText(message);
//      Transport.send(msg);
//    } catch (MessagingException e) {
//      e.printStackTrace();
//    }
//  }
//}
