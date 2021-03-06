package servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// internal import
import model.UserDAO;
import model.User;

@WebServlet(
    name = "LoginServlet",
    urlPatterns = {"/login"}
)
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String LOGIN_PAGE = "WEB-INF/jsp/login.jsp";
    private String HOME_PAGE = "/";
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher(LOGIN_PAGE);
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // add promo cookie
        resp.addCookie(createPromoCookie());
        // remember me
        handleRememberMe(req, resp);
        // handle login
        String nextPage = handleLogin(req, resp);
        resp.sendRedirect(nextPage);
    }

    private Cookie createPromoCookie(){
        Cookie cookie = new Cookie("promo", "$100");
        cookie.setPath("/");
        cookie.setMaxAge(31*24*60*60);
        return cookie;
    }

    private void handleRememberMe(HttpServletRequest req, HttpServletResponse resp){
        String username = req.getParameter("username");
        String remember = req.getParameter("remember");
        //System.out.println("remember:" + remember);
        if (remember == null || remember == "null") { // erase cookie
            Cookie cookie = new Cookie("username", "");
            cookie.setPath("/");
            cookie.setMaxAge(0);
            resp.addCookie(cookie);
        }else { // enable cookie for a month 
            Cookie cookie = new Cookie("username", username);
            cookie.setPath("/");
            cookie.setMaxAge(31*24*60*60);
            resp.addCookie(cookie);
        }
    }

    private String handleLogin(HttpServletRequest req, HttpServletResponse resp){
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        //System.out.println(username + "|" + password);
        String nextPage = "/login";
        User user = dao.checkLogin(username, password);
        HttpSession session = req.getSession();
        if (user != null) { // login success
            System.out.println(user);
            session.setAttribute("user", user);
            session.setAttribute("message", null);
            nextPage = HOME_PAGE;
        }else {
            String message = "Invalid username or password.";
            session.setAttribute("message", message);
            System.out.println(message);
        }
        return nextPage;
    }
}