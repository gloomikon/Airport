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
                             @RequestParam(value = "name_from", required = true) String name_from,
                             @RequestParam(value = "name_to", required = true) String name_to,
                             @RequestParam(value = "date_from", required = true) String date_from,
                             @RequestParam(value = "date_to", required = true) String date_to,
                             @RequestParam(value = "planeId", required = true) Integer planeId);

    @PutMapping("/flights")
    public Boolean editFlight(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                              @RequestParam(value = "name_from", required = true) String name_from,
                              @RequestParam(value = "name_to", required = true) String name_to,
                              @RequestParam(value = "date_from", required = true) String date_from,
                              @RequestParam(value = "date_to", required = true) String date_to,
                              @RequestParam(value = "planeId", required = true) Integer planeId);

    @DeleteMapping("/flights")
    public Boolean deleteFlight(@RequestParam(value = "id", required = true) Integer id);
}
