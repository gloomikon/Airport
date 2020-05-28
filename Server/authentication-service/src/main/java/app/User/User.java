package app.User;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "users")
@Data
public class User {
    @Id @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private String login;
    private String password;
    private String name;
    private String surname;
    private String passport;

    public User() {
    }

    public User(String login, String password, String name, String surname, String passport) {
        this.login = login;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.passport = passport;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPassport() {
        return passport;
    }

    public void setPassport(String passport) {
        this.passport = passport;
    }

}
