package app.Airship;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(value = "airship-service")
public interface AirshipClient {
    @GetMapping("/companies")
    public String getAllCompanies();

    @PostMapping("/companies")
    public Boolean addCompany(@RequestBody @RequestParam(value = "name", required = true) String name,
                              @RequestParam(value = "description", required = true) String description);

    @PutMapping("/companies")
    public Boolean editCompany(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                               @RequestParam(value = "name", required = true) String name,
                               @RequestParam(value = "description", required = true) String description);

    @DeleteMapping("/companies")
    public Boolean deleteCompany(@RequestParam(value = "id", required = true) Integer id);

    @GetMapping("/places")
    public String getPlacesByPlaneId(@RequestParam(value = "planeId", required = true) Integer planeId);

    @GetMapping("/planes")
    public String getPlanesByCompanyId(@RequestParam(value = "companyId", required = false) Integer companyId);

    @PostMapping("/planes")
    public Boolean addPlane(@RequestBody @RequestParam(value = "name", required = true) String name,
                            @RequestParam(value = "companyId", required = true) Integer companyId,
                            @RequestParam(value = "capacity", required = true) Integer capacity);

    @PutMapping("/planes")
    public Boolean editPlane(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "name", required = true) String name,
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "capacity", required = true) Integer capacity);

    @DeleteMapping("/planes")
    public Boolean deletePlane(@RequestParam(value = "id", required = true) Integer id);
}
