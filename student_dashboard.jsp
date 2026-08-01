<%@ page import="java.sql.*" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if (userId == null) {
    response.sendRedirect("index.jsp");
    return;
}

String userName = (String) session.getAttribute("userName");

if (userName == null || userName.trim().isEmpty()) {
    userName = "Student";
}

int activeProjects = 0;
int myProjects = 0;
int pendingApplications = 0;
int approvedApplications = 0;

Connection conn = null;

try {

    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/devconnect_db",
        "root",
        "Harsh@@@123"
    );

    PreparedStatement ps;
    ResultSet rs;

    /* Active Projects */

    ps = conn.prepareStatement(
        "SELECT COUNT(*) FROM projects WHERE status='ACTIVE'"
    );

    rs = ps.executeQuery();

    if (rs.next()) {
        activeProjects = rs.getInt(1);
    }

    rs.close();
    ps.close();


    /* My Projects */

    ps = conn.prepareStatement(
        "SELECT COUNT(*) FROM projects WHERE posted_by=?"
    );

    ps.setInt(1, userId);

    rs = ps.executeQuery();

    if (rs.next()) {
        myProjects = rs.getInt(1);
    }

    rs.close();
    ps.close();


    /* Pending Applications */

    ps = conn.prepareStatement(
        "SELECT COUNT(*) FROM project_requests " +
        "WHERE user_id=? AND status='PENDING'"
    );

    ps.setInt(1, userId);

    rs = ps.executeQuery();

    if (rs.next()) {
        pendingApplications = rs.getInt(1);
    }

    rs.close();
    ps.close();


    /* Approved Applications */

    ps = conn.prepareStatement(
        "SELECT COUNT(*) FROM project_requests " +
        "WHERE user_id=? AND status='APPROVED'"
    );

    ps.setInt(1, userId);

    rs = ps.executeQuery();

    if (rs.next()) {
        approvedApplications = rs.getInt(1);
    }

    rs.close();
    ps.close();

} catch (Exception e) {

    e.printStackTrace();

}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Student Dashboard</title>

<script src="https://cdn.tailwindcss.com"></script>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background: #020617;
    color: #ffffff;
    font-family: Arial, Helvetica, sans-serif;
}

.sidebar {
    background: #0f172a;
    border-right: 1px solid #1e293b;
}

.menu-link {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 11px 14px;
    margin-bottom: 6px;
    border-radius: 8px;
    color: #94a3b8;
    text-decoration: none;
    transition: 0.2s;
}

.menu-link:hover {
    background: #1e293b;
    color: #ffffff;
}

.active-menu {
    background: #1e293b;
    color: #ffffff;
}

.icon-box {
    width: 24px;
    height: 24px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 6px;
    color: #60a5fa;
    font-size: 13px;
    font-weight: bold;
}

.dashboard-card {
    background: rgba(15, 23, 42, 0.80);
    border: 1px solid #1e293b;
    border-radius: 12px;
    transition: 0.2s;
}

.dashboard-card:hover {
    border-color: #3b82f6;
    transform: translateY(-2px);
}

.stat-number {
    font-size: 32px;
    font-weight: 700;
}

.small-text {
    color: #64748b;
    font-size: 12px;
}

.action-card {
    display: block;
    text-decoration: none;
    color: white;
}

.action-icon {
    width: 42px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 10px;
    color: #60a5fa;
    font-size: 18px;
    font-weight: bold;
}

</style>

</head>


<body>

<div class="flex min-h-screen">


<!-- SIDEBAR -->

<aside class="sidebar w-64 p-5 hidden md:block">

    <div class="mb-8">

        <h1 class="text-xl font-bold text-white">
            DC
        </h1>

        <p class="text-xs text-slate-500 mt-1">
            Hub Platform
        </p>

    </div>


    <nav>

        <a href="student_dashboard.jsp"
           class="menu-link active-menu">

            <span class="icon-box">D</span>

            <span>Dashboard</span>

        </a>


        <a href="marketplace.jsp"
           class="menu-link">

            <span class="icon-box">M</span>

            <span>Marketplace</span>

        </a>


        <a href="post_project.jsp"
           class="menu-link">

            <span class="icon-box">+</span>

            <span>Post Project</span>

        </a>


        <a href="my_projects.jsp"
           class="menu-link">

            <span class="icon-box">P</span>

            <span>My Projects</span>

        </a>


        <a href="profile.jsp"
           class="menu-link">

            <span class="icon-box">U</span>

            <span>My Profile</span>

        </a>

    </nav>


    <div class="mt-10">

        <a href="LogoutServlet"
           class="menu-link">

            <span class="icon-box">X</span>

            <span>Logout</span>

        </a>

    </div>

</aside>



<!-- MAIN CONTENT -->

<main class="flex-1 p-5 md:p-10">


    <!-- HEADER -->

    <header class="flex justify-between items-center mb-10">

        <div>

            <p class="text-sm text-slate-500">
                Student Workspace
            </p>

            <h1 class="text-3xl font-bold mt-1">
                Dashboard
            </h1>

        </div>


        <div class="text-right">

            <p class="text-xs text-slate-500">
                Logged in as
            </p>

            <p class="text-sm font-semibold text-white mt-1">
                <%= userName %>
            </p>

        </div>

    </header>



    <!-- WELCOME -->

    <section class="mb-8">

        <div class="dashboard-card p-7">

            <p class="text-blue-400 text-sm">
                Welcome back
            </p>

            <h2 class="text-2xl font-bold mt-2">
                Hello, <%= userName %>
            </h2>

            <p class="text-slate-400 text-sm mt-2">
                Find projects, build teams, post your ideas
                and grow your engineering network.
            </p>

        </div>

    </section>



    <!-- STATISTICS -->

    <section>

        <div class="grid grid-cols-1
                    sm:grid-cols-2
                    lg:grid-cols-4 gap-5">


            <!-- ACTIVE PROJECTS -->

            <div class="dashboard-card p-6">

                <p class="text-xs text-slate-400 uppercase">
                    Active Projects
                </p>

                <div class="stat-number mt-2">
                    <%= activeProjects %>
                </div>

                <p class="small-text mt-2">
                    Available in marketplace
                </p>

            </div>


            <!-- MY PROJECTS -->

            <div class="dashboard-card p-6">

                <p class="text-xs text-slate-400 uppercase">
                    My Projects
                </p>

                <div class="stat-number mt-2">
                    <%= myProjects %>
                </div>

                <p class="small-text mt-2">
                    Projects posted by you
                </p>

            </div>


            <!-- PENDING -->

            <div class="dashboard-card p-6">

                <p class="text-xs text-slate-400 uppercase">
                    Pending Applications
                </p>

                <div class="stat-number mt-2">
                    <%= pendingApplications %>
                </div>

                <p class="small-text mt-2">
                    Waiting for response
                </p>

            </div>


            <!-- APPROVED -->

            <div class="dashboard-card p-6">

                <p class="text-xs text-slate-400 uppercase">
                    Approved
                </p>

                <div class="stat-number mt-2">
                    <%= approvedApplications %>
                </div>

                <p class="small-text mt-2">
                    Applications accepted
                </p>

            </div>

        </div>

    </section>



    <!-- QUICK ACTIONS -->

    <section class="mt-10">

        <h2 class="text-xl font-bold mb-5">
            Quick Actions
        </h2>


        <div class="grid grid-cols-1
                    md:grid-cols-3 gap-5">


            <!-- MARKETPLACE -->

            <a href="marketplace.jsp"
               class="dashboard-card action-card p-6">

                <div class="action-icon mb-4">
                    M
                </div>

                <h3 class="font-bold text-lg">
                    Explore Marketplace
                </h3>

                <p class="text-sm text-slate-400 mt-2">
                    Discover active projects and join
                    engineering teams.
                </p>

            </a>


            <!-- POST PROJECT -->

            <a href="post_project.jsp"
               class="dashboard-card action-card p-6">

                <div class="action-icon mb-4">
                    +
                </div>

                <h3 class="font-bold text-lg">
                    Post a Project
                </h3>

                <p class="text-sm text-slate-400 mt-2">
                    Create your own project and find
                    talented teammates.
                </p>

            </a>


            <!-- PROFILE -->

            <a href="profile.jsp"
               class="dashboard-card action-card p-6">

                <div class="action-icon mb-4">
                    U
                </div>

                <h3 class="font-bold text-lg">
                    My Profile
                </h3>

                <p class="text-sm text-slate-400 mt-2">
                    View your profile, college and skills.
                </p>

            </a>


        </div>

    </section>



    <!-- RECENT PROJECTS -->

    <section class="mt-10">

        <div class="dashboard-card p-6">

            <div class="flex justify-between
                        items-center mb-5">

                <div>

                    <h2 class="text-xl font-bold">
                        My Recent Projects
                    </h2>

                    <p class="text-xs text-slate-500 mt-1">
                        Projects posted by you
                    </p>

                </div>


                <a href="my_projects.jsp"
                   class="text-blue-400 text-sm">

                    View All

                </a>

            </div>


<%

boolean foundProjects = false;

try {

    PreparedStatement recent =
        conn.prepareStatement(
            "SELECT id,title,required_skills,status " +
            "FROM projects " +
            "WHERE posted_by=? " +
            "ORDER BY id DESC LIMIT 5"
        );

    recent.setInt(1, userId);

    ResultSet recentRs =
        recent.executeQuery();


    while (recentRs.next()) {

        foundProjects = true;

%>


            <div class="border-t border-slate-800
                        py-4 flex justify-between
                        items-center">


                <div>

                    <h3 class="font-semibold text-white">
                        <%= recentRs.getString("title") %>
                    </h3>

                    <p class="text-xs text-slate-500 mt-1">
                        <%= recentRs.getString("required_skills") %>
                    </p>

                </div>


                <span class="text-xs px-3 py-1
                             rounded-full
                             bg-green-950
                             text-green-400">

                    <%= recentRs.getString("status") %>

                </span>


            </div>


<%

    }


    recentRs.close();
    recent.close();


} catch (Exception e) {

    e.printStackTrace();

}


if (!foundProjects) {

%>


            <div class="text-center py-8">

                <p class="text-slate-500">
                    You have not posted any project yet.
                </p>

                <a href="post_project.jsp"
                   class="inline-block mt-4
                          bg-blue-600
                          hover:bg-blue-700
                          px-5 py-2
                          rounded-lg
                          text-sm">

                    Post Your First Project

                </a>

            </div>


<%

}

%>


        </div>

    </section>



    <!-- FOOTER -->

    <footer class="mt-10 pt-5
                   border-t border-slate-800">

        <p class="text-xs text-slate-600">
            DevConnect Student Platform
        </p>

    </footer>


</main>

</div>


<!-- JAVASCRIPT -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    console.log("Student Dashboard Loaded");

});

</script>


</body>

</html>