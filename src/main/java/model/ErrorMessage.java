package model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ErrorMessage {
    private int id = -1;
    private String message;
    public ErrorMessage(String message){
        this.message = message;
    }
}