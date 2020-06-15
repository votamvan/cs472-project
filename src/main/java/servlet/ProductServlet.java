package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// internal import
import model.ProductDAO;
import model.Product;


@WebServlet(
    name = "ProductServlet",
    urlPatterns = {"/product"}
)
public class ProductServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    String JSP_PAGE = "/WEB-INF/product.jsp";
    ProductDAO dao = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Product[] products = dao.getAllProducts();
        req.setAttribute("products", products);
        req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
    }
}