<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Post Project</title>

<style>
body {
    background:#0f172a;
    color:white;
    font-family:Arial;
    padding:40px;
}

.box {
    max-width:600px;
    margin:auto;
    background:#111827;
    padding:30px;
    border-radius:15px;
}

input, textarea {
    width:100%;
    padding:12px;
    margin:10px 0 20px;
    background:#1e293b;
    border:1px solid #475569;
    color:white;
    border-radius:7px;
    box-sizing:border-box;
}

textarea {
    height:130px;
}

button {
    background:#2563eb;
    color:white;
    border:0;
    padding:12px 20px;
    border-radius:7px;
    cursor:pointer;
}
</style>

</head>

<body>

<div class="box">

<h1>Post New Project</h1>

<form method="post" action="PostProjectServlet">

<label>Project Title</label>
<input type="text" name="title" required>

<label>Description</label>
<textarea name="description" required></textarea>

<label>Required Skills</label>
<input type="text"
       name="required_skills"
       placeholder="Java, MySQL, HTML"
       required>

<button type="submit">
Post Project
</button>

</form>

</div>

</body>
</html>
