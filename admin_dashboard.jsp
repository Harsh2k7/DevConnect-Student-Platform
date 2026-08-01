```jsp
<%@ page import="java.sql.*" %>

<%
    String role = String.valueOf(session.getAttribute("userRole"));

    if (!"ADMIN".equalsIgnoreCase(role)) {
        response.sendError(403, "Admin access only");
        return;
    }

    String db = "jdbc:mysql://localhost:3306/devconnect_db";
    String dbUser = "root";
    String dbPass = "Harsh@@@123";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(db, dbUser, dbPass);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            background:#0f172a;
            color:white;
            font-family:Arial;
            padding:30px;
        }

        h1 {
            margin-bottom:30px;
        }

        table {
            width:100%;
            border-collapse:collapse;
            margin-bottom:40px;
            background:#111827;
        }

        th,td {
            padding:12px;
            border:1px solid #334155;
            text-align:left;
        }

        th {
            background:#1e293b;
        }

        button {
            padding:7px 12px;
            border:0;
            border-radius:6px;
            cursor:pointer;
        }

        .approve {
            background:#16a34a;
            color:white;
        }

        .reject {
            background:#dc2626;
            color:white;
        }

        .delete {
            background:#ef4444;
            color:white;
        }

        .section {
            margin-top:40px;
        }
    </style>
</head>

<body>

<h1>Admin Dashboard</h1>

<h2>Students / Users</h2>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>College</th>
    <th>Skills</th>
    <th>Role</th>
    <th>Action</th>
</tr>

<%
    Statement userStmt = conn.createStatement();

    ResultSet users =
        userStmt.executeQuery(
            "SELECT id,name,email,college,skills,role " +
            "FROM users ORDER BY id DESC"
        );

    while(users.next()) {
%>

<tr>
    <td><%= users.getInt("id") %></td>
    <td><%= users.getString("name") %></td>
    <td><%= users.getString("email") %></td>
    <td><%= users.getString("college") %></td>
    <td><%= users.getString("skills") %></td>
    <td><%= users.getString("role") %></td>

    <td>
        <% if (!"ADMIN".equalsIgnoreCase(users.getString("role"))) { %>

        <form method="post" action="AdminServlet"
              onsubmit="return confirm('Delete this user?');">

            <input type="hidden"
                   name="action"
                   value="deleteUser">

            <input type="hidden"
                   name="user_id"
                   value="<%= users.getInt("id") %>">

            <button class="delete">
                Delete
            </button>
        </form>

        <% } else { %>

        ADMIN

        <% } %>
    </td>
</tr>

<%
    }

    users.close();
    userStmt.close();
%>

</table>


<div class="section">

<h2>Projects</h2>

<table>
<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Skills</th>
    <th>Posted By</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
    PreparedStatement projectStmt =
        conn.prepareStatement(
            "SELECT p.id,p.title,p.description," +
            "p.required_skills,p.status,u.name " +
            "FROM projects p " +
            "LEFT JOIN users u ON p.posted_by=u.id " +
            "ORDER BY p.id DESC"
        );

    ResultSet projects = projectStmt.executeQuery();

    while(projects.next()) {
%>

<tr>
    <td><%= projects.getInt("id") %></td>

    <td>
        <%= projects.getString("title") %>
    </td>

    <td>
        <%= projects.getString("description") %>
    </td>

    <td>
        <%= projects.getString("required_skills") %>
    </td>

    <td>
        <%= projects.getString("name") %>
    </td>

    <td>
        <%= projects.getString("status") %>
    </td>

    <td>

        <form method="post"
              action="AdminServlet"
              onsubmit="return confirm('Delete project?');">

            <input type="hidden"
                   name="action"
                   value="deleteProject">

            <input type="hidden"
                   name="project_id"
                   value="<%= projects.getInt("id") %>">

            <button class="delete">
                Delete
            </button>

        </form>

    </td>
</tr>

<%
    }

    projects.close();
    projectStmt.close();
%>

</table>

</div>


<div class="section">

<h2>Join Requests</h2>

<table>

<tr>
    <th>Request ID</th>
    <th>Student</th>
    <th>Email</th>
    <th>Project</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
    PreparedStatement requestStmt =
        conn.prepareStatement(
            "SELECT r.id,r.status," +
            "u.name,u.email," +
            "p.title " +
            "FROM project_requests r " +
            "JOIN users u ON r.user_id=u.id " +
            "JOIN projects p ON r.project_id=p.id " +
            "ORDER BY r.id DESC"
        );

    ResultSet requests = requestStmt.executeQuery();

    while(requests.next()) {
%>

<tr>

    <td>
        <%= requests.getInt("id") %>
    </td>

    <td>
        <%= requests.getString("name") %>
    </td>

    <td>
        <%= requests.getString("email") %>
    </td>

    <td>
        <%= requests.getString("title") %>
    </td>

    <td>
        <%= requests.getString("status") %>
    </td>

    <td>

        <% if ("PENDING".equalsIgnoreCase(
                    requests.getString("status"))) { %>

        <form method="post"
              action="AdminServlet"
              style="display:inline;">

            <input type="hidden"
                   name="action"
                   value="approve">

            <input type="hidden"
                   name="request_id"
                   value="<%= requests.getInt("id") %>">

            <button class="approve">
                Approve
            </button>

        </form>

        <form method="post"
              action="AdminServlet"
              style="display:inline;">

            <input type="hidden"
                   name="action"
                   value="reject">

            <input type="hidden"
                   name="request_id"
                   value="<%= requests.getInt("id") %>">

            <button class="reject">
                Reject
            </button>

        </form>

        <% } else { %>

            <%= requests.getString("status") %>

        <% } %>

    </td>

</tr>

<%
    }

    requests.close();
    requestStmt.close();

    conn.close();
%>

</table>

</div>

</body>
</html>
```
