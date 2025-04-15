package org.example.agent_management_system.service;

import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class adminService {
    private static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(model.Admin.class).buildSessionFactory();
    }

    public static void saveAdmin(model.Admin admin) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        session.persist(admin);
        transaction.commit();
    }

    public static String loginAdmin(String username, String password) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from Admin where admin_name = :username");
        query.setParameter("username", username);

        model.Admin admin = (model.Admin) query.uniqueResult();
        if (admin == null) {
            return "you are not registered as admin with us.. kindly register yourself";
        }

        if (!password.equals(admin.getAdmin_password())) {
            return "your password is incorrect";
        }
        transaction.commit();
        return "success";
    }

    public static model.Admin getAdminByUsername(String username) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from Admin where admin_name = :username");
        query.setParameter("username", username);
        model.Admin  admin = (model.Admin ) query.uniqueResult();
        transaction.commit();
        return admin;
    }
}
