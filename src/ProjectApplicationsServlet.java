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

@WebServlet("/ProjectApplicationsServlet")
public class ProjectApplicationsServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int ownerId = (Integer) session.getAttribute("userId");

        int requestId = Integer.parseInt(
            request.getParameter("request_id")
        );

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/devconnect_db",
                "root",
                "Harsh@@@123"
            );

            String sql;

            if ("approve".equalsIgnoreCase(action)) {

                sql = "UPDATE project_requests r " +
                      "JOIN projects p ON r.project_id = p.id " +
                      "SET r.status='APPROVED' " +
                      "WHERE r.id=? AND p.posted_by=?";

            } else if ("reject".equalsIgnoreCase(action)) {

                sql = "UPDATE project_requests r " +
                      "JOIN projects p ON r.project_id = p.id " +
                      "SET r.status='REJECTED' " +
                      "WHERE r.id=? AND p.posted_by=?";

            } else {
                response.sendError(400, "Invalid action");
                return;
            }

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, requestId);
            ps.setInt(2, ownerId);

            ps.executeUpdate();

            ps.close();
            conn.close();

            response.sendRedirect("my_projects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, e.getMessage());
        }
    }
}