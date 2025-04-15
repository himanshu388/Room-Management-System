package model;

import jakarta.persistence.*;

@Entity
@Table(name = "ratings")
public class Rating {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String renterName;
    private int rating;

    // Default constructor
    public Rating() {
    }

    // Parameterized constructor
    public Rating(int id, String renterName, int rating) {
        this.id = id;
        this.renterName = renterName;
        this.rating = rating;
    }

    // Getter and Setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for renterName
    public String getRenterName() {
        return renterName;
    }

    public void setRenterName(String renterName) {
        this.renterName = renterName;
    }

    // Getter and Setter for rating
    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}
