package app.Flight;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "flights")
@Data
public class Flight {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private String name_from;
    private String name_to;
    private String date_from;
    private String date_to;
    private Integer planeId;

    public Flight(String name_from, String name_to, String date_from, String date_to, Integer planeId) {
        this.name_from = name_from;
        this.name_to = name_to;
        this.date_from = date_from;
        this.date_to = date_to;
        this.planeId = planeId;
    }

    public Flight() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName_from() {
        return name_from;
    }

    public void setName_from(String name_from) {
        this.name_from = name_from;
    }

    public String getName_to() {
        return name_to;
    }

    public void setName_to(String name_to) {
        this.name_to = name_to;
    }

    public String getFrom() {
        return date_from;
    }

    public void setFrom(String from) {
        this.date_from = from;
    }

    public String getTo() {
        return date_to;
    }

    public void setTo(String to) {
        this.date_to = to;
    }

    public Integer getPlaneId() {
        return planeId;
    }

    public void setPlaneId(Integer planeId) {
        this.planeId = planeId;
    }
}
