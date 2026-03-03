package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Product;
import com.egor.marketplace.entity.Review;
import com.egor.marketplace.entity.Role;
import com.egor.marketplace.entity.User;
import com.egor.marketplace.entity.Order;
import com.egor.marketplace.entity.OrderItem;
import com.egor.marketplace.service.OrderService;
import com.egor.marketplace.service.ProductService;
import com.egor.marketplace.service.ReviewService;
import com.egor.marketplace.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private OrderService orderService;

    @GetMapping("/debug/images")
    public String debugImages(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "debug-images";
    }

    @GetMapping("/")
    public String showProfile(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }
        
        int userId = (int) session.getAttribute("userId");
        User user = userService.getUserByIdWithProducts(userId);
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/profile")
    public String profileRedirect() {
        return "redirect:/";
    }

    @GetMapping("/products")
    public String showAllProducts(@RequestParam(value = "search", required = false) String search,
                                 @RequestParam(value = "sortBy", required = false) String sortBy,
                                 Model model, 
                                 HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }
        
        int userId = (int) session.getAttribute("userId");
        
        // Для продавцов исключаем их собственные товары
        Integer excludeUserId = (userRole == Role.SELLER) ? userId : null;
        
        List<Product> products = productService.searchAndFilterProducts(search, sortBy, excludeUserId);
        Map<Integer, List<Review>> reviewsMap = new HashMap<>();
        Map<Integer, Double> averageRatingsMap = new HashMap<>();
        Set<Integer> purchasedProductIds = new HashSet<>();
        Set<Integer> reviewedProductIds = new HashSet<>();
        Set<Integer> userOwnProductIds = new HashSet<>();
        
        // Получаем товары текущего пользователя
        User currentUser = userService.getUserByIdWithProducts(userId);
        if (currentUser.getProducts() != null) {
            for (Product userProduct : currentUser.getProducts()) {
                userOwnProductIds.add(userProduct.getId());
            }
        }
        
        // Получаем список купленных товаров
        List<Order> userOrders = orderService.getOrdersByUserId(userId);
        for (Order order : userOrders) {
            if ("Успешный".equals(order.getStatus())) {
                for (OrderItem item : order.getOrderItems()) {
                    purchasedProductIds.add(item.getProduct().getId());
                }
            }
        }
        
        for (Product product : products) {
            List<Review> reviews = reviewService.getReviewsByProductId(product.getId());
            reviewsMap.put(product.getId(), reviews);
            
            // Проверяем, оставлял ли пользователь отзыв на этот товар
            Review userReview = reviewService.getReviewByUserAndProduct(userId, product.getId());
            if (userReview != null) {
                reviewedProductIds.add(product.getId());
            }
            
            // Вычисляем среднюю оценку
            if (!reviews.isEmpty()) {
                double sum = 0;
                for (Review review : reviews) {
                    sum += review.getRating();
                }
                double average = sum / reviews.size();
                averageRatingsMap.put(product.getId(), Math.round(average * 10.0) / 10.0);
            } else {
                averageRatingsMap.put(product.getId(), 0.0);
            }
        }
        
        model.addAttribute("products", products);
        model.addAttribute("reviewsMap", reviewsMap);
        model.addAttribute("averageRatingsMap", averageRatingsMap);
        model.addAttribute("purchasedProductIds", purchasedProductIds);
        model.addAttribute("reviewedProductIds", reviewedProductIds);
        model.addAttribute("userOwnProductIds", userOwnProductIds);
        model.addAttribute("search", search);
        model.addAttribute("sortBy", sortBy);
        return "product-list";
    }

    @GetMapping("/products/add")
    public String showAddProductForm(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.USER || userRole == Role.ADMIN) {
            return "redirect:/products";
        }
        
        model.addAttribute("product", new Product());
        return "product-form";
    }

    @PostMapping("/products/add")
    public String addProduct(@RequestParam("name") String name,
                           @RequestParam("description") String description,
                           @RequestParam("price") double price,
                           @RequestParam("quantity") int quantity,
                           HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.USER || userRole == Role.ADMIN) {
            return "redirect:/products";
        }
        
        Product product = new Product(name, description, price, quantity);
        
        int userId = (int) session.getAttribute("userId");
        productService.addProduct(product, userId);
        return "redirect:/";
    }

    @GetMapping("/products/delete")
    public String deleteProduct(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.USER || userRole == Role.ADMIN) {
            return "redirect:/products";
        }
        
        // Проверяем, можно ли удалить товар
        if (!productService.canDeleteProduct(id)) {
            return "redirect:/?error=cannot_delete";
        }
        
        productService.deleteProduct(id);
        return "redirect:/";
    }

    @GetMapping("/user/delete")
    public String deleteAccount(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        userService.deleteUser(userId);
        session.invalidate();
        return "redirect:/register?deleted=true";
    }
}
