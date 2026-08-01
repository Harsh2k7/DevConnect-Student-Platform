<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DevConnect Hub - Access Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#0F172A] text-slate-200 min-h-screen flex flex-col justify-between font-sans"><a href="contact.jsp" style="position:fixed;top:20px;right:25px;z-index:9999;color:white;text-decoration:none;background:#2563eb;padding:10px 18px;border-radius:10px;font-weight:bold;">Contact</a>
<!-- DEVCONNECT STARTUP ANIMATION -->
<div id="startupScreen">

    <div class="startup-glow glow1"></div>
    <div class="startup-glow glow2"></div>

    <div class="startup-content">

        <div class="startup-logo">
            DC
        </div>

        <div class="startup-title">
            DevConnect
        </div>

        <div class="startup-subtitle">
            Connect â€¢ Build â€¢ Grow
        </div>

        <div class="startup-line">
            <div></div>
        </div>

        <div class="startup-status">
            Initializing your workspace...
        </div>

    </div>

</div>

<style>

#startupScreen {
    position: fixed;
    inset: 0;
    z-index: 999999;

    display: flex;
    align-items: center;
    justify-content: center;

    background:
        radial-gradient(
            circle at center,
            #172554 0%,
            #020617 45%,
            #000000 100%
        );

    animation: startupExit 0.8s ease 2.8s forwards;
}

.startup-content {
    text-align: center;
    position: relative;
    z-index: 2;
}

.startup-logo {
    width: 90px;
    height: 90px;

    margin: auto;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 24px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #7c3aed
        );

    color: white;

    font-size: 30px;
    font-weight: 900;

    letter-spacing: 3px;

    box-shadow:
        0 0 30px rgba(59,130,246,.7),
        0 0 80px rgba(124,58,237,.4);

    animation:
        logoEnter 1s ease,
        logoPulse 1.5s ease-in-out 1s infinite;
}

.startup-title {
    margin-top: 25px;

    color: white;

    font-size: 34px;
    font-weight: 800;
    letter-spacing: 2px;

    animation: titleEnter 1s ease .3s both;
}

.startup-subtitle {
    margin-top: 8px;

    color: #94a3b8;

    font-size: 14px;
    letter-spacing: 4px;

    animation: titleEnter 1s ease .6s both;
}

.startup-line {
    width: 240px;
    height: 3px;

    margin: 28px auto 15px;

    background: #1e293b;

    border-radius: 20px;

    overflow: hidden;
}

.startup-line div {
    height: 100%;
    width: 0%;

    background:
        linear-gradient(
            90deg,
            #2563eb,
            #7c3aed,
            #06b6d4
        );

    animation:
        startupProgress 2.5s ease forwards;
}

.startup-status {
    color: #64748b;

    font-size: 12px;

    animation:
        statusPulse 1s ease-in-out infinite alternate;
}

.startup-glow {
    position: absolute;

    width: 300px;
    height: 300px;

    border-radius: 50%;

    filter: blur(90px);

    opacity: .25;
}

.glow1 {
    background: #2563eb;

    top: 10%;
    left: 10%;

    animation: floatGlow 5s infinite alternate;
}

.glow2 {
    background: #7c3aed;

    bottom: 10%;
    right: 10%;

    animation: floatGlow 6s infinite alternate-reverse;
}

@keyframes logoEnter {

    from {
        transform: scale(.3) rotate(-20deg);
        opacity: 0;
    }

    to {
        transform: scale(1) rotate(0);
        opacity: 1;
    }

}

@keyframes logoPulse {

    0%,100% {
        transform: scale(1);
    }

    50% {
        transform: scale(1.07);
    }

}

@keyframes titleEnter {

    from {
        transform: translateY(20px);
        opacity: 0;
    }

    to {
        transform: translateY(0);
        opacity: 1;
    }

}

@keyframes startupProgress {

    from {
        width: 0%;
    }

    to {
        width: 100%;
    }

}

@keyframes statusPulse {

    from {
        opacity: .4;
    }

    to {
        opacity: 1;
    }

}

@keyframes floatGlow {

    from {
        transform: translate(0,0) scale(1);
    }

    to {
        transform: translate(80px,-40px) scale(1.3);
    }

}

@keyframes startupExit {

    0% {
        opacity: 1;
        visibility: visible;
    }

    70% {
        opacity: 1;
    }

    100% {
        opacity: 0;
        visibility: hidden;
    }

}

</style>
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

