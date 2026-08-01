<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Session Verification - Admin Guard Layer
    if (session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("index.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Operations Center - DevConnect Hub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #0F172A; }
        .heading-font { font-family: 'Poppins', sans-serif; }
        .glass-panel { background: rgba(30, 41, 59, 0.45); backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.08); }
    </style>
</head>
<body class="text-slate-200 min-h-screen flex flex-col">

    <!-- Global Operations Navigation Header -->
    <header class="w-full px-8 py-4 flex justify-between items-center border-b border-slate-800 glass-panel">
        <div class="flex items-center space-x-4">
            <span class="px-2.5 py-1 text-[10px] font-bold tracking-widest bg-red-950 text-red-400 border border-red-900 rounded-md uppercase">Root Access</span>
            <h1 class="heading-font text-lg font-bold text-white">DevConnect Core Registry</h1>
        </div>
        <div class="flex items-center space-x-4">
            <span class="text-xs text-slate-400 font-medium">Secured Node: <%= adminName %></span>
            <a href="LogoutServlet" class="text-xs text-red-400 hover:text-red-300 transition font-semibold">Exit Session</a>
        </div>
    </header>

    <!-- Main Analytics Framework Layout -->
    <main class="flex-grow max-w-7xl w-full mx-auto px-6 py-12 space-y-8">
        
        <!-- Live Metrics Indicators Widgets -->
        <section class="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div class="glass-panel p-6 rounded-xl border-l-4 border-blue-500">
                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Total Users Registered</p>
                <p class="heading-font text-2xl font-bold text-white mt-1">1,240</p>
            </div>
            <div class="glass-panel p-6 rounded-xl border-l-4 border-purple-500">
                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Active Project Repos</p>
                <p class="heading-font text-2xl font-bold text-white mt-1">412</p>
            </div>
            <div class="glass-panel p-6 rounded-xl border-l-4 border-cyan-500">
                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Pending Match Requests</p>
                <p class="heading-font text-2xl font-bold text-white mt-1">18</p>
            </div>
            <div class="glass-panel p-6 rounded-xl border-l-4 border-emerald-500">
                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Server Health Status</p>
                <p class="heading-font text-2xl font-bold text-emerald-400 mt-1">99.98%</p>
            </div>
        </section>

        <!-- Dynamic User Maintenance Operations Ledger System -->
        <section class="glass-panel rounded-xl overflow-hidden shadow-xl">
            <div class="p-6 border-b border-slate-800 flex justify-between items-center">
                <div>
                    <h3 class="heading-font text-base font-bold text-white">Active System Developers Management</h3>
                    <p class="text-[11px] text-slate-400 mt-0.5">Real-time compilation query data directly from users schema matrix.</p>
                </div>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-slate-900/60 border-b border-slate-800 text-[11px] font-semibold text-slate-400 uppercase tracking-wider">
                            <th class="px-6 py-3.5">User Identity ID</th>
                            <th class="px-6 py-3.5">Email Link</th>
                            <th class="px-6 py-3.5">Affiliated Institute</th>
                            <th class="px-6 py-3.5">Verified System Role</th>
                            <th class="px-6 py-3.5 text-right">Moderation Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800 text-xs text-slate-300">
                        <% 
                            // Live Inline Data Fetch Rendering Mechanism
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/devconnect_db", "root", "Harsh@@@123");
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT id, full_name, email, college, role FROM users ORDER BY id DESC");
                                while(rs.next()) {
                        %>
                            <tr class="hover:bg-slate-800/30 transition">
                                <td class="px-6 py-4 font-medium text-white"><%= rs.getString("full_name") %> <span class="text-[10px] text-slate-500 block">UID-#00<%= rs.getInt("id") %></span></td>
                                <td class="px-6 py-4 text-slate-400"><%= rs.getString("email") %></td>
                                <td class="px-6 py-4"><%= rs.getString("college") %></td>
                                <td class="px-6 py-4">
                                    <span class="px-2 py-0.5 rounded text-[10px] font-semibold tracking-wide <%= "admin".equals(rs.getString("role")) ? "bg-red-950 text-red-400 border border-red-900" : "bg-blue-950 text-blue-400 border border-blue-900" %>">
                                        <%= rs.getString("role").toUpperCase() %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right space-x-2">
                                    <button class="text-[11px] font-medium text-amber-400 bg-amber-950/40 hover:bg-amber-900/50 border border-amber-900/60 px-2.5 py-1 rounded transition">Flag Account</button>
                                </td>
                            </tr>
                        <% 
                                }
                            } catch(Exception e) {
                        %>
                            <tr>
                                 <td colspan="5">
<%= e.getMessage() %>
</td>
                            </tr>
                        <% 
                            } finally {
                                try { if(rs != null) rs.close(); } catch(Exception e){}
                                try { if(stmt != null) stmt.close(); } catch(Exception e){}
                                try { if(conn != null) conn.close(); } catch(Exception e){}
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <footer class="w-full text-center py-4 border-t border-slate-800 text-xs text-slate-500">
        DevConnect Infrastructure Framework Management Panel Dashboard.
    </footer>
</body>
</html>
