package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Order;
import com.egor.marketplace.entity.OrderItem;
import com.egor.marketplace.entity.Review;
import com.egor.marketplace.service.OrderService;
import com.egor.marketplace.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private OrderService orderService;

    @PostMapping("/add")
    public String addReview(@RequestParam("productId") int productId,
                           @RequestParam("rating") int rating,
                           @RequestParam("comment") String comment,
                           HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        
        // Проверяем, не оставлял ли пользователь уже отзыв на этот товар
        Review existingReview = reviewService.getReviewByUserAndProduct(userId, productId);
        if (existingReview != null) {
            return "redirect:/products?error=alreadyReviewed";
        }
        
        // Проверяем, покупал ли пользователь этот товар
        List<Order> userOrders = orderService.getOrdersByUserId(userId);
        boolean hasPurchased = false;
        
        for (Order order : userOrders) {
            if ("Успешный".equals(order.getStatus())) {
                for (OrderItem item : order.getOrderItems()) {
                    if (item.getProduct().getId() == productId) {
                        hasPurchased = true;
                        break;
                    }
                }
            }
            if (hasPurchased) break;
        }
        
        if (!hasPurchased) {
            return "redirect:/products?error=notPurchased";
        }
        
        Review review = new Review();
        review.setRating(rating);
        review.setComment(comment);
        
        reviewService.addReview(review, userId, productId);
        
        return "redirect:/products";
    }
}
