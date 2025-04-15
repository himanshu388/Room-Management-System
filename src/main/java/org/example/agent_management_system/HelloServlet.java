package org.example.agent_management_system;
import org.example.agent_management_system.model.Renter;
import org.example.agent_management_system.service.agentService;
import org.example.agent_management_system.service.adminService;
import org.example.agent_management_system.service.eventService;
import org.example.agent_management_system.service.ratingService;
import org.example.agent_management_system.service.renterService;
import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {
    public void init() {
        System.out.println("Hello Servlet");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<model.Agent> studentList = agentService.getAllAgents();
        HttpSession session = request.getSession();
        session.setAttribute("studentList", studentList);
        response.sendRedirect("listStudents.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        System.out.println("action: " + action);
        if (action.equals("register")) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = (req.getParameter("password"));
            String username = req.getParameter("username");

            model.Agent  student = new model.Agent(name, username, email, password);
            agentService.saveAgents(student);
            resp.getWriter().write("you have successfully registered!");
            resp.sendRedirect("index.jsp");
        }

        if (action.equals("login")) {
            String login_username = req.getParameter("username");
            String login_password = req.getParameter("password");
            String isTrue = agentService.loginAgent(login_username, login_password);
            if (isTrue.equals("success")) {
                HttpSession session = req.getSession();
                model.Agent loggedInAgent = agentService.getAgent(login_username);
                session.setAttribute("loggedInAgent", loggedInAgent);
                resp.sendRedirect("dashboard.jsp");
            } else {
                resp.getWriter().write(isTrue);
            }
        }

        if (action.equals("updateAgent")) {
            int id = Integer.parseInt(req.getParameter("id").trim());
            String name = req.getParameter("name");
            String username = req.getParameter("username");
            String email = req.getParameter("email");

            agentService.updateAgent(id, name, username, email);

            HttpSession session = req.getSession();
            List<model.Agent> agentList = agentService.getAllAgents();
            session.setAttribute("agentList", agentList);
            resp.getWriter().write("Agents updated successfully!");
            resp.sendRedirect("AdminDashboard.jsp");
        }

        if (action.equals("deleteAgent")) {
            int id = Integer.parseInt(req.getParameter("agentId").trim());
            agentService.deleteAgent(id);
            HttpSession session = req.getSession();
            List< model.Agent > agentList = agentService.getAllAgents();
            session.setAttribute("agentList", agentList);
            resp.getWriter().write("successfully deleted!");
            resp.sendRedirect("AdminDashboard.jsp");

        }

        if (action.equals("logout")) {
            HttpSession session = req.getSession(false);
            session.invalidate();
            resp.getWriter().write("You have successfully logged out!");
            resp.sendRedirect("index.jsp");
        }

        if (action.equals("adminLogin")) {

            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String isTrue = adminService.loginAdmin(username, password);
            if (isTrue.equals("success")) {
                HttpSession session = req.getSession();
                model.Admin LoggedInAdmin = adminService.getAdminByUsername(username);
                List<model.Agent> agentList = agentService.getAllAgents();
                session.setAttribute("LoggedInAdmin", LoggedInAdmin);
                session.setAttribute("agentList", agentList);
                resp.sendRedirect("AdminDashboard.jsp");
            } else {
                resp.getWriter().write(isTrue);
            }
        }

        if (action.equals("adminLogout")) {
            HttpSession session = req.getSession();
            session.invalidate();
            resp.sendRedirect("index.jsp");
        }

        if (action.equals("getAllRenters")) {
            List<Renter> renters = renterService.getAllRenters();
            HttpSession session = req.getSession();
            session.setAttribute("renters", renters);
            resp.sendRedirect("Renters.jsp");
        }

        if (action.equals("getRatings")) {
            List<model.Rating> ratings = ratingService.getAllRatings();
            HttpSession session = req.getSession();
            session.setAttribute("ratings", ratings);
            resp.sendRedirect("Ratings.jsp");
        }

        if (action.equals("getEvents")) {
            List<model.Event> events = eventService.getEvents();
            HttpSession session = req.getSession();
            session.setAttribute("events", events);
            resp.sendRedirect("Events.jsp");
        }

    }

    public void destroy() {
        System.out.println("Servlet is being destroyed...");
    }
}