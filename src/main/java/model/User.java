package model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User {
    private int id;
    private String username;
    private String password;
    private String fullname;
    private String role;
    User(int id, String fullname, String username, String password){
        this.id = id;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
    }
}