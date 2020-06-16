package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
// internal import
import model.ProductDAO;
import model.Product;

@WebServlet(
    name = "AdminProductServlet",
    urlPatterns = {"/admin/product"}
)
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String JSP_PAGE = "../WEB-INF/jsp/admin/product.jsp";
    private ProductDAO dao = new ProductDAO();
    Gson mapper = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("products", dao.getAllProducts());
        req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String jsonString = req.getParameter("product");
        System.out.println(action + "|" + jsonString);
        Product product = mapper.fromJson(jsonString, Product.class);
        if (product == null) {
            resp.getWriter().print(mapper.toJson(product));
            return;
        }
        if (action != null && action.equals("add")){
            if (dao.addProduct(product) == null) product.reset();
        }else {
            if (dao.updateProduct(product) <= 0) product.reset();
        }
        resp.getWriter().print(mapper.toJson(product));
    }
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer id = Integer.valueOf(req.getParameter("id"));
        if (dao.deleteProduct(id) > 0)
            resp.getWriter().print("OK");
        else
            resp.getWriter().print("FAIL");
    }
}