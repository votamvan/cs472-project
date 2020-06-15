package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import model.Product;

public interface ProductMapper {
    public List<Product> getAllProducts();
    public Product getProductsById(@Param("id") Integer id);
    public Integer addProduct(@Param("product") Product product);
    public Integer updateProduct(@Param("product") Product product);
    public Integer deleteProduct(@Param("id") Integer id);
}