package app.Place;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping
public class PlaceController {
    @Autowired
    PlaceRepository placeRepository;

    @GetMapping("/places")
    public String getPlacesByPlaneId(@RequestParam(value = "planeId", required = true) Integer planeId) {
        List<Place> resultList = new ArrayList<>();
        Iterable<Place> result = placeRepository.findByPlaneId(planeId);
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }
}
