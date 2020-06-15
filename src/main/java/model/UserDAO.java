package model;

import org.apache.ibatis.session.SqlSession;
import mapper.UserMapper;
import utils.MyBatisUtil;

public class UserDAO {
    public User checkLogin(String username, String password){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        User user = mapper.checkLogin(username, password);
        session.close();
        return user;
    }
    public User addUser(String fullname, String username, String password){
        SqlSession session = null;
        User user = null;
        try{
            session = MyBatisUtil.getSqlSessionFactory().openSession();
            UserMapper mapper = session.getMapper(UserMapper.class);
            if (mapper.checkUserExist(username) != null){
                System.out.println("user exist");
                return null;
            }
            user = new User(0, fullname, username, password);
            if (mapper.addUser(user) <= 0) {
                System.out.println("insert error");
                return null;
            }
            session.commit();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            if (session != null) session.close();
        }
        return user;
    }
    public Integer updateUser(User user){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        Integer ret = mapper.updateUser(user);
        session.commit();
        session.close();
        return ret;
    }
    public Integer deleteUser(Integer id){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        Integer ret = mapper.deleteUser(id);
        session.commit();
        session.close();
        return ret;
    }
    public static void main(String[] args){
        UserDAO dao = new UserDAO();
        System.out.println(dao.checkLogin("admin", "123456"));
        User user = dao.addUser("admin1", "admin1", "1234");
        System.out.println(user);
        user.setFullname("fullname admin2");
        dao.updateUser(user);
        dao.deleteUser(user.getId());
    }
}