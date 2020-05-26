package app.Plane;

import lombok.Data;

import javax.persistence.*;


@Entity
@Table(name = "planes")
@Data
public class Plane {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private String name;
    private Integer companyId;
    private Integer capacity;

    public Plane(String name, Integer companyId, Integer capacity) {
        this.name = name;
        this.companyId = companyId;
        this.capacity = capacity;
    }

    public Plane() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }
}
