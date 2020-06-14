package model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ShoppingItem {
    private int id;
    private int userId;
    private Product product;
    private int quantity;
    private String createDate;
    public void addQuantity(int q){
        this.quantity += q;
    }
    public String getSubTotal(){
        return String.format("%.2f", Double.valueOf(this.product.getPrice())*quantity);
    }
}