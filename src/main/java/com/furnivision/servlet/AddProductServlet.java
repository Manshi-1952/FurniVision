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
//
//@WebServlet("/addProduct")
//public class AddProductServlet extends HttpServlet {
//
//  private final String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
//  private final String user = "root";
//  private final String pwd = "0409";
//
//  @Override
//  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    String name = request.getParameter("name");
//    String price = request.getParameter("price");
//    String description = request.getParameter("description");
//    String imageUrl = request.getParameter("imageUrl");
//
//    try {
//      Class.forName("com.mysql.cj.jdbc.Driver");
//
//      try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
//        String insertQuery = "INSERT INTO product (name, price, description, image_url) VALUES (?, ?, ?, ?)";
//        try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
//          stmt.setString(1, name);
//          stmt.setDouble(2, Double.parseDouble(price));
//          stmt.setString(3, description);
//          stmt.setString(4, imageUrl);
//
//          int rowsInserted = stmt.executeUpdate();
//          if (rowsInserted > 0) {
//            response.sendRedirect("admin.jsp?message=Product added successfully.");
//          } else {
//            request.setAttribute("errorMessage", "Failed to add product. Try again.");
//            request.getRequestDispatcher("admin.jsp").forward(request, response);
//          }
//        }
//      }
//    } catch (Exception e) {
//      e.printStackTrace();
//      request.setAttribute("errorMessage", "Database error. Try again.");
//      request.getRequestDispatcher("admin.jsp").forward(request, response);
//    }
//  }
//}
package com.furnivision.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.List;

@WebServlet("/addProduct")  // This replaces the servlet mapping in web.xml
@MultipartConfig(
    maxFileSize = 10485760,       // 10MB per file
    maxRequestSize = 52428800,    // 50MB total request size
    fileSizeThreshold = 2097152   // 2MB before writing to disk
)
public class AddProductServlet extends HttpServlet {

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String description = request.getParameter("description");
    Part filePart = request.getPart("image");
    String category = request.getParameter("category");

    // Validate required fields
    if (name == null || name.isEmpty() || price == null || price.isEmpty() ||
        category == null || category.isEmpty() || filePart == null || filePart.getSubmittedFileName().isEmpty()) {
      request.setAttribute("errorMessage", "All fields are required!");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }

    // ✅ Category validation
    List<String> validCategories = Arrays.asList("sofas", "beds", "tables", "chairs","cabinets");
    if (!validCategories.contains(category.toLowerCase())) {
      request.setAttribute("errorMessage", "Invalid category selected!");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }

    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName(); // Unique file name

    // ✅ Corrected upload path (outside webapp)
    String uploadPath = "C:/Users/Manshi Gohil/Desktop/FurniVision/src/main/webapp/uploads";

    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
      uploadDir.mkdir();  // Create folder if it doesn’t exist
    }

    // ✅ Save file on the server
    String filePath = uploadPath + File.separator + fileName;

    try (InputStream fileContent = filePart.getInputStream();
         FileOutputStream fos = new FileOutputStream(filePath)) {
      byte[] buffer = new byte[1024];
      int bytesRead;
      while ((bytesRead = fileContent.read(buffer)) != -1) {
        fos.write(buffer, 0, bytesRead);
      }
    }

    // ✅ Store relative path in DB (so it works after redeployment)
    String imagePath = "uploads/" + fileName;

    // ✅ Save product details in database
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
      String user = "root";
      String pwd = "0409";
      try (Connection connection = DriverManager.getConnection(url, user, pwd)) {
        String insertQuery = "INSERT INTO products (name, price, description, image_url, category) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
          stmt.setString(1, name);
          stmt.setDouble(2, Double.parseDouble(price));
          stmt.setString(3, description);
          stmt.setString(4, imagePath); // ✅ Store relative path
          stmt.setString(5, category);

          int rowsInserted = stmt.executeUpdate();
          if (rowsInserted > 0) {
            response.sendRedirect("admin.jsp?message=Product added successfully.");
          } else {
            request.setAttribute("errorMessage", "Failed to add product. Try again.");
            request.getRequestDispatcher("admin.jsp").forward(request, response);
          }
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      request.setAttribute("errorMessage", "Database error: " + e.getMessage());
      request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
  }
}
