package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Cart;
import com.egor.marketplace.entity.Product;
import com.egor.marketplace.entity.Role;
import com.egor.marketplace.service.AddressService;
import com.egor.marketplace.service.PaymentMethodService;
import com.egor.marketplace.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ProductService productService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private PaymentMethodService paymentMethodService;

    @GetMapping
    public String showCart(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        model.addAttribute("cart", cart);
        return "cart";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("productId") int productId,
                           @RequestParam("quantity") int quantity,
                           HttpSession session,
                           Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }
        
        int userId = (int) session.getAttribute("userId");

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        Product product = productService.getProductById(productId);
        if (product != null) {
            // Проверяем, не пытается ли продавец купить свой товар
            if (product.getUser() != null && product.getUser().getId() == userId) {
                return "redirect:/products?error=ownProduct";
            }
            
            // Проверяем доступность товара
            if (product.getQuantity() >= quantity) {
                cart.addItem(product, quantity);
            } else {
                // Можно добавить сообщение об ошибке
                model.addAttribute("error", "Недостаточно товара на складе");
                return "redirect:/products?error=insufficient";
            }
        }

        return "redirect:/cart";
    }

    @GetMapping("/remove")
    public String removeFromCart(@RequestParam("productId") int productId, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.removeItem(productId);
        }

        return "redirect:/cart";
    }

    @PostMapping("/update")
    public String updateCart(@RequestParam("productId") int productId,
                            @RequestParam("quantity") int quantity,
                            HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.updateItemQuantity(productId, quantity);
        }

        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
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
        model.addAttribute("cart", cart);
        model.addAttribute("addresses", addressService.getAddressesByUserId(userId));
        model.addAttribute("paymentMethods", paymentMethodService.getPaymentMethodsByUserId(userId));

        return "checkout";
    }

    @GetMapping("/clear")
    public String clearCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.clear();
        }
        return "redirect:/cart";
    }
}
