package model;

import org.apache.ibatis.session.SqlSession;
import mapper.UserMapper;
import utils.MyBatisUtil;

public class UserDAO {
    public User checkLogin(String username, String password){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        return mapper.checkLogin(username, password);
    }
    public User addUser(String fullname, String username, String password){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        if (mapper.checkUserExist(username) != null){
            System.out.println("user exist");
            return null;
        }
        User user = new User(0, fullname, username, password);
        if (mapper.addUser(user) <= 0) {
            System.out.println("insert error");
            return null;
        }
        session.commit();
        return user;
    }
    public static void main(String[] args){
        UserDAO dao = new UserDAO();
        System.out.println(dao.checkLogin("admin", "123456"));
        System.out.println(dao.checkLogin("admin", "1234"));
        System.out.println(dao.addUser("admin", "admin", "1234"));
    }
}