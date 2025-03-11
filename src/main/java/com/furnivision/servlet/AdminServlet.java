//
//package com.furnivision.servlet;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.Part;
//
//import java.io.File;
//import java.io.IOException;
//import java.nio.file.Paths;
//import java.sql.*;
//import java.util.UUID;
//
//
//@WebServlet("/admin")
//@MultipartConfig(
//    fileSizeThreshold = 2 * 1024 * 1024, // 2MB
//    maxFileSize = 10 * 1024 * 1024,      // 10MB
//    maxRequestSize = 50 * 1024 * 1024    // 50MB
//)
//public class AdminServlet extends HttpServlet {
//  private static final String DB_URL = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
//  private static final String DB_USER = "root";
//  private static final String DB_PASSWORD = "0409";
//
//  @Override
//  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//    String action = request.getParameter("action");
//
//    if ("add".equals(action)) {
//      // Retrieve form values
//      String name = request.getParameter("name");
//      String priceStr = request.getParameter("price");
//      String description = request.getParameter("description");
//      String category = request.getParameter("category");
//      Part imagePart = request.getPart("image"); // Uploaded file
//
//      // Validate inputs
//      if (name == null || name.isEmpty() || priceStr == null || category == null || category.isEmpty() || imagePart == null) {
//        request.setAttribute("errorMessage", "All fields are required!");
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
//        return;
//      }
//
//      double price;
//      try {
//        price = Double.parseDouble(priceStr);
//      } catch (NumberFormatException e) {
//        request.setAttribute("errorMessage", "Invalid price format!");
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
//        return;
//      }
//
//      // **Set upload directory inside project**
//      String uploadPath = request.getServletContext().getRealPath("/") + "uploads";
//      File uploadDir = new File(uploadPath);
//      if (!uploadDir.exists()) uploadDir.mkdirs();
//
//      // **Extract file name & prevent overwriting**
//      String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
//
//      if (!fileName.contains(".")) {
//        request.setAttribute("errorMessage", "Invalid file format.");
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
//        return;
//      }
//
//      String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
//
//      // **Validate image file extensions**
//      if (!extension.matches("\\.(jpg|jpeg|png|gif)$")) {
//        request.setAttribute("errorMessage", "Invalid file type! Only JPG, JPEG, PNG, GIF allowed.");
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
//        return;
//      }
//
//      // **Unique filename to avoid conflicts**
//      String uniqueFileName = UUID.randomUUID() + extension;
//      String filePath = uploadPath + File.separator + uniqueFileName;
//
//      // **Save the uploaded file**
//      imagePart.write(filePath);
//
//      // **Relative URL for database**
//      String imageUrl = "uploads/" + uniqueFileName;
//
//      // Insert into database
//      String sql = "INSERT INTO products (name, price, description, image_url, category) VALUES (?, ?, ?, ?, ?)";
//
//      try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
//           PreparedStatement statement = connection.prepareStatement(sql)) {
//
//        statement.setString(1, name);
//        statement.setDouble(2, price);
//        statement.setString(3, description);
//        statement.setString(4, imageUrl);
//        statement.setString(5, category);
//
//        int rowsInserted = statement.executeUpdate();
//        if (rowsInserted > 0) {
//          response.sendRedirect("admin.jsp?message=Product added successfully");
//        } else {
//          request.setAttribute("errorMessage", "Failed to add product.");
//          request.getRequestDispatcher("admin.jsp").forward(request, response);
//        }
//      } catch (SQLException e) {
//        e.printStackTrace();
//        request.setAttribute("errorMessage", "Database error: " + e.getMessage());
//        request.getRequestDispatcher("admin.jsp").forward(request, response);
//      }
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
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.UUID;

@WebServlet("/admin")
@MultipartConfig(
    fileSizeThreshold = 2 * 1024 * 1024, // 2MB
    maxFileSize = 10 * 1024 * 1024,      // 10MB
    maxRequestSize = 50 * 1024 * 1024    // 50MB
)
public class AdminServlet extends HttpServlet {
  private static final String DB_URL = "jdbc:mysql://localhost:3306/furnivision?useSSL=false&serverTimezone=UTC";
  private static final String DB_USER = "root";
  private static final String DB_PASSWORD = "0409";

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");

    if ("add".equals(action)) {
      handleAddProduct(request, response);
    } else if ("edit".equals(action)) {
      handleEditProduct(request, response);
    }
  }

  private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    Part imagePart = request.getPart("image");

    if (name == null || name.isEmpty() || priceStr == null || category == null || category.isEmpty() || imagePart == null) {
      request.setAttribute("errorMessage", "All fields are required!");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }

    double price;
    try {
      price = Double.parseDouble(priceStr);
    } catch (NumberFormatException e) {
      request.setAttribute("errorMessage", "Invalid price format!");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }

    String imageUrl = saveImage(imagePart, request);
    if (imageUrl == null) {
      request.setAttribute("errorMessage", "Invalid file format.");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }

    String sql = "INSERT INTO products (name, price, description, image_url, category) VALUES (?, ?, ?, ?, ?)";
    try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
         PreparedStatement statement = connection.prepareStatement(sql)) {
      statement.setString(1, name);
      statement.setDouble(2, price);
      statement.setString(3, description);
      statement.setString(4, imageUrl);
      statement.setString(5, category);

      if (statement.executeUpdate() > 0) {
        response.sendRedirect("admin.jsp?message=Product added successfully");
      } else {
        request.setAttribute("errorMessage", "Failed to add product.");
        request.getRequestDispatcher("admin.jsp").forward(request, response);
      }
    } catch (SQLException e) {
      e.printStackTrace();
      request.setAttribute("errorMessage", "Database error: " + e.getMessage());
      request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
  }

  private void handleEditProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    Part imagePart = request.getPart("image");

    if (id == null || name == null || name.isEmpty() || priceStr == null || category == null || category.isEmpty()) {
      request.setAttribute("errorMessage", "All fields are required!");
      request.getRequestDispatcher("editProduct.jsp").forward(request, response);
      return;
    }

    double price;
    try {
      price = Double.parseDouble(priceStr);
    } catch (NumberFormatException e) {
      request.setAttribute("errorMessage", "Invalid price format!");
      request.getRequestDispatcher("editProduct.jsp").forward(request, response);
      return;
    }

    String imageUrl = null;

    // Check if a new image was uploaded
    if (imagePart != null && imagePart.getSize() > 0) {
      imageUrl = saveImage(imagePart, request);
      if (imageUrl == null) {
        request.setAttribute("errorMessage", "Invalid file format.");
        request.getRequestDispatcher("editProduct.jsp").forward(request, response);
        return;
      }
    }
    String sql = "UPDATE products SET name=?, price=?, description=?, category=?, image_url=?  WHERE id=?";
    try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
         PreparedStatement statement = connection.prepareStatement(sql)) {
      statement.setString(1, name);
      statement.setDouble(2, price);
      statement.setString(3, description);
      statement.setString(4, category);
      if (imageUrl != null) {
        statement.setString(5, imageUrl);
      } else {
        // Keep existing image if no new image is uploaded
        String existingImageQuery = "SELECT image_url FROM products WHERE id=?";
        try (PreparedStatement existingImageStmt = connection.prepareStatement(existingImageQuery)) {
          existingImageStmt.setInt(1, Integer.parseInt(id));
          ResultSet rs = existingImageStmt.executeQuery();
          if (rs.next()) {
            statement.setString(5, rs.getString("image_url"));
          } else {
            statement.setString(5, ""); // Default empty string if no existing image
          }
        }
      }

      statement.setInt(6, Integer.parseInt(id)); // Set ID parameter

      if (statement.executeUpdate() > 0) {
        response.sendRedirect("admin.jsp?message=Product updated successfully");
      } else {
        request.setAttribute("errorMessage", "Failed to update product.");
        request.getRequestDispatcher("editProduct.jsp").forward(request, response);
      }
    } catch (SQLException e) {
      e.printStackTrace();
      request.setAttribute("errorMessage", "Database error: " + e.getMessage());
      request.getRequestDispatcher("editProduct.jsp").forward(request, response);
    }
  }

  private String saveImage(Part imagePart, HttpServletRequest request) throws IOException {
    String uploadPath = request.getServletContext().getRealPath("/") + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
    if (!fileName.contains(".")) return null;

    String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
    if (!extension.matches("\\.(jpg|jpeg|png|gif)$")) return null;

    String uniqueFileName = UUID.randomUUID() + extension;
    String filePath = uploadPath + File.separator + uniqueFileName;
    imagePart.write(filePath);

    return "uploads/" + uniqueFileName;
  }
}

