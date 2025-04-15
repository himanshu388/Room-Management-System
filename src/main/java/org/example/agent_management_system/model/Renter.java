package org.example.agent_management_system.model;

import jakarta.persistence.*;

@Entity
@Table(name = "renters")
public class Renter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private String mobile;
    private String month;

    // Default constructor
    public Renter() {
    }

    // Parameterized constructor
    public Renter( String name, String mobile, String month) {
        this.name = name;
        this.mobile = mobile;
        this.month = month;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getter and Setter for mobile
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    // Getter and Setter for month
    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }
}
