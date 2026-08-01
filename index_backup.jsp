<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DevConnect Hub - Access Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#0F172A] text-slate-200 min-h-screen flex flex-col justify-between font-sans">
<!-- LOGIN TRANSITION ANIMATION -->

<div id="loginTransition">

    <div class="login-orbit">

        <div class="orbit-ring ring-one"></div>
        <div class="orbit-ring ring-two"></div>

        <div class="dc-logo">
            DC
        </div>

    </div>

    <div class="login-loading-title">
        Welcome to DevConnect
    </div>

    <div class="login-loading-text">
        Preparing your workspace...
    </div>

    <div class="loading-bar">
        <div class="loading-progress"></div>
    </div>

</div>


<style>

#loginTransition {

    position: fixed;
    inset: 0;

    z-index: 99999;

    display: none;

    align-items: center;
    justify-content: center;

    flex-direction: column;

    background:
        radial-gradient(
            circle at center,
            #172554 0%,
            #020617 45%,
            #000000 100%
        );

    opacity: 0;

    transition:
        opacity 0.35s ease;

}


#loginTransition.show {

    display: flex;

    opacity: 1;

}


.login-orbit {

    position: relative;

    width: 120px;
    height: 120px;

    display: flex;

    align-items: center;
    justify-content: center;

    margin-bottom: 30px;

}


.dc-logo {

    width: 64px;
    height: 64px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 18px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #7c3aed
        );

    color: white;

    font-size: 20px;

    font-weight: 800;

    letter-spacing: 2px;

    box-shadow:
        0 0 25px rgba(59,130,246,.6),
        0 0 60px rgba(124,58,237,.35);

    animation:

        logoPulse
        1.8s
        ease-in-out
        infinite;

}


.orbit-ring {

    position: absolute;

    border-radius: 50%;

    border: 2px solid transparent;

}


.ring-one {

    width: 100px;
    height: 100px;

    border-top-color: #3b82f6;
    border-right-color: #6366f1;

    animation:
        orbitSpin
        1.4s
        linear
        infinite;

}


.ring-two {

    width: 120px;
    height: 120px;

    border-bottom-color: #8b5cf6;
    border-left-color: #06b6d4;

    animation:
        orbitSpinReverse
        2s
        linear
        infinite;

}


.login-loading-title {

    color: white;

    font-size: 22px;

    font-weight: 700;

    margin-bottom: 8px;

    animation:
        textFade
        1.2s
        ease-in-out
        infinite alternate;

}


.login-loading-text {

    color: #94a3b8;

    font-size: 13px;

    margin-bottom: 20px;

}


.loading-bar {

    width: 220px;

    height: 4px;

    background: #1e293b;

    border-radius: 20px;

    overflow: hidden;

}


.loading-progress {

    width: 0%;

    height: 100%;

    border-radius: 20px;

    background:
        linear-gradient(
            90deg,
            #2563eb,
            #7c3aed,
            #06b6d4
        );

    animation:
        loadingProgress
        1.8s
        ease-out
        forwards;

}


@keyframes orbitSpin {

    from {
        transform: rotate(0deg);
    }

    to {
        transform: rotate(360deg);
    }

}


@keyframes orbitSpinReverse {

    from {
        transform: rotate(360deg);
    }

    to {
        transform: rotate(0deg);
    }

}


@keyframes logoPulse {

    0%, 100% {

        transform: scale(1);

        box-shadow:
            0 0 20px rgba(59,130,246,.5);

    }

    50% {

        transform: scale(1.08);

        box-shadow:
            0 0 35px rgba(59,130,246,.8),
            0 0 70px rgba(124,58,237,.4);

    }

}


@keyframes textFade {

    from {
        opacity: .55;
    }

    to {
        opacity: 1;
    }

}


@keyframes loadingProgress {

    0% {
        width: 0%;
    }

    60% {
        width: 75%;
    }

    100% {
        width: 100%;
    }

}

</style>


<script>

document.addEventListener("DOMContentLoaded", function () {

    const loginForm =
        document.querySelector("form");

    const loginTransition =
        document.getElementById("loginTransition");


    if (loginForm && loginTransition) {

        loginForm.addEventListener(
            "submit",
            function () {

                loginTransition.classList.add("show");

            }
        );

    }

});

</script>
    <nav class="w-full px-8 py-4 flex justify-between items-center border-b border-slate-800 bg-slate-900/50 backdrop-blur-md">
        <span class="text-xl font-bold bg-gradient-to-r from-blue-500 to-cyan-400 bg-clip-text text-transparent">DevConnect Hub</span>
    </nav>
    <main class="max-w-7xl w-full mx-auto grid grid-cols-1 md:grid-cols-2 gap-12 items-center px-6 py-12">
        <div class="space-y-6">
            <h1 class="text-5xl font-extrabold text-white leading-tight">Where Student Innovation Meets <span class="text-blue-500">Teams</span></h1>
            <p class="text-slate-400">Find collaborative project partners and manage university hackathons seamlessly.</p>
        </div>
        <div class="bg-slate-900/60 border border-slate-800 p-8 rounded-2xl shadow-2xl space-y-4">
            <h2 class="text-2xl font-bold text-white">Gate Access</h2>
            <form action="LoginServlet" method="POST" class="space-y-4">
                <div><label class="block text-xs text-slate-400 mb-1">Email</label><input type="email" name="email" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-white"></div>
                <div><label class="block text-xs text-slate-400 mb-1">Password</label><input type="password" name="password" required class="w-full bg-slate-800 border border-slate-700 rounded-lg px-4 py-2 text-white"></div>
                <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 rounded-lg text-sm transition">Sign In</button>
            </form>
            <div class="text-center pt-2"><a href="register.jsp" class="text-xs text-slate-400 hover:underline">New user? Register profile</a></div>
        </div>
    </main>
</body>
</html>
