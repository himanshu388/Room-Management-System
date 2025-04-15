package org.example.agent_management_system.service;

import org.example.agent_management_system.model.Renter;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;


public class renterService {
    public static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(Renter.class).buildSessionFactory();

    }

    public static List<Renter> getAllRenters() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<Renter> renterList = session.createQuery("from Renter", Renter.class).getResultList();
        transaction.commit();
        return renterList;
    }
}
