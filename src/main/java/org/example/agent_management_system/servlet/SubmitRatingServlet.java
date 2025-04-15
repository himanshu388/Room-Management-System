package org.example.agent_management_system.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.example.agent_management_system.service.ratingService;
import model.Rating;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.IOException;

@WebServlet("/SubmitRatingServlet")
public class SubmitRatingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String renterName = request.getParameter("renterName");
        int ratingValue = Integer.parseInt(request.getParameter("rating"));

        // Create Rating object
        Rating newRating = new Rating();
        newRating.setRenterName(renterName);
        newRating.setRating(ratingValue);

        // Open a Hibernate session
        try (Session session = ratingService.factory.openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(newRating); // ✅ Use persist instead of save if needed
            tx.commit();
        } catch (Exception e) {
           
            response.getWriter().write("Error saving rating: " + e.getMessage());
            return;
        }

        // Redirect back to the ratings page
        response.sendRedirect("Ratings.jsp");
    }
}
