package servlet;

import java.util.List;
import java.util.ArrayList;
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
    name = "ShoppingCartServlet",
    urlPatterns = {"/cart"}
)
public class ShoppingCartServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
    String JSP_PAGE = "cart.jsp";
    ProductDAO pdao = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
        }else {
            if (action.equalsIgnoreCase("buy")) {
                handleBuy(req, resp);
            }else if (action.equalsIgnoreCase("remove")) {
                handleRemove(req, resp);
            }
        }
    }
    protected void handleBuy(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        int productId = Integer.valueOf(req.getParameter("id"));
        HttpSession session = req.getSession();
        List<ShoppingItem> cart = null;
        if (session.getAttribute("cart") == null) {
            cart = new ArrayList<ShoppingItem>();
        }else {
            cart = (List<ShoppingItem>) session.getAttribute("cart");
        }
        int index = isExisting(productId, cart);
        if (index == -1) {  // new product
            ShoppingItem item = new ShoppingItem();
            item.setProduct(pdao.getProductsById(productId));
            item.setQuantity(1);
            cart.add(item);
        }else {
            cart.get(index).addQuantity(1);
        }
        session.setAttribute("cart", cart);
        resp.sendRedirect("cart");
    }
    protected void handleRemove(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        int productId = Integer.valueOf(req.getParameter("id"));
        HttpSession session = req.getSession();
        if (session.getAttribute("cart") == null) return;
        List<ShoppingItem> cart = (List<ShoppingItem>) session.getAttribute("cart");
        int index = isExisting(productId, cart);
        if (index != -1) cart.remove(index);
        session.setAttribute("cart", cart);
        resp.sendRedirect("cart");
    }
    private int isExisting(int id, List<ShoppingItem> cart) {
        if (cart == null) return -2;
        for (int i = 0; i < cart.size(); i++) {
            if (cart.get(i).getProduct().getId() == id) return i;
        }
        return -1;
    }
}