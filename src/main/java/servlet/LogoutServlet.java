package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(
    name = "LogoutServlet",
    urlPatterns = {"/logout"}
)
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String LOGIN_PAGE = "login.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            System.out.println("destroy session");
            session.invalidate();
        }
        resp.sendRedirect(LOGIN_PAGE);
    }
}