package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Review;

import java.util.List;

public interface ReviewDAO {
    List<Review> getReviewsByProductId(int productId);
    Review getReviewByUserAndProduct(int userId, int productId);
    void saveReview(Review review);
    void deleteReview(int id);
}
