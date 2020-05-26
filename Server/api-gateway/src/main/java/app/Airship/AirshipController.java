package app.Airship;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class AirshipController {
    @Autowired
    AirshipClient airshipClient;

    @GetMapping("/companies")
    public String getAllCompanies() {
        return airshipClient.getAllCompanies();
    }

    @PostMapping("/companies")
    public Boolean addCompany(@RequestBody @RequestParam(value = "name", required = true) String name,
                              @RequestParam(value = "description", required = true) String description) {
        return airshipClient.addCompany(name, description);
    }

    @PutMapping("/companies")
    public Boolean editCompany(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                               @RequestParam(value = "name", required = true) String name,
                               @RequestParam(value = "description", required = true) String description) {
        return airshipClient.editCompany(id, name, description);
    }

    @DeleteMapping("/companies")
    public Boolean deleteCompany(@RequestParam(value = "id", required = true) Integer id) {
        return airshipClient.deleteCompany(id);
    }

    @GetMapping("/places")
    public String getPlacesByPlaneId(@RequestParam(value = "planeId", required = true) Integer planeId) {
        return airshipClient.getPlacesByPlaneId(planeId);
    }

    @GetMapping("/planes")
    public String getPlanesByCompanyId(@RequestParam(value = "companyId", required = true) Integer companyId) {
        return airshipClient.getPlanesByCompanyId(companyId);
    }

    @PostMapping("/planes")
    public Boolean addPlane(@RequestBody @RequestParam(value = "name", required = true) String name,
                            @RequestParam(value = "companyId", required = true) Integer companyId,
                            @RequestParam(value = "capacity", required = true) Integer capacity) {
        return airshipClient.addPlane(name, companyId, capacity);
    }

    @PutMapping("/planes")
    public Boolean editPlane(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "name", required = true) String name,
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "capacity", required = true) Integer capacity) {
        return airshipClient.editPlane(id, name, companyId, capacity);
    }

    @DeleteMapping("/planes")
    public Boolean deletePlane(@RequestParam(value = "id", required = true) Integer id) {
        return airshipClient.deletePlane(id);
    }
}
