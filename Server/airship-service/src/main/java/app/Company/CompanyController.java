package app.Company;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping
public class CompanyController {
    @Autowired
    CompanyRepository companyRepository;

    @GetMapping("/companies")
    public String getAllCompanies() {
        List<Company> resultList = new ArrayList<>();
        Iterable<Company> result = companyRepository.findAll();
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/companies")
    public Boolean addCompany(@RequestBody @RequestParam(value = "name", required = true) String name,
                             @RequestParam(value = "description", required = true) String description) {
        try {
            companyRepository.save(new Company(name, description));
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }

    @PutMapping("/companies")
    public Boolean editCompany(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                                   @RequestParam(value = "name", required = true) String name,
                               @RequestParam(value = "description", required = true) String description) {
        try {
            Optional<Company> test = companyRepository.findById(id);
            if (!test.isPresent())
                return false;
            Company company = test.get();
            company.setName(name);
            company.setDescription(description);
            companyRepository.save(company);
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/companies")
    public Boolean deleteCompany(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Company> test = companyRepository.findById(id);
            if (!test.isPresent())
                return false;
            companyRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
