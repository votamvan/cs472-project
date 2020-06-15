package model;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;
import mapper.ProductMapper;
import utils.MyBatisUtil;


public class ProductDAO {
    public Product[] getAllProducts(){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        List<Product> products = mapper.getAllProducts();
        session.close();
        Product[] out = new Product[products.size()];
        return products.toArray(out);
    }
    public Product getProductsById(int id){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        Product p = mapper.getProductsById(id);
        session.close();
        return p;
    }
    public static void main(String[] args){
        ProductDAO dao = new ProductDAO();
        System.out.println("===== getAllProducts =====");
        Product[] products = dao.getAllProducts();
        for (int i=0; i < products.length; i++)
            System.out.println(products[i]);
        System.out.println("===== getProductsById =====");
        System.out.println(dao.getProductsById(10));
    }
}