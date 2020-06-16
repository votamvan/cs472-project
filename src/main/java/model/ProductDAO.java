package model;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import mapper.ProductMapper;
import utils.MyBatisUtil;


public class ProductDAO {

    private String criteria;
    public String getCriteria(){
        return criteria;
    }
    public void setCriteria(String criteria){
        this.criteria = criteria;
    }

    public Product[] getProductsByCriteria(){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        List<Product> _products = mapper.getAllProducts();
        session.close();
        //filter by criteria
        List<Product> products = new java.util.ArrayList<Product>();
        if(criteria != null && criteria != ""){
            //price
            //TODO

            //latest
            //TODO

            //by genre
            for(Product p: _products){
                if(p.getGenres().toUpperCase().contains(criteria.toUpperCase())){
                    products.add(p);
                }
            }
        }else{
            products = _products;
        }
        Product[] out = new Product[products.size()];
        return products.toArray(out);
    }

    public String[] getAllGenres(){
        return new String [] {"Adventure","Action","Animation","Comedy","Crime","Drama","Family","Fantasy","Horror","Mystery","Romance","Science Fiction","Thriller"};
    }

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
    public Product addProduct(Product product){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        if (mapper.addProduct(product) < 0) product.reset();
        session.commit();
        session.close();
        return product;
    }
    public Integer updateProduct(Product product){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        Integer ret = mapper.updateProduct(product);
        session.commit();
        session.close();
        return ret;
    }
    public Integer deleteProduct(Integer id){
        SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
        ProductMapper mapper = session.getMapper(ProductMapper.class);
        Integer ret = mapper.deleteProduct(id);
        session.commit();
        session.close();
        return ret;
    }
    public static void main(String[] args){
        ProductDAO dao = new ProductDAO();
        System.out.println("===== getAllProducts =====");
        Product[] products = dao.getAllProducts();
        for (int i=0; i < products.length; i++)
            System.out.println(products[i]);
        System.out.println("===== getProductsById =====");
        System.out.println(dao.getProductsById(10));
        System.out.println("===== insert/update/delete =====");
        Product product = new Product("aaaa", "aaaa", "aaaa", "aaaa", "aaaa", "aaaa", "aaaa");
        dao.addProduct(product);
        product.setTitle("bbbb");
        dao.updateProduct(product);
        dao.deleteProduct(product.getId());
    }
}