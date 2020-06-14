package model;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public User checkLogin(String username, String password) throws SQLException{
        String sql = "SELECT * FROM users WHERE username = ? and password = ? LIMIT 1";
        String[] params = {username, password};
        List<User> users = select(sql, params);
        return (users.size() == 0) ? null: users.get(0); 
    }
    public User addUser(String fullname, String username, String password) throws SQLException{
        String sql = "SELECT * FROM users WHERE username = ?";
        String[] params = {username};
        if (select(sql, params).size() > 0) {
            System.out.println("user exist");
            return null;
        }
        int id = insert(fullname, username, password);
        if (id <= 0){
            System.out.println("insert error");
            return null;
        }
        return new User(id, fullname, username, password);
    }
    private List<User> select(String sql, String[] params) throws SQLException{
        Connection conn = DBCPDataSource.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        if (params != null) {
            for (int i=0; i<params.length; i++)
            stmt.setString(i+1, params[i]);
        }
        ResultSet result = stmt.executeQuery();
        ArrayList<User> users = new ArrayList<User>();
        while (result.next()) {
            User u = new User();
            u.setId(result.getInt("id"));
            u.setUsername(result.getString("username"));
            u.setPassword(result.getString("password"));
            u.setFullname(result.getString("fullname"));
            users.add(u);
        };
        return users;
    }
    private int insert(String fullname, String username, String password) throws SQLException{
        String sql = "INSERT INTO users(fullname, username, password) VALUES(?, ?, ?)";
        Connection conn = DBCPDataSource.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, fullname);
        stmt.setString(2, username);
        stmt.setString(3, password);
        int affectedRows = stmt.executeUpdate();
        if (affectedRows == 0)
            return -1;
        ResultSet generatedKeys = stmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            return generatedKeys.getInt(1);
        }else {
            return -1;
        }
    }
    private int update(int id, String fullname, String password) throws SQLException{
        String sql = "UPDATE users SET fullname = ?, password = ? WHERE id = ?";
        Connection conn = DBCPDataSource.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, fullname);
        stmt.setString(2, password);
        stmt.setInt(3, id);
        return stmt.executeUpdate();
    }
    private int delete(int id) throws SQLException{
        String sql = "DELETE FROM users WHERE id = ?";
        Connection conn = DBCPDataSource.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        return stmt.executeUpdate();
    }
    public static void main(String[] args) throws SQLException{
        UserDAO dao = new UserDAO();
        String sql = "SELECT * FROM users";
        List<User> users = dao.select(sql, null);
        for (int i=0; i < users.size(); i++)
            System.out.println(users.get(i));

        int id = dao.insert("tomcat", "tomcat", "tomcat");
        System.out.println("new id="+id);
        dao.update(id, "test", "test");
        System.out.println(dao.delete(0));
    }
}