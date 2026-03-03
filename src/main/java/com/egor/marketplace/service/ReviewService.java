package com.egor.marketplace.service;

import com.egor.marketplace.entity.Review;

import java.util.List;

public interface ReviewService {
    List<Review> getReviewsByProductId(int productId);
    Review getReviewByUserAndProduct(int userId, int productId);
    void addReview(Review review, int userId, int productId);
    void deleteReview(int id);
}
