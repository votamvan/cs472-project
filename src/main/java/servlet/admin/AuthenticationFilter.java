package servlet.admin;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.User;

@WebFilter("/admin/*")
public class AuthenticationFilter implements Filter {
    private String LOGIN_PAGE = "../WEB-INF/jsp/admin/login.jsp";

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        System.out.println("admin.AuthenticationFilter");
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = false;
        if (session != null){
            User user = (User) session.getAttribute("user");
            isLoggedIn = (user != null && user.getRole().equals("admin"));
        }
        boolean isLoginRequest = httpRequest.getRequestURI().endsWith("/login");
        System.out.println(isLoggedIn + "|" + isLoginRequest);
        if (isLoggedIn || isLoginRequest){
            chain.doFilter(request, response);
        }else {
            request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
        }
    }

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void destroy() {}
}