package app.Ticket;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(value = "ticket-service")
public interface TicketClient {
    @GetMapping("/tickets")
    String getByUserId(@RequestParam(value = "userId", required = false) Integer userId);

    @PostMapping("/tickets")
    Boolean addTicket(@RequestBody @RequestParam(value = "userId", required = true) Integer userId,
                             @RequestParam(value = "placeId", required = true) Integer placeId,
                             @RequestParam(value = "flightId", required = true) Integer flightId);

    @DeleteMapping("/tickets")
    Boolean deleteTicket(@RequestParam(value = "id", required = true) Integer id);
}
