package app.Review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class ReviewController {
    @Autowired
    ReviewClient reviewClient;

    @GetMapping("/reviews")
    String getReviews(@RequestParam(value = "companyId", required = false) Integer companyId) {
        return reviewClient.getReviews(companyId);
    }

    @PostMapping("/reviews")
    public Boolean addReview(@RequestBody
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "text", required = true) String text,
                             @RequestParam(value = "rating", required = true) Integer rating,
                             @RequestParam(value = "userId", required = true) Integer userId) {
        return reviewClient.addReview(companyId, text, rating, userId);
    }


    @PutMapping("/reviews")
    public Boolean editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                              @RequestParam(value = "companyId", required = true) Integer companyId,
                              @RequestParam(value = "text", required = true) String text,
                              @RequestParam(value = "rating", required = true) Integer rating,
                              @RequestParam(value = "userId", required = true) Integer userId) {
        return reviewClient.editReview(id, companyId, text, rating, userId);
    }

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id", required = true) Integer id) {
        return reviewClient.deleteReview(id);
    }
}
