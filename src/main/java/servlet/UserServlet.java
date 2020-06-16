package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(
    name = "UserServlet",
    urlPatterns = {"/user"}
)
public class UserServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        java.io.PrintWriter out = resp.getWriter();  
        String json ="{}";
        Object userObj = session.getAttribute("user");
        if (userObj != null) { // user logged in
            json="{\"result\":1}";
        }else {
            json="{\"result\":0}";
        }
        System.out.print(json);
        out.print(json);
        out.flush();
    }
}