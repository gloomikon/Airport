package app.Ticket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class TicketController {
    @Autowired
    TicketClient ticketClient;

    @GetMapping("/tickets")
    String getByUserId(@RequestParam(value = "userId", required = false) String userId) {
        return ticketClient.getByUserId(userId);
    }

    @PostMapping("/tickets")
    Boolean addTicket(@RequestBody @RequestParam(value = "userId", required = true) Integer userId,
                      @RequestParam(value = "placeId", required = true) Integer placeId,
                      @RequestParam(value = "flightId", required = true) Integer flightId) {
        return ticketClient.addTicket(userId, placeId, flightId);
    }

    @DeleteMapping("/tickets")
    Boolean deleteTicket(@RequestParam(value = "id", required = true) Integer id) {
        return ticketClient.deleteTicket(id);
    }
}
