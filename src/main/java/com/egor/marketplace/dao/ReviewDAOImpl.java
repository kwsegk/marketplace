package com.egor.marketplace.dao;

import com.egor.marketplace.entity.Review;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Review> getReviewsByProductId(int productId) {
        return entityManager.createQuery(
                "SELECT r FROM Review r LEFT JOIN FETCH r.user WHERE r.product.id = :productId ORDER BY r.reviewDate DESC", Review.class)
                .setParameter("productId", productId)
                .getResultList();
    }

    @Override
    public Review getReviewByUserAndProduct(int userId, int productId) {
        List<Review> reviews = entityManager.createQuery(
                "SELECT r FROM Review r WHERE r.user.id = :userId AND r.product.id = :productId", Review.class)
                .setParameter("userId", userId)
                .setParameter("productId", productId)
                .getResultList();
        return reviews.isEmpty() ? null : reviews.get(0);
    }

    @Override
    public void saveReview(Review review) {
        entityManager.persist(review);
    }

    @Override
    public void deleteReview(int id) {
        Review review = entityManager.find(Review.class, id);
        if (review != null) {
            entityManager.remove(review);
        }
    }
}
