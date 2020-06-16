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
    String JSP_PAGE = "WEB-INF/jsp/cart.jsp";
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
    private float getCostTotal(List<ShoppingItem> cart){
        float costTotal = 0;
        if(cart !=null){            
            for(ShoppingItem item: cart){
                costTotal += item.getQuantity()*Float.parseFloat(item.getProduct().getPrice());
            } 
        } 
        return costTotal;
    }


    //handle CRUD - JSON data format
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
        if (action == null) {
            req.getRequestDispatcher(JSP_PAGE).forward(req, resp);
        }else {
            HttpSession session = req.getSession();
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            java.io.PrintWriter out = resp.getWriter();  
            String json ="{}";
            List<ShoppingItem> cart = null;

            if (session.getAttribute("cart") == null) {
                cart = new ArrayList<ShoppingItem>();
            }else {
                cart = (List<ShoppingItem>) session.getAttribute("cart");
            }
            //return cart information
            if (action.equalsIgnoreCase("view")) {
                int total = (cart==null)?0:cart.size();                              
                json="{\"total\":"+total+",\"cost\":"+getCostTotal(cart)+"}";
            }else if (action.equalsIgnoreCase("delete")) {                
                int id = Integer.valueOf(req.getParameter("id"));
                int index = isExisting(id, cart);
                if (index != -1) {
                    cart.remove(index);
                    json="{\"result\":1,\"cost\":"+getCostTotal(cart)+"}";;
                }else {
                    json="{\"result\":0}";
                }
                System.out.println(index);
                session.setAttribute("cart", cart);                
            }else if (action.equalsIgnoreCase("update")) {
                int id = Integer.valueOf(req.getParameter("id"));
                int quantity = Integer.valueOf(req.getParameter("quantity"));
                int index = isExisting(id, cart);

                if (index > -1) {                 
                    ShoppingItem item = cart.get(index);                       
                    if(quantity==0){
                        cart.remove(index);
                    }else if(quantity>0){
                        item.setQuantity(quantity);        
                    }                    
                    json="{\"result\":1,\"cost\":"+getCostTotal(cart)+"}";
                }else{
                    json="{\"result\":0}";
                }
                session.setAttribute("cart", cart);                
            }else if (action.equalsIgnoreCase("add")) {
                int id = Integer.valueOf(req.getParameter("id"));
                int quantity = Integer.valueOf(req.getParameter("quantity"));
                int index = isExisting(id, cart);

                if (index == -1) {  
                    // new product if quantity>0
                    if(quantity>0){
                        ShoppingItem item = new ShoppingItem();
                        item.setProduct(pdao.getProductsById(id));
                        item.setQuantity(quantity);
                        cart.add(item);
                        json="{\"result\":1,\"cost\":"+getCostTotal(cart)+"}";
                    }else{
                        json="{\"result\":0}";
                    }
                }else if (index > -1) {                 
                    ShoppingItem item = cart.get(index);                       
                    if(quantity==0){
                        cart.remove(index);
                    }else if(quantity>0){
                        item.addQuantity(quantity);        
                    }                    
                    json="{\"result\":1,\"cost\":"+getCostTotal(cart)+"}";
                }else{
                    json="{\"result\":0}";
                }                
                session.setAttribute("cart", cart);                
            }
            System.out.print(json);
            out.print(json);
            out.flush();
        }
    }
}