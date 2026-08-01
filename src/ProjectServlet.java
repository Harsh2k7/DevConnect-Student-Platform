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

@WebServlet("/ProjectServlet")
public class ProjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Unauthorized session.\"}");
            return;
        }

        int studentId = (int) session.getAttribute("userId");
        String projectIdParam = request.getParameter("project_id");

        if (projectIdParam == null || projectIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Missing project parameters.\"}");
            return;
        }

        int projectId = Integer.parseInt(projectIdParam);
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/devconnect_db", "root", "Harsh@@@123");

            // Checking for duplicate requests first
            String checkQuery = "SELECT id FROM project_requests WHERE project_id=? AND user_id=?";
            PreparedStatement checkPs = conn.prepareStatement(checkQuery);
            checkPs.setInt(1, projectId);
            checkPs.setInt(2, studentId);

            if (checkPs.executeQuery().next()) {
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"exists\",\"message\":\"Application already queued.\"}");
                checkPs.close();
                return;
            }
            checkPs.close();

            // Insert into requests table
            String query = "INSERT INTO project_requests (project_id, user_id, status) VALUES (?, ?, 'pending')";
            ps = conn.prepareStatement(query);
            ps.setInt(1, projectId);
            ps.setInt(2, studentId);

            int result = ps.executeUpdate();
            response.setContentType("application/json");
            if (result > 0) {
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Application dispatched safely.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Database operation failed.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"System exception raised.\"}");
        } finally {
            try { if (ps != null) ps.close(); } catch(Exception e){}
            try { if (conn != null) conn.close(); } catch(Exception e){}
        }
    }
}

