package app.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {
    @Autowired
    UserClient userClient;

    @GetMapping("/auth")
    public String sign_in(@RequestParam(value = "login", required = true) String login,
                          @RequestParam(value = "password", required = true) String password) {
        return userClient.sign_in(login, password);
    }

    @PostMapping("/auth")
    public String sign_up(@RequestBody
                          @RequestParam(value = "login", required = true) String login,
                          @RequestParam(value = "password", required = true) String password,
                          @RequestParam(value = "name", required = true) String name,
                          @RequestParam(value = "surname", required = true) String surname,
                          @RequestParam(value = "passport", required = true) String passport) {
        return userClient.sign_up(login, password, name, surname, passport);
    }

    @PutMapping("/auth")
    public String editUser(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                           @RequestParam(value = "login", required = true) String login,
                           @RequestParam(value = "password", required = true) String password,
                           @RequestParam(value = "name", required = true) String name,
                           @RequestParam(value = "surname", required = true) String surname,
                           @RequestParam(value = "passport", required = true) String passport) {
        return userClient.editUser(id, login, password, name, surname, passport);
    }
}
