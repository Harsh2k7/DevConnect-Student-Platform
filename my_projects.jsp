<%@ page import="java.sql.*" %>

<%
Integer userId = (Integer)session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("index.jsp");
    return;
}

Connection conn =
    DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/devconnect_db",
        "root",
        "Harsh@@@123"
    );
%>

<!DOCTYPE html>
<html>

<head>

<title>My Projects</title>

<style>

body {
    background:#0f172a;
    color:white;
    font-family:Arial;
    padding:30px;
}

.card {
    background:#111827;
    border:1px solid #334155;
    padding:20px;
    margin-bottom:25px;
    border-radius:12px;
}

table {
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
}

th,td {
    padding:10px;
    border:1px solid #334155;
}

button {
    padding:7px 12px;
    border:0;
    border-radius:5px;
    color:white;
    cursor:pointer;
}

.approve {
    background:#16a34a;
}

.reject {
    background:#dc2626;
}

</style>

</head>

<body>

<h1>My Projects</h1>

<%

PreparedStatement ps =
    conn.prepareStatement(
        "SELECT id,title,description,required_skills " +
        "FROM projects WHERE posted_by=? " +
        "ORDER BY id DESC"
    );

ps.setInt(1,userId);

ResultSet projects = ps.executeQuery();

while(projects.next()) {

    int projectId = projects.getInt("id");

%>

<div class="card">

<h2>
<%= projects.getString("title") %>
</h2>

<p>
<%= projects.getString("description") %>
</p>

<p>
Skills:
<%= projects.getString("required_skills") %>
</p>

<h3>Applicants</h3>

<table>

<tr>
<th>Name</th>
<th>Email</th>
<th>Status</th>
<th>Action</th>
</tr>

<%

PreparedStatement ap =
    conn.prepareStatement(
        "SELECT r.id,r.status,u.name,u.email " +
        "FROM project_requests r " +
        "JOIN users u ON r.user_id=u.id " +
        "WHERE r.project_id=? " +
        "ORDER BY r.id DESC"
    );

ap.setInt(1,projectId);

ResultSet applicants = ap.executeQuery();

while(applicants.next()) {

%>

<tr>

<td>
<%= applicants.getString("name") %>
</td>

<td>
<%= applicants.getString("email") %>
</td>

<td>
<%= applicants.getString("status") %>
</td>

<td>

<%
if("PENDING".equalsIgnoreCase(
    applicants.getString("status"))) {
%>

<form method="post"
      action="ProjectApplicationsServlet"
      style="display:inline">

<input type="hidden"
       name="request_id"
       value="<%= applicants.getInt("id") %>">

<input type="hidden"
       name="action"
       value="approve">

<button class="approve">
Approve
</button>

</form>

<form method="post"
      action="ProjectApplicationsServlet"
      style="display:inline">

<input type="hidden"
       name="request_id"
       value="<%= applicants.getInt("id") %>">

<input type="hidden"
       name="action"
       value="reject">

<button class="reject">
Reject
</button>

</form>

<%
} else {
%>

<%= applicants.getString("status") %>

<%
}
%>

</td>

</tr>

<%
}

applicants.close();
ap.close();
%>

</table>

</div>

<%
}

projects.close();
ps.close();
conn.close();
%>

</body>

</html>

