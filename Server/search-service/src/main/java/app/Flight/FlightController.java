package app.Flight;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class FlightController {
    @Autowired
    FlightRepository flightRepository;

    @GetMapping("/flights")
    public String getAllFlights() {
        List<Flight> resultList = new ArrayList<>();
        Iterable<Flight> result = flightRepository.findAll();
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/flights")
    public Boolean addFlight(@RequestBody
                                @RequestParam(value = "name_form", required = true) String name_from,
                                @RequestParam(value = "name_to", required = true) String name_to,
                                @RequestParam(value = "date_from", required = true) Date date_from,
                                @RequestParam(value = "date_to", required = true) Date date_to,
                                @RequestParam(value = "plane_id", required = true) Integer plane_id) {
        try {
            Flight flight = new Flight(name_from, name_to, date_from, date_to, plane_id);
            flightRepository.save(flight);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @PutMapping("/flights")
    public Boolean editFlight(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "name_form", required = true) String name_from,
                             @RequestParam(value = "name_to", required = true) String name_to,
                             @RequestParam(value = "date_from", required = true) Date date_from,
                             @RequestParam(value = "date_to", required = true) Date date_to,
                             @RequestParam(value = "plane_id", required = true) Integer plane_id) {
        try {
            Optional<Flight> test = flightRepository.findById(id);
            if (!test.isPresent())
                return false;
            Flight flight = new Flight(name_from, name_to, date_from, date_to, plane_id);
            flightRepository.save(flight);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/flights")
    public Boolean deleteFlight(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Flight> test = flightRepository.findById(id);
            if (!test.isPresent())
                return false;
            flightRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
