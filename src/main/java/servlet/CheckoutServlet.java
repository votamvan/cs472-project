package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(
    name = "CheckoutServlet",
    urlPatterns = {"/checkout"}
)
public class CheckoutServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    String JSP_PAGE = "/WEB-INF/checkout.jsp";
    String THANK_PAGE = "/thankyou";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException{
        req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
        throws ServletException, IOException{
        HttpSession session = req.getSession(false);
        if (session != null) {
            System.out.println("destroy cart");
            session.setAttribute("cart", null);
        }
        resp.sendRedirect(THANK_PAGE);
    }
}