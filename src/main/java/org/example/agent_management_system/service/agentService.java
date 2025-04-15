package org.example.agent_management_system.service;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import java.util.List;



public class agentService {
    private static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(model.Agent.class).buildSessionFactory();
    }

    public static void saveAgents(model.Agent agent) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        session.persist(agent);
        transaction.commit();
    }

    public static String loginAgent(String username, String password) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from Agent where username = :username");
        query.setParameter("username", username);
        model.Agent student = (model.Agent) query.uniqueResult();
        if (student == null) {
            return "kindly register yourself";
        }

        if (!password.equals(student.getPassword())) {
            return "incorrect password";
        }
        transaction.commit();
        return "success";
    }

    public static model.Agent getAgent(String username) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from Agent where username = :username");
        query.setParameter("username", username);
        model.Agent agent = (model.Agent) query.uniqueResult();
        transaction.commit();
        return agent;
    }

    public static List<model.Agent> getAllAgents() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<model.Agent> agents = session.createQuery("from Agent", model.Agent.class).getResultList();
        transaction.commit();
        return agents;
    }

    public static model.Agent getStudentById(int StudentId) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        model.Agent student = session.get(model.Agent.class, StudentId);
        transaction.commit();
        return student;
    }

    public static void updateAgent(int id, String name, String username, String email) {
        Transaction transaction = null;
        try (Session session = factory.getCurrentSession()) {
            transaction = session.beginTransaction();
            model.Agent agent = session.get(model.Agent.class, id);
            if (agent != null) {
                agent.setName(name);
                agent.setEmail(email);
                agent.setUsername(username);
                session.merge(agent);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
        }
    }

    public static void deleteAgent(int agentId) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        model.Agent agent = session.get(model.Agent.class, agentId);
        session.remove(agent);
        transaction.commit();
    }
}
