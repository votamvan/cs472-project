package model;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class User {
    private int id;
    @NotNull
    @Size(min=5, max=32)
    private String username;
    @NotNull
    @Size(min=6, max=32)
    private String password;
    @NotNull
    @Pattern(regexp="^[a-zA-Z0-9\s]{3,100}", message="length must greater than 3")
    private String fullname;
    private String role;
    public User(int id, String fullname, String username, String password){
        this.id = id;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
    }
    public void reset(){
        this.id = -1;
        this.username = null;
        this.password = null;
        this.fullname = null;
        this.role = null;
    }
}