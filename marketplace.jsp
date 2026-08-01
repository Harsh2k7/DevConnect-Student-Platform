<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String studentName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Innovation Marketplace - DevConnect Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #0F172A; }
        .heading-font { font-family: 'Poppins', sans-serif; }
        .glass-panel { background: rgba(30, 41, 59, 0.45); backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.08); }
    </style>
</head>
<body class="text-slate-200 min-h-screen flex">

    <!-- Sidebar Navigation Shell -->
    <aside class="w-64 border-r border-slate-800 glass-panel flex flex-col justify-between p-6">
        <div class="space-y-8">
            <div class="flex items-center space-x-2">
                <div class="bg-blue-600 px-2 py-1 rounded text-white font-bold text-sm">DC</div>
                <span class="heading-font font-bold text-lg text-white">Hub Platform</span>
            </div>
            <nav class="space-y-2">
                <a href="student_dashboard.jsp" class="flex items-center space-x-3 px-4 py-2.5 hover:bg-slate-800/40 rounded-lg text-slate-400 hover:text-white text-sm font-medium transition">
                    <span>📁 Dashboard Base</span>
                </a>
                <a href="marketplace.jsp" class="flex items-center space-x-3 px-4 py-2.5 bg-slate-800/60 rounded-lg text-white text-sm font-medium">
                    <span>🚀 Marketplace</span>
                </a>
            </nav>
        </div>
        <div>
            <a href="LogoutServlet" class="block text-center text-xs text-red-400 hover:text-red-300 font-medium py-2 border border-red-950/60 hover:bg-red-950/30 rounded-lg transition">Terminate Session</a>
        </div>
    </aside>

    <!-- Marketplace Main Area -->
    <main class="flex-grow p-8 overflow-y-auto max-w-6xl mx-auto">
        <header class="flex flex-col md:flex-row md:justify-between md:items-center gap-4 mb-8">
            <div>
                <h1 class="heading-font text-2xl font-bold text-white">Project Marketplace</h1>
                <p class="text-xs text-slate-400">Discover active engineering ecosystems seeking core builders.</p>
            </div>
            <!-- Search Suggestion Bar Component -->
            <div class="relative">
                <input type="text" id="searchInput" onkeyup="filterMarketplace()" placeholder="Search tech stacks... (e.g. React)" class="bg-slate-900 border border-slate-700 rounded-lg px-4 py-2 text-xs text-white focus:outline-none focus:border-blue-500 w-64">
            </div>
        </header>

        <!-- Project Flex/Grid System -->
        <section id="marketplaceGrid" class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/devconnect_db", "root", "Harsh@@@123");
                    stmt = conn.createStatement();
                    String sql = "SELECT p.*, u.name FROM projects p JOIN users u ON p.posted_by = u.id WHERE p.status='ACTIVE'";
                    rs = stmt.executeQuery(sql);
                    while(rs.next()) {
            %>
                <div class="project-card glass-panel p-6 rounded-xl flex flex-col justify-between space-y-4 hover:border-slate-600 transition" data-skills="<%= rs.getString("required_skills").toLowerCase() %>">
                    <div class="space-y-2">
                        <div class="flex justify-between items-center">
                            <span class="text-[10px] text-slate-400 font-mono">Lead: <%= rs.getString("name") %></span>
                            <span class="px-2 py-0.5 bg-blue-950 text-blue-400 border border-blue-900 text-[9px] font-bold rounded-full uppercase">Recruiting</span>
                        </div>
                        <h3 class="heading-font text-base font-semibold text-white"><%= rs.getString("title") %></h3>
                        <p class="text-xs text-slate-400 line-clamp-3"><%= rs.getString("description") %></p>
                    </div>

                    <div class="pt-4 border-t border-slate-800 flex justify-between items-center">
                        <div class="flex flex-wrap gap-1">
                            <span class="bg-slate-800 text-slate-300 text-[9px] px-2 py-0.5 rounded font-mono"><%= rs.getString("required_skills") %></span>
                        </div>
                        <button onclick="dispatchApplication(<%= rs.getInt("id") %>, this)" class="text-[11px] font-medium bg-blue-600 hover:bg-blue-700 text-white px-3 py-1.5 rounded-lg transition-all">
                            Join Team
                        </button>
                    </div>
                </div>
            <%
                    }
                } catch(Exception e) {
            %>
                <p class="text-xs text-red-400">Error rendering marketplace modules from database schema pipeline.</p>
            <%
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception e){}
                    try { if(stmt != null) stmt.close(); } catch(Exception e){}
                    try { if(conn != null) conn.close(); } catch(Exception e){}
                }
            %>
        </section>
    </main>

    <!-- Dynamic Live Processing AJAX Blocks -->
    <script>
        function filterMarketplace() {
            let input = document.getElementById('searchInput').value.toLowerCase();
            let cards = document.getElementsByClassName('project-card');
            
            for(let i = 0; i < cards.length; i++) {
                let skills = cards[i].getAttribute('data-skills');
                if(skills.includes(input)) {
                    cards[i].style.display = "flex";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }

        function dispatchApplication(projectId, buttonComponent) {
            buttonComponent.disabled = true;
            buttonComponent.innerText = "Processing...";
            
            // Native AJAX post execution loop without dependencies
            const params = new URLSearchParams();
            params.append('project_id', projectId);

            fetch('ProjectServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            })
            .then(response => response.json())
            .then(data => {
                if(data.status === 'success') {
                    buttonComponent.className = "text-[11px] bg-slate-800 text-slate-500 px-3 py-1.5 rounded-lg cursor-not-allowed";
                    buttonComponent.innerText = "Request Sent";
                } else if(data.status === 'exists') {
                    buttonComponent.innerText = "Already Applied";
                    buttonComponent.className = "text-[11px] bg-amber-950 text-amber-400 px-3 py-1.5 rounded-lg cursor-not-allowed";
                } else {
                    alert('Error running transaction sequence.');
                    buttonComponent.disabled = false;
                    buttonComponent.innerText = "Join Team";
                }
            })
            .catch(error => {
                console.error('Network validation failed:', error);
                buttonComponent.disabled = false;
                buttonComponent.innerText = "Join Team";
            });
        }
    </script>
</body>
</html>

