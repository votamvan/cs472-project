package mapper;

import org.apache.ibatis.annotations.Param;
import model.User;

public interface UserMapper {
    public User checkLogin(@Param("username") String username, @Param("password") String password);
    public User checkUserExist(@Param("username") String username);
    public Integer addUser(@Param("user") User user);
    public Integer updateUser(@Param("user") User user);
    public Integer deleteUser(@Param("id") Integer id);
}