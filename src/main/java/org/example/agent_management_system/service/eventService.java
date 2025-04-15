package org.example.agent_management_system.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import java.util.List;

public class eventService {
    public static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(model.Event.class).buildSessionFactory();
    }

    public static List<model.Event> getEvents() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<model.Event> events = session.createQuery("from Event", model.Event.class).getResultList();
        transaction.commit();
        return events;
    }
}
