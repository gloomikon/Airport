package app.Review;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@FeignClient(value = "review-service")
public interface ReviewClient {
    @GetMapping("/reviews")
    String getReviews(@RequestParam(value = "companyId", required = false) String companyId);

    @PostMapping("/reviews")
    public Boolean addReview(@RequestBody
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "text", required = true) String text,
                             @RequestParam(value = "rating", required = true) Integer rating,
                             @RequestParam(value = "userId", required = true) Integer userId);


    @PutMapping("/reviews")
    public Boolean editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                              @RequestParam(value = "companyId", required = true) Integer companyId,
                              @RequestParam(value = "text", required = true) String text,
                              @RequestParam(value = "rating", required = true) Integer rating,
                              @RequestParam(value = "userId", required = true) Integer userId);

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id", required = true) Integer id);
}
