package com.egor.marketplace.controller;

import com.egor.marketplace.entity.Role;
import com.egor.marketplace.entity.User;
import com.egor.marketplace.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegistryController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, Model model, HttpSession session) {
        User existingUser = userService.getUserByUsername(user.getUsername());
        if (existingUser != null) {
            model.addAttribute("error", "Пользователь с таким именем уже существует");
            return "register";
        }
        
        userService.registerUser(user);
        
        User registeredUser = userService.getUserByUsername(user.getUsername());
        session.setAttribute("user", registeredUser);
        session.setAttribute("userId", registeredUser.getId());
        session.setAttribute("username", registeredUser.getUsername());
        session.setAttribute("role", registeredUser.getRole());
        
        if (registeredUser.getRole() == Role.ADMIN) {
            return "redirect:/admin";
        }
        
        return "redirect:/products";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam("username") String username,
                           @RequestParam("password") String password,
                           HttpSession session,
                           Model model) {
        
        if (userService.authenticateUser(username, password)) {
            User user = userService.getUserByUsername(username);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            if (user.getRole() == Role.ADMIN) {
                return "redirect:/admin";
            }
            
            return "redirect:/products";
        } else {
            model.addAttribute("error", "Неверное имя пользователя или пароль");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
