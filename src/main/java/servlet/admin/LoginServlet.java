package servlet.admin;

import java.io.IOException;
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
    name = "AdminLoginServlet",
    urlPatterns = {"/admin/login", "/admin/"}
)
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String LOGIN_PAGE = "../WEB-INF/jsp/admin/login.jsp";
    private String HOME_PAGE = "../WEB-INF/jsp/admin/index.jsp";
    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole().equals("admin")){
            req.getRequestDispatcher(HOME_PAGE).forward(req, resp);
        }else {
            req.getRequestDispatcher(LOGIN_PAGE).forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // remember me
        handleRememberMe(req, resp);
        // handle login
        resp.sendRedirect(handleLogin(req, resp));
    }

    private void handleRememberMe(HttpServletRequest req, HttpServletResponse resp){
        String username = req.getParameter("username");
        String remember = req.getParameter("remember");
        System.out.println("remember:" + remember);
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
        System.out.println(username + "|" + password);
        String nextPage = "/admin/login";
        User user = dao.checkLogin(username, password);
        HttpSession session = req.getSession();
        if (user != null && user.getRole().equals("admin")) { // login success
            System.out.println(user);
            session.setAttribute("user", user);
            session.setAttribute("message", null);
            nextPage = "/admin/";
        }else {
            String message = "Invalid username or password.";
            session.setAttribute("message", message);
            System.out.println(message);
        }
        return nextPage;
    }
}