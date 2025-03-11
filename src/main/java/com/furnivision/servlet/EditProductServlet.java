package com.furnivision.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/editProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class EditProductServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int productId = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
      String sql = "SELECT * FROM products WHERE id = ?";
      stmt = conn.prepareStatement(sql);
      stmt.setInt(1, productId);
      rs = stmt.executeQuery();

      if (rs.next()) {
        request.setAttribute("id", rs.getInt("id"));
        request.setAttribute("name", rs.getString("name"));
        request.setAttribute("price", rs.getDouble("price"));
        request.setAttribute("description", rs.getString("description"));
        request.setAttribute("category", rs.getString("category"));
        request.setAttribute("image_url", rs.getString("image_url"));
      }
      request.getRequestDispatcher("editProduct.jsp").forward(request, response);
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int productId = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    double price = Double.parseDouble(request.getParameter("price"));
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    Part filePart = request.getPart("image");

    String existingImage = request.getParameter("existingImage");

    List<String> validCategories = Arrays.asList("sofas", "beds", "tables", "chairs");
    if (!validCategories.contains(category.toLowerCase())) {
      request.setAttribute("errorMessage", "Invalid category selected!");
      request.getRequestDispatcher("admin.jsp").forward(request, response);
      return;
    }
//    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName(); // Unique file name

    String imagePath = existingImage; // Default to the existing image


//    // ✅ Corrected upload path (outside webapp)
//    String uploadPath = "C:/Users/Manshi Gohil/Desktop/FurniVision/src/main/webapp/uploads";
//
//    File uploadDir = new File(uploadPath);
//    if (!uploadDir.exists()) {
//      uploadDir.mkdir();  // Create folder if it doesn’t exist
//    }
//
//    // ✅ Save file on the server
//    String filePath = uploadPath + File.separator + fileName;
//
//    try (InputStream fileContent = filePart.getInputStream();
//         FileOutputStream fos = new FileOutputStream(filePath)) {
//      byte[] buffer = new byte[1024];
//      int bytesRead;
//      while ((bytesRead = fileContent.read(buffer)) != -1) {
//        fos.write(buffer, 0, bytesRead);
//      }
//    }
//
//    // ✅ Store relative path in DB (so it works after redeployment)
//    String imagePath = "uploads/" + fileName;

    if (filePart != null && filePart.getSize() > 0) {
      String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

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
      imagePath = "uploads/" + fileName; // Update imagePath only if a new file is uploaded
    }
    Connection conn = null;
    PreparedStatement stmt = null;


    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");
      String sql = "UPDATE products SET name=?, price=?, description=?, category=?, image_url=? WHERE id=?";
      stmt = conn.prepareStatement(sql);
      stmt.setString(1, name);
      stmt.setDouble(2, price);
      stmt.setString(3, description);
      stmt.setString(4, category);
      stmt.setString(5, imagePath);
      stmt.setInt(6, productId);

      int rowsUpdated = stmt.executeUpdate();
      if (rowsUpdated > 0) {
        response.sendRedirect("admin.jsp?message=Product Updated Successfully");
      } else {
        response.sendRedirect("editProduct.jsp?id=" + productId + "&error=Update Failed");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
  }
}
