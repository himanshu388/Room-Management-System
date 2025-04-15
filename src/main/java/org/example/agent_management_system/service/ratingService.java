package org.example.agent_management_system.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Transaction;

import java.util.List;


public class ratingService {
    public static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(model.Rating.class).buildSessionFactory();

    }

    public static List<model.Rating> getAllRatings() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<model.Rating> ratingList = session.createQuery("from Rating", model.Rating.class).getResultList();
        transaction.commit();
        session.close(); // 🔁 add this
        return ratingList;
    }
}
