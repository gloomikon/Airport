package app.User;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class UserController {
    @Autowired
    UserRepository userRepository;

    @GetMapping("/auth")
    public String sign_in(@RequestParam(value = "username", required = true) String username,
                              @RequestParam(value = "password", required = true) String password) {

        List<User> resultList = new ArrayList<>();
        Optional<User> user = userRepository.findByLogin(username);
        if (user.isPresent() && user.get().getPassword().equals(password)) {
            resultList.add(user.get());
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/auth")
    public String sign_up(@RequestBody
                                          @RequestParam(value = "login", required = true) String login,
                                          @RequestParam(value = "password", required = true) String password,
                                          @RequestParam(value = "name", required = true) String name,
                                          @RequestParam(value = "surname", required = true) String surname,
                                          @RequestParam(value = "passport", required = true) String passport) {
        List<User> resultList = new ArrayList<>();
        Optional<User> test = userRepository.findByLogin(login);
        if (test.isPresent()) {
            return "{}";
        }
        User user = new User();
        user.setLogin(login);
        user.setPassword(password);
        user.setName(name);
        user.setSurname(surname);
        user.setPassport(passport);
        userRepository.save(user);
        resultList.add(user);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PutMapping("/auth")
    public String editUser(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                          @RequestParam(value = "login", required = true) String login,
                          @RequestParam(value = "password", required = true) String password,
                          @RequestParam(value = "name", required = true) String name,
                          @RequestParam(value = "surname", required = true) String surname,
                          @RequestParam(value = "passport", required = true) String passport) {
        List<User> resultList = new ArrayList<>();
        Optional<User> test = userRepository.findById(id);
        if (!test.isPresent()) {
            return "{}";
        }
        User user = test.get();
        user.setLogin(login);
        user.setPassword(password);
        user.setName(name);
        user.setSurname(surname);
        user.setPassport(passport);
        userRepository.save(user);
        resultList.add(user);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }



}