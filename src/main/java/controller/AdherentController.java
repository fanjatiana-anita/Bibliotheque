package controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;

public class AdherentController {

    @GetMapping("/login")
    public String loginForm() {
        return "frontOffice/loginForm";
    }

    @PostMapping("/doLogin")
    public String doLogin(String pwd, HttpSession session) {
        // Auth simple sans base de données
        if (pwd != null && !pwd.trim().isEmpty() && pwd.equals("admin")) {
            // session.setAttribute("pwd", pwd);
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            session.removeAttribute("redirectAfterLogin");
    
            if (redirectUrl != null) {
                return "redirect:" + redirectUrl+"?succ";
            }
            return "redirect:/film";
        }
        return "redirect:/film?err";
    }
}
