<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #1a202c;
            color: #f7fafc;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-size: cover;
        }

        .container {
            max-width: 420px;
            padding: 2.5rem;
            background-color: rgba(45, 55, 72, 0.85);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            border: 1px solid #4a5568;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: #f56565;
            font-size: 2rem;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
            color: #e2e8f0;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #4a5568;
            border-radius: 8px;
            background-color: #2d3748;
            color: white;
            font-size: 1rem;
        }

        .form-group input:focus {
            outline: none;
            border-color: #f56565;
            box-shadow: 0 0 8px rgba(245, 101, 101, 0.7);
            background-color: #3b475a;
        }

        .submit-btn {
            width: 100%;
            padding: 0.85rem;
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            background-color: #f56565;
            border: none;
            border-radius: 10px;
            transition: 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #e53e3e;
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(0, 0, 0, 0.4);
        }

        .submit-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Admin Login</h2>
    <form id="loginForm" onsubmit="login(event)">
        <input type="hidden" name="action" value="adminLogin"/>
        <div class="form-group">
            <label for="username">Admin Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Admin Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="submit-btn">Login</button>
    </form>
</div>

<script>
    function login(event) {
        event.preventDefault();
        const data = new FormData(document.getElementById("loginForm"));
        fetch("hello-servlet", {
            method: "POST",
            body: new URLSearchParams(data),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject(res);
            }
            return res.text()
        }).then((data) => {
            alert(data);
        });
    }
</script>
</body>
</html>
