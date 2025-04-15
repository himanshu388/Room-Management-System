<%--
  Created by IntelliJ IDEA.
  User: HELLO
  Date: 07-04-2025
  Time: 01:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    model.Agent loggedInAgent = (sessionObj != null) ? (model.Agent) sessionObj.getAttribute("loggedInAgent") : null;

    if (loggedInAgent == null) {
        response.sendRedirect("index.jsp?error=Please login first");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Agent Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #1a202c; /* Dark background */
            margin: 0;
            padding: 0;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #2d3748; /* Darker navbar */
            padding: 1rem 2rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); /* Darker shadow */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        .navbar-brand {
            color: #f56565; /* Vibrant red/pink */
            font-size: 1.5rem;
            font-weight: 600;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            margin-left: auto;
            padding: 0;
        }

        .nav-item {
            margin-left: 1.5rem;
        }

        .nav-link {
            color: #cbd5e0; /* Light gray text */
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #f56565; /* Brighter hover color */
        }

        /* Dashboard Container Styles */
        .dashboard-container {
            background-color: #2d3748; /* Dark container */
            padding: 2rem;
            margin: 70px auto 2rem;
            max-width: 900px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Darker shadow */
            text-align: center;
            animation: fadeIn 0.5s ease-out;
            border: 1px solid #4a5568; /* Darker border */
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

        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1.5rem;
            border: 5px solid #f56565; /* Pink border */
            animation: pulse 2s infinite alternate;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            100% {
                transform: scale(1.05);
            }
        }

        h2 {
            color: #fff;
            margin-bottom: 1rem;
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        u {
            text-decoration-color: #f56565; /* Pink underline */
            text-underline-offset: 8px;
        }

        p {
            color: #cbd5e0;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .dashboard-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .card {
            background-color: #374151; /* Darker card */
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3); /* Darker shadow */
            text-align: center;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            border: 1px solid #4a5568; /* Darker border */
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.4); /* Increased hover shadow */
        }

        .card h5 {
            color: #f56565; /* Pink title */
            margin-bottom: 0.75rem;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .card p {
            color: #cbd5e0;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: #f56565; /* Pink button */
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1rem;
            transition: background-color 0.3s ease;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.2); /* Darker shadow */
            margin-top: 1rem;
        }

        .btn-primary:hover {
            background-color: #e53e3e; /* Darker pink hover */
        }

        .modal-content {
            border-radius: 12px !important;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4); /* Darker modal shadow */
            animation: modalFadeIn 0.3s ease-out;
            background-color: #374151; /* Darker modal background */
            border: 1px solid #4a5568; /* Darker border */
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .modal-header {
            border-bottom: 1px solid #4a5568; /* Darker border */
            padding: 1.25rem 1.5rem;
        }

        .modal-title {
            font-size: 1.4rem;
            color: #fff;
            font-weight: 600;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            color: #cbd5e0;
            display: block;
            margin-bottom: 0.75rem;
            font-size: 1.1rem;
        }

        .form-select,
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #4a5568; /* Darker border */
            border-radius: 8px !important;
            margin-bottom: 1.25rem;
            font-size: 1.1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: #4a5568; /* Darker input background */
            color: #fff;
        }

        .form-control:focus,
        .form-select:focus {
            outline: none;
            border-color: #f56565; /* Pink focus border */
            box-shadow: 0 0 5px rgba(245, 101, 101, 0.5); /* Pink focus shadow */
        }

        .modal-footer {
            border-top: 1px solid #4a5568; /* Darker border */
            padding: 1.25rem 1.5rem;
            display: flex;
            justify-content: flex-end;
        }

        .btn-danger {
            background-color: #D32F2F;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1rem;
            transition: background-color 0.3s ease;
            box-shadow: 0 3px 7px rgba(0, 0, 0, 0.2);
            min-width: 150px;
            margin-top: 1rem;
        }

        .btn-danger:hover {
            background-color: #C71C1C;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                margin-top: 60px;
                padding: 1.5rem;
            }

            .navbar-nav {
                flex-direction: column;
                align-items: center;
            }

            .nav-item {
                margin-left: 0;
                margin-top: 1rem;
            }

            .dashboard-links {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="navbar-brand">My Dashboard</div>
   <ul class="navbar-nav">
    <li class="nav-item"><a href="dashboard.jsp" class="nav-link">Home</a></li>
    <li class="nav-item"><a href="Renters.jsp" class="nav-link">Renters</a></li>
    <li class="nav-item"><a href="Ratings.jsp" class="nav-link">Ratings</a></li>
    <li class="nav-item"><a href="Events.jsp" class="nav-link">Events</a></li>
</ul>

</nav>

<div class="dashboard-container gap-2">
    <img width="394" height="394" src="./download.jpg" alt="Student Profile" class="profile-pic ">

    <u><h2>Welcome, <%= loggedInAgent.getName()%>
    </h2></u>
    <p><strong>Student_ID:</strong> <%= loggedInAgent.getId() %>
    </p>
    <p><strong>Email:</strong> <%= loggedInAgent.getEmail() %>
    </p>

    <div style="display: flex; justify-content: center; gap: 20px; margin-top: 40px;">
        <form id="logoutForm" onsubmit="logout(event)" style="margin: 0;">
            <input type="text" name="action" value="logout" hidden>
            <button type="submit" class="btn btn-danger">
                Logout
            </button>
        </form>
    </div>

    <div class="dashboard-links">
        <div class="card">
            <h5>Get All Renters</h5>
            <p>Manage All Renters at once </p>
            <form id="courseForm" onsubmit="openAddCourse(event)">
                <input type="text" name="action" value="getAllRenters" hidden>
                <button type="submit" class="btn btn-primary">Go to Renters</button>
            </form>
        </div>
        <div class="card">
            <h5>Rating of Renter</h5>
            <p>Check all renter's rating.</p>
            <form id="gradeForm" onsubmit="openGrade(event)">
                <input type="text" name="action" value="getRatings" hidden>
                <button type=submit class="btn btn-primary">View Ratings</button>
            </form>
        </div>
        <div class="card">
            <h5>? Upcoming Events</h5>
            <p>Check your schedule and events.</p>
            <form id="eventForm" onsubmit="openEvent(event)">
                <input type="text" name="action" value="getEvents" hidden>
                <button type="submit" class="btn btn-primary">View Events</button>
            </form>
        </div>
    </div>

<%--    <div class="modal fade" id="complaintModal" tabindex="-1" aria-labelledby="complaintModalLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <form id="complaintForm" onsubmit="submitComplaint(event)">--%>
<%--                    <div class="modal-header">--%>
<%--                        <h5 class="modal-title" id="complaintModalLabel">Raise a Complaint</h5>--%>
<%--                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                    </div>--%>
<%--                    <div class="modal-body">--%>
<%--                        <div class="mb-3">--%>
<%--                            <input type="text" name="id" value="<%=""%> hidden>--%>
<%--                                <label for=" category" class="form-label">Category</label>--%>
<%--                            <select class="form-select" name="category" id="category" required>--%>
<%--                                <option value="">-- Select --</option>--%>
<%--                                <option value="Update Details">Update Details</option>--%>
<%--                                <option value="Delete Account">Delete Account</option>--%>
<%--                                <option value="Other">Other</option>--%>
<%--                            </select>--%>
<%--                        </div>--%>
<%--                        <div class="mb-3">--%>
<%--                            <label for="message" class="form-label">Your Message</label>--%>
<%--                            <textarea class="form-control" name="message" id="message" rows="4" required></textarea>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <input type="hidden" name="action" value="submitComplaint"/>--%>
<%--                        <button type="submit" class="btn btn-primary w-100">--%>
<%--                            Submit Complaint--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    function logout(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('logoutForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: {
                "content-type": "application/x-www-form-urlencoded"
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected")
            }
            return res.text()
        }).then((data) => {
            alert(data);
        })
    }

    function openAddCourse(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('courseForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected")
            }
        }).then((data) => {
            alert(data);
        })
    }

    function openGrade(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('gradeForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected")
            }
        }).then((data) => {
            alert(data);
        })
    }

    function openEvent(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('eventForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).then((res) => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected")
            }
        }).then((data) => {
            alert(data);
        })
    }

    function submitComplaint(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('complaintForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).then(res => res.text()).then((data) => {
            alert(data);
            window.location.href = "dashboard.jsp";
        })

    }

</script>
</body>
</html>
