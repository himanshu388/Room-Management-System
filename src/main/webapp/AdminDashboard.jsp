<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%
    HttpSession sessionObj = request.getSession();
    @SuppressWarnings("unchecked")
    List<model.Agent> agents = (sessionObj != null) ? (List<model.Agent>) sessionObj.getAttribute("agentList") : null;
    model.Admin admin = (sessionObj != null) ? (model.Admin) sessionObj.getAttribute("LoggedInAdmin") : null;

    if (agents == null) {
        response.sendRedirect("dashboard.jsp?error=No agents found");
        return;
    }

    if (admin == null) {
        response.sendRedirect("dashboard.jsp?error=No admin found");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Agent Management - Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-800 p-6">
<div id="Agent_container" class="max-w-5xl mx-auto bg-gray-900 rounded-lg shadow-md p-8 border border-gray-700">
    <div class="mb-6 flex items-center gap-4">
        <img src="./download.jpg" alt="Admin Profile" class="rounded-full h-20 w-20 border-2 border-gray-700">
        <div>
            <h2 class="text-2xl font-semibold text-blue-300 mb-2">Admin Details</h2>
        </div>
    </div>

    <div class="mb-6">
        <div class="table-container overflow-x-auto">
            <table class="min-w-full bg-gray-800 rounded-lg shadow-md border border-gray-700">
                <thead class="bg-gray-700">
                <tr>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">ID</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Admin Name</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Admin Email</th>
                </tr>
                </thead>
                <tbody class="bg-gray-800">
                <tr class="hover:bg-gray-700 transition duration-300 ease-in-out">
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= admin.getAdmin_id()%></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= admin.getAdmin_name() %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= admin.getAdmin_email() %></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="mb-8">
        <h2 class="text-2xl font-semibold text-blue-300 mb-4">Registered Agents</h2>
        <div class="table-container overflow-x-auto">
            <table class="min-w-full bg-gray-800 rounded-lg shadow-md border border-gray-700">
                <thead class="bg-gray-700">
                <tr>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">ID</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Name</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Email</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Username</th>
                    <th class="px-6 py-4 text-left text-xs font-medium text-gray-300 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-gray-800">
                <% if (agents != null) { %>
                <% for (model.Agent agent : agents) { %>
                <tr class="hover:bg-gray-700 transition duration-300 ease-in-out">
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= agent.getId() %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= agent.getName() %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= agent.getEmail() %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white"><%= agent.getUsername() %></td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-white flex space-x-2">
                        <button title="Edit Agent" data-bs-toggle="modal" data-bs-target="#updateStudentModal"
                                onclick="populateModal('<%= agent.getId()%>', '<%= agent.getName() %>', '<%= agent.getUsername() %>', '<%= agent.getEmail() %>')"
                                class="bg-yellow-500 hover:bg-yellow-600 text-white font-semibold py-2 px-4 rounded-md shadow-md transition duration-300 ease-in-out text-xs">
                            Edit
                        </button>
                        <button title="Delete Agent" data-bs-toggle="modal" data-bs-target="#deleteStudentModal"
                                onclick="populateDeleteModal('<%= agent.getId() %>')"
                                class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-4 rounded-md shadow-md transition duration-300 ease-in-out text-xs">
                            Delete
                        </button>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="5" class="px-6 py-4 text-white text-center">No agents found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <form id="logoutForm" onsubmit="logout(event)" class="text-center">
        <input type="hidden" name="action" value="adminLogout">
        <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-6 rounded-md shadow-md transition duration-300 ease-in-out">
            Logout
        </button>
    </form>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateStudentModal" tabindex="-1" aria-labelledby="updateStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-gray-800 border border-gray-700">
            <div class="modal-header bg-gray-700 border-b border-gray-600">
                <h5 class="modal-title text-blue-300">Update Agent</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="updateAgentForm" onsubmit="updateAgent(event)" class="p-4">
                    <input type="hidden" id="agentId" name="agentId">
                    <div class="mb-3">
                        <label class="text-white block mb-1">Name</label>
                        <input type="text" id="agentName" name="name" class="w-full p-2 rounded bg-gray-700 text-white" required>
                    </div>
                    <div class="mb-3">
                        <label class="text-white block mb-1">Username</label>
                        <input type="text" id="agentUsername" name="username" class="w-full p-2 rounded bg-gray-700 text-white" required>
                    </div>
                    <div class="mb-3">
                        <label class="text-white block mb-1">Email</label>
                        <input type="email" id="agentEmail" name="email" class="w-full p-2 rounded bg-gray-700 text-white" required>
                    </div>
                    <input type="hidden" name="action" value="updateAgent">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white w-full py-2 rounded">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteStudentModal" tabindex="-1" aria-labelledby="deleteStudentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-gray-800 border border-gray-700">
            <div class="modal-header bg-red-700 border-b border-red-600">
                <h5 class="modal-title text-red-300">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="text-gray-300">Are you sure you want to delete this agent?</p>
                <form id="deleteAgentForm" onsubmit="deleteAgent(event)" class="mt-3">
                    <input type="hidden" id="deleteAgentId" name="agentId">
                    <input type="hidden" name="action" value="deleteAgent">
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white w-full py-2 rounded">Confirm Delete</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function populateModal(id, name, username, email) {
        document.getElementById('agentId').value = id;
        document.getElementById('agentName').value = name;
        document.getElementById('agentUsername').value = username;
        document.getElementById('agentEmail').value = email;
    }

    function populateDeleteModal(id) {
        document.getElementById('deleteAgentId').value = id;
    }

    function updateAgent(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('updateAgentForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).then(res => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected");
            }
            return res.text();
        }).then(alert);
    }

    function deleteAgent(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('deleteAgentForm'));
        fetch("hello-servlet", {
            method: 'POST',
            body: new URLSearchParams(form),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).then(res => {
            if (res.redirected) {
                window.location.href = res.url;
                return Promise.reject("Redirected");
            }
            return res.text();
        }).then(alert);
    }

    function logout(event) {
        event.preventDefault();
        const data = new FormData(document.getElementById("logoutForm"));
        fetch("hello-servlet", {
            method: "POST",
            body: new URLSearchParams(data),
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }).then(res => {
            if (res.redirected) {
                window.location.href = res.url;
            }
        });
    }
</script>
</body>
</html>
