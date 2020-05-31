package app.Ticket;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequestMapping
@RestController
public class TicketController {
    @Autowired
    TicketRepository ticketRepository;

    @GetMapping("/tickets")
    public String getByUserId(@RequestParam(value = "userId", required = true) String userId) {
        List<Ticket> resultList = new ArrayList<>();
        Iterable<Ticket> result = ticketRepository.findByUserId(userId);
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/tickets")
    public Boolean addTicket(@RequestBody @RequestParam(value = "userId", required = true) Integer userId,
                             @RequestParam(value = "placeId", required = true) Integer placeId,
                             @RequestParam(value = "flightId", required = true) Integer flightId) {
        try {
            Ticket ticket = new Ticket(userId, placeId, flightId);
            ticketRepository.save(ticket);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/tickets")
    public Boolean deleteTicket(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Ticket> test = ticketRepository.findById(id);
            if (!test.isPresent())
                return false;
            ticketRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
