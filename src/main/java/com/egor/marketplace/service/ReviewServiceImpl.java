package com.egor.marketplace.service;

import com.egor.marketplace.dao.ReviewDAO;
import com.egor.marketplace.entity.Product;
import com.egor.marketplace.entity.Review;
import com.egor.marketplace.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDAO reviewDAO;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @Override
    @Transactional
    public List<Review> getReviewsByProductId(int productId) {
        return reviewDAO.getReviewsByProductId(productId);
    }

    @Override
    @Transactional
    public Review getReviewByUserAndProduct(int userId, int productId) {
        return reviewDAO.getReviewByUserAndProduct(userId, productId);
    }

    @Override
    @Transactional
    public void addReview(Review review, int userId, int productId) {
        User user = userService.getUserById(userId);
        Product product = productService.getProductById(productId);
        
        review.setUser(user);
        review.setProduct(product);
        review.setReviewDate(LocalDateTime.now());
        
        reviewDAO.saveReview(review);
    }

    @Override
    @Transactional
    public void deleteReview(int id) {
        reviewDAO.deleteReview(id);
    }
}
