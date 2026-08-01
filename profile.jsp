<%@ page import="java.sql.*" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/devconnect_db",
            "root",
            "Harsh@@@123"
        );

        ps = conn.prepareStatement(
            "SELECT id,name,email,college,skills,role FROM users WHERE id=?"
        );

        ps.setInt(1, userId);
        rs = ps.executeQuery();

        if (rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
<title>My Profile</title>

<style>
body {
    background:#0f172a;
    color:white;
    font-family:Arial;
    padding:40px;
}

.card {
    max-width:650px;
    margin:auto;
    background:#111827;
    border:1px solid #334155;
    border-radius:15px;
    padding:30px;
}

h1 {
    margin-bottom:25px;
}

.row {
    padding:15px 0;
    border-bottom:1px solid #334155;
}

.label {
    color:#94a3b8;
    font-size:13px;
}

.value {
    font-size:17px;
    margin-top:5px;
}

a {
    color:white;
    text-decoration:none;
    background:#2563eb;
    padding:10px 15px;
    border-radius:7px;
}
</style>

</head>

<body>

<div class="card">

<h1>My Profile</h1>

<div class="row">
<div class="label">Name</div>
<div class="value"><%= rs.getString("name") %></div>
</div>

<div class="row">
<div class="label">Email</div>
<div class="value"><%= rs.getString("email") %></div>
</div>

<div class="row">
<div class="label">College</div>
<div class="value"><%= rs.getString("college") %></div>
</div>

<div class="row">
<div class="label">Skills</div>
<div class="value"><%= rs.getString("skills") %></div>
</div>

<div class="row">
<div class="label">Role</div>
<div class="value"><%= rs.getString("role") %></div>
</div>

<br>

<a href="marketplace.jsp">Marketplace</a>

</div>

</body>
</html>

<%
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("Profile error: " + e.getMessage());
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(conn != null) conn.close(); } catch(Exception e){}
    }
%>
