<%--
  Created by IntelliJ IDEA.
  User: HELLO
  Date: 07-04-2025
  Time: 01:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }

        .container {
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 350px;
            text-align: center;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background: blue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Room Management System</h2>
    <h2><u>Register</u></h2>
    <form id="registerForm" onsubmit="register(event)">
        <input type="text" name="action" value="register" hidden>
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="text" name="username" placeholder="Username" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Register Now</button>
    </form>
    <p>Already have an account? <a href="index.jsp">Login here</a></p>
</div>

<script>
    function register(event) {
        event.preventDefault();
        const form = new FormData(document.querySelector('#registerForm'));
        fetch("hello-servlet" , {
            method : 'POST',
            body: new URLSearchParams(form),
            headers:{
                'Content-Type':'application/x-www-form-urlencoded'
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected")
            }
            return res.text()
        }).then(data => {
            alert(data)
        })
    }
</script>
</body>
</html>
