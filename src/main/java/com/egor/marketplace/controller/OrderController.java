package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Cart;
import com.egor.marketplace.entity.Order;
import com.egor.marketplace.entity.Role;
import com.egor.marketplace.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public String showOrders(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }

        int userId = (int) session.getAttribute("userId");
        List<Order> orders = orderService.getOrdersByUserId(userId);
        model.addAttribute("orders", orders);

        return "order-history";
    }

    @GetMapping("/detail")
    public String showOrderDetail(@RequestParam("id") int orderId, HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }

        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);

        return "order-detail";
    }

    @PostMapping("/create")
    public String createOrder(@RequestParam("addressId") int addressId,
                             @RequestParam("paymentMethodId") int paymentMethodId,
                             HttpSession session,
                             Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }

        int userId = (int) session.getAttribute("userId");
        
        try {
            Order order = orderService.createOrderFromCart(cart, userId, addressId, paymentMethodId);
            cart.clear();
            model.addAttribute("order", order);
            return "order-success";
        } catch (RuntimeException e) {
            // Если недостаточно товара на складе
            model.addAttribute("error", e.getMessage());
            return "redirect:/cart?error=insufficient";
        }
    }
}
