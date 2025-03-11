//package com.furnivision.servlet;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;
//import java.sql.*;
//
//@WebServlet("/resetPassword")
//public class ResetPasswordServlet extends HttpServlet {
//
//    private final String url = "jdbc:mysql://localhost:3306/furnivision";
//    private final String user = "root";
//    private final String pwd = "0409";
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String token = request.getParameter("token");
//        String newPassword = request.getParameter("newPassword");
//
//        String hashedPassword = hashPassword(newPassword);
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Connection connection = DriverManager.getConnection(url, user, pwd);
//
//            // Check if token is valid
//            String sql = "SELECT id FROM Users WHERE reset_token = ?";
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, token);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                int userId = rs.getInt("id");
//
//                // Update the password and clear the token
//                String updateQuery = "UPDATE Users SET password = ?, reset_token = NULL WHERE id = ?";
//                PreparedStatement updatePs = connection.prepareStatement(updateQuery);
//                updatePs.setString(1, hashedPassword);
//                updatePs.setInt(2, userId);
//                updatePs.executeUpdate();
//
//                response.sendRedirect("login.jsp?message=Password reset successful");
//            } else {
//                response.sendRedirect("reset-password.jsp?error=Invalid or expired token");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("reset-password.jsp?error=An error occurred.");
//        }
//    }
//
//    private String hashPassword(String password) {
//        try {
//            MessageDigest md = MessageDigest.getInstance("SHA-256");
//            byte[] hashedBytes = md.digest(password.getBytes());
//            StringBuilder sb = new StringBuilder();
//            for (byte b : hashedBytes) {
//                sb.append(String.format("%02x", b));
//            }
//            return sb.toString();
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException("Error hashing password", e);
//        }
//    }
//}
