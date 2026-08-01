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

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private static final String DB =
        "jdbc:mysql://localhost:3306/devconnect_db";

    private static final String USER = "root";
    private static final String PASS = "Harsh@@@123";

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equalsIgnoreCase(
                String.valueOf(session.getAttribute("userRole")))) {

            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn =
                DriverManager.getConnection(DB, USER, PASS);

            PreparedStatement ps = null;

            if ("approve".equals(action)) {

                ps = conn.prepareStatement(
                    "UPDATE project_requests " +
                    "SET status='APPROVED' WHERE id=?"
                );

                ps.setInt(1,
                    Integer.parseInt(request.getParameter("request_id")));

                ps.executeUpdate();

            } else if ("reject".equals(action)) {

                ps = conn.prepareStatement(
                    "UPDATE project_requests " +
                    "SET status='REJECTED' WHERE id=?"
                );

                ps.setInt(1,
                    Integer.parseInt(request.getParameter("request_id")));

                ps.executeUpdate();

            } else if ("deleteUser".equals(action)) {

                int userId =
                    Integer.parseInt(request.getParameter("user_id"));

                ps = conn.prepareStatement(
                    "DELETE FROM project_requests WHERE user_id=?"
                );

                ps.setInt(1, userId);
                ps.executeUpdate();

                ps.close();

                ps = conn.prepareStatement(
                    "DELETE FROM projects WHERE posted_by=?"
                );

                ps.setInt(1, userId);
                ps.executeUpdate();

                ps.close();

                ps = conn.prepareStatement(
                    "DELETE FROM users WHERE id=? AND UPPER(role)<>'ADMIN'"
                );

                ps.setInt(1, userId);
                ps.executeUpdate();

            } else if ("deleteProject".equals(action)) {

                ps = conn.prepareStatement(
                    "DELETE FROM project_requests WHERE project_id=?"
                );

                ps.setInt(1,
                    Integer.parseInt(request.getParameter("project_id")));

                ps.executeUpdate();

                ps.close();

                ps = conn.prepareStatement(
                    "DELETE FROM projects WHERE id=?"
                );

                ps.setInt(1,
                    Integer.parseInt(request.getParameter("project_id")));

                ps.executeUpdate();
            }

            if (ps != null) {
                ps.close();
            }

            conn.close();

            response.sendRedirect("admin_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Admin operation failed");
        }
    }
}