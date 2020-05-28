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
    public String sign_in(@RequestParam(value = "username", required = true) String username,
                        @RequestParam(value = "password", required = true) String password) {
        return userClient.sign_in(username, password);
    }

    @PostMapping("/auth")
    public ResponseEntity<String> sign_up(@RequestBody
                                          @RequestParam(value = "login", required = true) String login,
                                          @RequestParam(value = "password", required = true) String password,
                                          @RequestParam(value = "name", required = true) String name,
                                          @RequestParam(value = "surname", required = true) String surname,
                                          @RequestParam(value = "passport", required = true) String passport) {
        return userClient.sign_up(login, password, name, surname, passport);
    }
}
