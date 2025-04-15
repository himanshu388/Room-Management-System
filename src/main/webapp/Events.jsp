<%--
  Created by IntelliJ IDEA.
  User: HELLO
  Date: 07-04-2025
  Time: 02:39
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%

    HttpSession sessionObj = request.getSession();
    @SuppressWarnings("unchecked")
    List<model.Event> events = (List<model.Event>) sessionObj.getAttribute("events");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Upcoming Events</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #1a202c;
            color: #f7fafc;
            margin: 0;
            padding: 0;
            background-size: cover;
            animation: animateBackground 20s linear infinite;
            position: relative;
            overflow: hidden;
        }

        @keyframes animateBackground {
            0% { background-position: 0 0; }
            100% { background-position: 100% 0; }
        

        /* Dots Styles */
        .dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.6);
            position: absolute;
            animation: blink 1.5s infinite;
            z-index: 0;
        }

        @keyframes blink {
            0% { opacity: 0; }
            50% { opacity: 1; }
            100% { opacity: 0; }
        }

        .container {
            max-width: 800px;
            margin: 5rem auto;
            padding: 2rem;
            background-color: rgba(45, 55, 72, 0.8);
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid #4a5568;
            position: relative;
            z-index: 1;
        }

        h2 {
            color: #f56565;
            text-align: center;
            margin-bottom: 2rem;
            font-weight: 600;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: 1px solid #4a5568;
        }

        .table thead th {
            background-color: rgba(74, 85, 104, 0.7);
            color: #fff;
            padding: 1.2rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #718096;
            transition: background-color 0.3s ease;
        }

        .table thead th:hover {
            background-color: rgba(74, 85, 104, 0.9);
        }

        .table tbody tr {
            transition: background-color 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.08);
        }

        .table td {
            padding: 1.2rem;
            text-align: left;
            border-bottom: 1px solid #4a5568;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .table-bordered {
            border: 1px solid #4a5568;
        }

        .table-bordered thead th,
        .table-bordered td {
            border: 1px solid #4a5568;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(255, 255, 255, 0.03);
        }

        .table-striped tbody tr:nth-of-type(even) {
            background-color: transparent;
        }

        @media (max-width: 768px) {
            .container {
                margin-top: 4rem;
                padding: 1.5rem;
            }

            .table thead {
                display: none;
            }

            .table td {
                display: block;
                text-align: right;
            }

            .table td:before {
                content: attr(data-label);
                float: left;
                font-weight: bold;
                color: #f56565;
            }
        }

        .no-ratings {
            padding: 1rem;
            text-align: center;
            color: #cbd5e0;
            font-style: italic;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center text-white">Upcoming Events</h2>
    <table class="table table-bordered table-striped mt-4">
        <thead>
        <tr>
            <th>ID</th>
            <th>Event Name</th>
            <th>Location</th>
            <th>Date</th>
        </tr>
        </thead>
        <tbody>
        <% if (events == null || events.isEmpty()) { %>
        <tr>
            <td colspan="4" class="no-ratings">No upcoming events.</td>
        </tr>
        <% } else {
            for (model.Event event : events) { %>
        <tr>
            <td data-label="ID"><%= event.getId() %></td>
            <td data-label="Event Name"><%= event.getEventName() %></td>
            <td data-label="Location"><%= event.getLocation() %></td>
            <td data-label="Date"><%= event.getDate() %></td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Create dots
    const numDots = 50;
    const body = document.querySelector('body');
    for (let i = 0; i < numDots; i++) {
        const dot = document.createElement('div');
        dot.classList.add('dot');
        dot.style.left = `${Math.random() * 100}vw`;
        dot.style.top = `${Math.random() * 100}vh`;
        dot.style.animationDelay = `${Math.random() * 2}s`;
        body.appendChild(dot);
    }
</script>

</body>
</html>
