package controller;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String college = request.getParameter("college");
        String skills = request.getParameter("skills");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/devconnect_db", "root", "Harsh@@@123");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users (name, email, password, role, college, skills) VALUES (?, ?, ?, 'student', ?, ?)");
            ps.setString(1, fullName); ps.setString(2, email); ps.setString(3, password); ps.setString(4, college); ps.setString(5, skills);
            ps.executeUpdate();
            response.sendRedirect("index.jsp?registration=success");
            conn.close();
        } catch (Exception e) { e.printStackTrace(); response.sendRedirect("error500.jsp"); }
    }
}
