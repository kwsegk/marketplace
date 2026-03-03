package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Address;
import com.egor.marketplace.entity.PaymentMethod;
import com.egor.marketplace.entity.Role;
import com.egor.marketplace.service.AddressService;
import com.egor.marketplace.service.PaymentMethodService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private AddressService addressService;

    @Autowired
    private PaymentMethodService paymentMethodService;

    @GetMapping("/settings")
    public String showSettings(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }

        Role userRole = (Role) session.getAttribute("role");
        if (userRole == Role.ADMIN) {
            return "redirect:/admin";
        }

        int userId = (int) session.getAttribute("userId");
        
        List<Address> addresses = addressService.getAddressesByUserId(userId);
        List<PaymentMethod> paymentMethods = paymentMethodService.getPaymentMethodsByUserId(userId);
        
        model.addAttribute("addresses", addresses);
        model.addAttribute("paymentMethods", paymentMethods);
        model.addAttribute("newAddress", new Address());
        model.addAttribute("newPaymentMethod", new PaymentMethod());
        
        return "profile-settings";
    }

    @PostMapping("/address/add")
    public String addAddress(@ModelAttribute("newAddress") Address address, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        addressService.addAddress(address, userId);
        
        return "redirect:/profile/settings";
    }

    @GetMapping("/address/delete")
    public String deleteAddress(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        addressService.deleteAddress(id);
        return "redirect:/profile/settings";
    }

    @GetMapping("/address/setDefault")
    public String setDefaultAddress(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        addressService.setDefaultAddress(userId, id);
        
        return "redirect:/profile/settings";
    }

    @PostMapping("/payment/add")
    public String addPaymentMethod(@ModelAttribute("newPaymentMethod") PaymentMethod paymentMethod, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        paymentMethodService.addPaymentMethod(paymentMethod, userId);
        
        return "redirect:/profile/settings";
    }

    @GetMapping("/payment/delete")
    public String deletePaymentMethod(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        paymentMethodService.deletePaymentMethod(id);
        return "redirect:/profile/settings";
    }

    @GetMapping("/payment/setDefault")
    public String setDefaultPaymentMethod(@RequestParam("id") int id, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        int userId = (int) session.getAttribute("userId");
        paymentMethodService.setDefaultPaymentMethod(userId, id);
        
        return "redirect:/profile/settings";
    }
}
