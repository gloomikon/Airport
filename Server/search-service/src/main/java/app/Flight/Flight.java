package app.Flight;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "flights")
@Data
public class Flight {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private String name_from;
    private String name_to;
    private Date from;
    private Date to;
    private Integer plane_id;

    public Flight(String name_from, String name_to, Date from, Date to, Integer plane_id) {
        this.name_from = name_from;
        this.name_to = name_to;
        this.from = from;
        this.to = to;
        this.plane_id = plane_id;
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

    public Date getFrom() {
        return from;
    }

    public void setFrom(Date from) {
        this.from = from;
    }

    public Date getTo() {
        return to;
    }

    public void setTo(Date to) {
        this.to = to;
    }

    public Integer getPlane_id() {
        return plane_id;
    }

    public void setPlane_id(Integer plane_id) {
        this.plane_id = plane_id;
    }
}
