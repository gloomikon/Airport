package app.Review;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequestMapping
@RestController
public class ReviewController {
    @Autowired
    ReviewRepository reviewRepository;

    @GetMapping("/reviews")
    public String getReviews(@RequestParam(value = "companyId", required = false) Integer companyId) {
        List<Review> resultList = new ArrayList<>();
        Iterable<Review> result;
        if (companyId == null) {
            result = reviewRepository.findAll();
        } else {
            result = reviewRepository.findByCompanyId(companyId);
        }
        result.forEach(resultList::add);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String prettyJson = gson.toJson(resultList);
        return prettyJson;
    }

    @PostMapping("/reviews")
    public Boolean addReview(@RequestBody
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "text", required = true) String text,
                             @RequestParam(value = "rating", required = true) Integer rating,
                             @RequestParam(value = "userId", required = true) Integer userId) {
        try {
            Review review = new Review(companyId, text, rating, userId);
            reviewRepository.save(review);
            return true;
        } catch (Exception e) {
            return false;
        }
    }


    @PutMapping("/reviews")
    public Boolean editReview(@RequestBody @RequestParam(value = "id", required = true) Integer id,
                             @RequestParam(value = "companyId", required = true) Integer companyId,
                             @RequestParam(value = "text", required = true) String text,
                             @RequestParam(value = "rating", required = true) Integer rating,
                             @RequestParam(value = "userId", required = true) Integer userId) {
        try {
            Optional<Review> test = reviewRepository.findById(id);
            if (!test.isPresent())
                return false;
            Review review = test.get();
            review.setCompanyId(companyId);
            review.setText(text);
            review.setRating(rating);
            review.setUserId(userId);
            reviewRepository.save(review);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @DeleteMapping("/reviews")
    public Boolean deleteReview(@RequestParam(value = "id", required = true) Integer id) {
        try {
            Optional<Review> test = reviewRepository.findById(id);
            if (!test.isPresent())
                return false;
            reviewRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
