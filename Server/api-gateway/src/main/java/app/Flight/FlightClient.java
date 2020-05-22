package app.Flight;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@FeignClient(value = "search-service")
public interface FlightClient {
    @GetMapping("/flights")
    public String getAllFlights();

    @PostMapping("/flights")
    public Boolean addFlight(@RequestBody
                             @RequestParam(value = "name_form", required = true) String name_from,
                             @RequestParam(value = "name_to", required = true) String name_to,
                             @RequestParam(value = "date_from", required = true) Date date_from,
                             @RequestParam(value = "date_to", required = true) Date date_to,
                             @RequestParam(value = "plane_id", required = true) Integer plane_id);

    @PutMapping("/flights")
    public Boolean editFlight(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                              @RequestParam(value = "name_form", required = true) String name_from,
                              @RequestParam(value = "name_to", required = true) String name_to,
                              @RequestParam(value = "date_from", required = true) Date date_from,
                              @RequestParam(value = "date_to", required = true) Date date_to,
                              @RequestParam(value = "plane_id", required = true) Integer plane_id);

    @DeleteMapping("/flights")
    public Boolean deleteFlight(@RequestParam(value = "id", required = true) Integer id);
}
