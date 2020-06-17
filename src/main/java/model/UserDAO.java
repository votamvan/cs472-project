package model;

import java.util.List;
import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import org.apache.ibatis.session.SqlSession;
import mapper.UserMapper;
import utils.MyBatisUtil;

public class UserDAO {
    public List<User> getAllUsers() {
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        List<User> users = mapper.getAllUsers();
        session.close();
        return users;
    }
    public boolean checkUserExist(User user){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        User user2 = mapper.checkUserExist(user.getUsername());
        session.close();
        if (user2 == null) return false;
        return user2.getId() != user.getId();
    }
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
    public User addUser(User user){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        UserMapper mapper = session.getMapper(UserMapper.class);
        if (mapper.checkUserExist(user.getUsername()) != null){
            System.out.println("user exist");
            session.close();
            return null;
        }else {
            mapper.addUser(user);
        }
        session.commit();
        session.close();
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
        User user = dao.addUser("admin2", "admin2", "1234");
        System.out.println(user);
        dao.validator(new User(0, "admin2", "", ""));
        user.setFullname("fullname admin2");
        dao.updateUser(user);
        dao.deleteUser(user.getId());
    }
    public String validator(User user){
        String message = "";
        ValidatorFactory vf = Validation.buildDefaultValidatorFactory();
        Validator validator = vf.getValidator();
        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);
        for (ConstraintViolation<User> cv : constraintViolations) {
            message += String.format("%s: %s. ", cv.getPropertyPath(), cv.getMessage());
        }
        System.out.println(message);
        return message;
    }
}