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
import jakarta.servlet.http.HttpSession;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    String username = (session != null) ? (String) session.getAttribute("username") : null;

    if (username == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    String idParam = request.getParameter("id");
    System.out.println("Received id: " + idParam);

    if (idParam == null || idParam.isEmpty()) {
      session.setAttribute("error", "Invalid cart item.");
      response.sendRedirect("cart.jsp");
      return;
    }

    int id;
    try {
      id = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
      session.setAttribute("error", "Invalid cart item.");
      response.sendRedirect("cart.jsp");
      return;
    }

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/furnivision", "root", "0409");

      String sql = "DELETE FROM cart WHERE id = ?";
      preparedStatement = connection.prepareStatement(sql);
      preparedStatement.setInt(1, id);

      int rowsDeleted = preparedStatement.executeUpdate();
      System.out.println("Rows Deleted: " + rowsDeleted);

      if (rowsDeleted > 0) {
        session.setAttribute("message", "Item removed successfully!");
      } else {
        session.setAttribute("error", "Failed to remove item.");
      }
    } catch (Exception e) {
      e.printStackTrace();
      session.setAttribute("error", "An error occurred.");
    } finally {
      try {
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
      } catch (Exception ex) {
        ex.printStackTrace();
      }
    }

    response.sendRedirect("cart.jsp");
  }
}
