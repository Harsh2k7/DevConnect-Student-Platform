<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Contact | DevConnect</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: #020617;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .contact-box {
            width: 90%;
            max-width: 650px;
            background: #0f172a;
            padding: 40px;
            border-radius: 20px;
            border: 1px solid #334155;
            box-shadow: 0 20px 60px rgba(0,0,0,.5);
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #94a3b8;
            margin-bottom: 30px;
        }

        .info {
            background: #020617;
            border: 1px solid #1e293b;
            padding: 18px;
            margin-bottom: 15px;
            border-radius: 12px;
        }

        .label {
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .value {
            font-size: 17px;
        }

        a {
            color: #60a5fa;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 25px;
            padding: 12px;
            background: #2563eb;
            color: white;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<div class="contact-box">

    <h1>Contact Me</h1>

    <p class="subtitle">
        DevConnect Student Platform
    </p>

    <div class="info">
        <div class="label">Name</div>
        <div class="value">Mishra Harsh Mahendra</div>
    </div>

    <div class="info">
        <div class="label">Phone</div>
        <div class="value">
            <a href="tel:9370105656">
                +91 9370105656
            </a>
        </div>
    </div>

    <div class="info">
        <div class="label">Email</div>
        <div class="value">
            <a href="mailto:harshm.11082007@gmail.com">
                harshm.11082007@gmail.com
            </a>
        </div>
    </div>
	    <div class="info">
        <div class="label">portfolio</div>
        <div class="value">
            <a href="https://harsh-mahendra-mishra.vercel.app/">
         	portfolio
            </a>
        </div>
    </div>


    <div class="info">
        <div class="label">LinkedIn</div>
        <div class="value">
            <a href="www.linkedin.com/in/harsh-mishra2k7" target="_blank">
                View My LinkedIn Profile
            </a>
        </div>
    </div>

    <a class="back" href="index.jsp">
        ← Back to Home
    </a>

</div>

</body>
</html>