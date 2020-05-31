package app.User;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@FeignClient(value = "authentication-service")
public interface UserClient {

    @GetMapping("/auth")
    public String sign_in(@RequestParam(value = "username", required = true) String username,
                          @RequestParam(value = "password", required = true) String password);

    @PostMapping("/auth")
    public String sign_up(@RequestBody
                          @RequestParam(value = "login", required = true) String login,
                          @RequestParam(value = "password", required = true) String password,
                          @RequestParam(value = "name", required = true) String name,
                          @RequestParam(value = "surname", required = true) String surname,
                          @RequestParam(value = "passport", required = true) String passport);
}
