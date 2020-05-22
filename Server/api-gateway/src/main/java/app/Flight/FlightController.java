package app.Flight;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
public class FlightController {
    @Autowired
    FlightClient flightClient;

    @GetMapping("/flights")
    public String getAllFlights() {
        return flightClient.getAllFlights();
    }

    @PostMapping("/flights")
    public Boolean addFlight(@RequestBody
                             @RequestParam(value = "name_form", required = true) String name_from,
                             @RequestParam(value = "name_to", required = true) String name_to,
                             @RequestParam(value = "date_from", required = true) Date date_from,
                             @RequestParam(value = "date_to", required = true) Date date_to,
                             @RequestParam(value = "plane_id", required = true) Integer plane_id) {
        return flightClient.addFlight(name_from, name_to, date_from, date_to, plane_id);
    }

    @PutMapping("/flights")
    public Boolean editFlight(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                              @RequestParam(value = "name_form", required = true) String name_from,
                              @RequestParam(value = "name_to", required = true) String name_to,
                              @RequestParam(value = "date_from", required = true) Date date_from,
                              @RequestParam(value = "date_to", required = true) Date date_to,
                              @RequestParam(value = "plane_id", required = true) Integer plane_id) {
        return flightClient.editFlight(id, name_from, name_to, date_from, date_to, plane_id);
    }

    @DeleteMapping("/flights")
    public Boolean deleteFlight(@RequestParam(value = "id", required = true) Integer id) {
        return flightClient.deleteFlight(id);
    }
}
