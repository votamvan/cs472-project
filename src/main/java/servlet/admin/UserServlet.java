package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

// internal import
import model.UserDAO;
import model.ErrorMessage;
import model.User;

@WebServlet(
    name = "AdminUserServlet",
    urlPatterns = {"/admin/user"}
)
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private String USER_PAGE = "../WEB-INF/jsp/admin/user.jsp";
    private UserDAO dao = new UserDAO();
    Gson mapper = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("users", dao.getAllUsers());
        req.getRequestDispatcher(USER_PAGE).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ErrorMessage err = new ErrorMessage();
        String action = req.getParameter("action");
        String jsonString = req.getParameter("user");
        System.out.println(action + "|" + jsonString);
        User user = mapper.fromJson(jsonString, User.class);
        if (user == null) {
            err.setMessage("cannot receive data");
            resp.getWriter().print(mapper.toJson(err));
            return;
        }
        err.setMessage(dao.validator(user));
        if (!err.getMessage().isEmpty()){
            resp.getWriter().print(mapper.toJson(err));
            return;
        }
        if (action != null && action.equals("add")){
            if (dao.addUser(user) == null) user.reset();
        }else {
            if (dao.checkUserExist(user))
                user.reset();
            else if (dao.updateUser(user) <= 0) 
                user.reset();
        }
        resp.getWriter().print(mapper.toJson(user));
    }
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer id = Integer.valueOf(req.getParameter("id"));
        if (dao.deleteUser(id) > 0)
            resp.getWriter().print("OK");
        else
            resp.getWriter().print("FAIL");
    }
}