package controller;

import jakarta.servlet.http.HttpSession;
import model.UserAccount;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import service.UserAccountService;

@Controller
public class LoginController {

    @Autowired
    private UserAccountService authService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "frontOffice/loginForm";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String login,
                          @RequestParam String motDePasse,
                          Model model,
                          HttpSession session) {

        UserAccount user = authService.authenticate(login, motDePasse);

        if (user == null) {
            model.addAttribute("error", "Login ou mot de passe incorrect");
            return "frontOffice/loginForm";
        }

        session.setAttribute("currentUser", user);

        switch (user.getRole()) {
            case BIBLIOTHECAIRE:
                return "redirect:/backoffice/dashboard";
            case ADHERENT:
            default:
                return "redirect:/frontoffice/home";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
