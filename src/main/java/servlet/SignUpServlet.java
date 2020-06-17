package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// internal import
import model.*;

@WebServlet(
    name = "SignUpServlet",
    urlPatterns = {"/signup"}
)
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String JSP_PAGE = "WEB-INF/jsp/signup.jsp", LOGIN_PAGE="login";
    UserDAO dao = new UserDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        User u = dao.addUser(fullname, username, password);
        if (u == null) {
            req.setAttribute("message", "There was an error for signing up!");
            req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
        }else {
            HttpSession session = req.getSession();
            session.setAttribute("message", null);
            resp.sendRedirect(LOGIN_PAGE);
        }
    }
}