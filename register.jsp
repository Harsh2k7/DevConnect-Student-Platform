<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Register Identity</title><script src="https://cdn.tailwindcss.com"></script></head>
<body class="bg-[#0F172A] text-slate-200 min-h-screen p-8 flex items-center justify-center">
    <div class="max-w-xl w-full bg-slate-900/60 border border-slate-800 p-8 rounded-2xl shadow-2xl space-y-6">
        <h2 class="text-2xl font-bold text-white">Create Developer Identity</h2>
        <form action="RegisterServlet" method="POST" class="space-y-4">
            <div class="grid grid-cols-2 gap-4">
                <div><label class="block text-xs text-slate-400 mb-1">Full Name</label><input type="text" name="full_name" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-sm text-white"></div>
                <div><label class="block text-xs text-slate-400 mb-1">Email</label><input type="email" name="email" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-sm text-white"></div>
            </div>
            <div><label class="block text-xs text-slate-400 mb-1">Password</label><input type="password" name="password" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-sm text-white"></div>
            <div><label class="block text-xs text-slate-400 mb-1">Institute / College</label><input type="text" name="college" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-sm text-white"></div>
            <div><label class="block text-xs text-slate-400 mb-1">Tech Stack Skills</label><textarea name="skills" required rows="3" class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-sm text-white resize-none"></textarea></div>
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 rounded-lg text-sm transition">Complete Onboarding</button>
        </form>
    </div>
</body>
</html>
