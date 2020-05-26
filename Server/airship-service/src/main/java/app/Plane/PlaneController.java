package app.Plane;

import app.Company.Company;
import app.Place.Place;
import app.Place.PlaceRepository;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class PlaneController {
    @Autowired
    PlaneRepository planeRepository;

    @Autowired
    PlaceRepository placeRepository;

    @GetMapping("/planes")
    public String getPlanesByCompanyId(@RequestParam(value = "companyId", required = true) Integer companyId) {
        List<Plane> resultList = new ArrayList<>();
        Iterable<Plane> result = planeRepository.findByCompanyId(companyId);
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    private String randomString() {
        String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 2; i++)
            sb.append(AB.charAt(rnd.nextInt(26) + 10));
        for (int i = 0; i < 4; i++)
            sb.append(AB.charAt(rnd.nextInt(10)));
        return sb.toString();
    }

    @PostMapping("/planes")
    public Boolean addPlane(@RequestBody @RequestParam(value = "name", required = true) String name,
                              @RequestParam(value = "companyId", required = true) Integer companyId,
                            @RequestParam(value = "capacity", required = true) Integer capacity) {
        try {
            Plane plane = new Plane(name, companyId, capacity);
            planeRepository.save(plane);
            for (int i = 0; i < capacity; ++i) {
                Place place = new Place();
                place.setName(randomString());
                place.setPlaneId(plane.getId());
                placeRepository.save(place);
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @PutMapping("/planes")
    public Boolean editPlane(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "name", required = true) String name,
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "capacity", required = true) Integer capacity) {
        try {
            Optional<Plane> test = planeRepository.findById(id);
            if (!test.isPresent())
                return false;
            Plane plane = test.get();
            plane.setName(name);
            plane.setCompanyId(companyId);
            plane.setCapacity(capacity);
            planeRepository.save(plane);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/planes")
    public Boolean deletePlane(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Plane> test = planeRepository.findById(id);
            if (!test.isPresent())
                return false;
            planeRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
