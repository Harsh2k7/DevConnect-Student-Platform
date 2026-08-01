package controller;

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

@WebServlet("/PostProjectServlet")
public class PostProjectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String skills = request.getParameter("required_skills");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/devconnect_db",
                "root",
                "Harsh@@@123"
            );

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO projects " +
                "(title, description, required_skills, posted_by, status) " +
                "VALUES (?, ?, ?, ?, 'ACTIVE')"
            );

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, skills);
            ps.setInt(4, userId);

            ps.executeUpdate();

            ps.close();
            conn.close();

            response.sendRedirect("marketplace.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, e.getMessage());
        }
    }
}