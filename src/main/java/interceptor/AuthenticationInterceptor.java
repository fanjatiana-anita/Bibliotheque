package interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthenticationInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        // Autorise les pages publiques
        if (uri.endsWith("/film")) {
            return true;
        }

        // Si l’utilisateur n’est pas authentifié
        // if (session == null || session.getAttribute("pwd") == null) {
            String originalUrl = request.getRequestURI().substring(request.getContextPath().length());
            request.getSession(true).setAttribute("redirectAfterLogin", originalUrl);
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        // }

        //return true;
    }
}
