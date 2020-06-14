package model;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDAO {
    public Product[] getAllProducts() throws SQLException {
        String sql = "SELECT * FROM products";
        Connection conn = DBCPDataSource.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet result = stmt.executeQuery();
        return helper(result);
    }
    public Product getProductsById(int id){
        try {
            String sql = "SELECT * FROM products WHERE id = ?";
            Connection conn = DBCPDataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet result = stmt.executeQuery();
            return helper(result)[0];
        }catch (SQLException e){
            System.out.println(e.getMessage());
            return null;
        }
    }
    private Product[] helper(ResultSet result) throws SQLException {
        ArrayList<Product> products = new ArrayList<Product>();
        while (result.next()) {
            Product p = new Product();
            p.setId(result.getInt("id"));
            p.setTitle(result.getString("title"));
            p.setOverview(result.getString("overview"));
            p.setRelease_date(result.getString("release_date"));
            p.setPoster_path(result.getString("poster_path"));
            p.setGenres(result.getString("genres"));
            p.setPrice(result.getString("price"));
            products.add(p);
        }
        Product[] out = new Product[products.size()];
        return products.toArray(out);
    }
    public static void main(String[] args) throws SQLException{
        ProductDAO pdao = new ProductDAO();
        System.out.println("===== getAllProducts =====");
        Product[] products = pdao.getAllProducts();
        for (int i=0; i < products.length; i++)
            System.out.println(products[i]);
        System.out.println("===== getProductsById =====");
        System.out.println(pdao.getProductsById(10));
    }
}