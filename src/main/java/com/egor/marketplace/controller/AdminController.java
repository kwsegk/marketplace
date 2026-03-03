package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Role;
import com.egor.marketplace.entity.User;
import com.egor.marketplace.service.ProductService;
import com.egor.marketplace.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProductService productService;

    @GetMapping("/admin")
    public String showAdminPanel(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role role = (Role) session.getAttribute("role");
        if (role != Role.ADMIN) {
            return "redirect:/";
        }
        
        List<User> sellers = userService.getAllSellersWithProducts();
        List<User> buyers = userService.getAllBuyersWithOrders();
        
        model.addAttribute("sellers", sellers);
        model.addAttribute("buyers", buyers);
        
        return "admin";
    }

    @GetMapping("/admin/product/delete")
    public String deleteProduct(@RequestParam("id") int productId, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role role = (Role) session.getAttribute("role");
        if (role != Role.ADMIN) {
            return "redirect:/";
        }
        
        // Проверяем, можно ли удалить товар
        if (!productService.canDeleteProduct(productId)) {
            return "redirect:/admin?error=cannot_delete";
        }
        
        productService.deleteProduct(productId);
        return "redirect:/admin";
    }

    @GetMapping("/admin/user/delete")
    public String deleteUser(@RequestParam("id") int userId, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Role role = (Role) session.getAttribute("role");
        if (role != Role.ADMIN) {
            return "redirect:/";
        }
        
        userService.deleteUser(userId);
        return "redirect:/admin";
    }
}
