package utils;

import org.apache.ibatis.datasource.pooled.PooledDataSource;
import org.apache.ibatis.mapping.Environment;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.transaction.jdbc.JdbcTransactionFactory;
import javax.sql.DataSource;

import mapper.UserMapper;
import mapper.ProductMapper;

public class MyBatisUtil {
    public static final String DRIVER = "org.sqlite.JDBC";
	public static final String URL = "jdbc:sqlite:test.db";
	public static final String USERNAME = "sa";
	public static final String PASSWORD = "pass123";
    private static SqlSessionFactory sqlSessionFactory;
    
    public static SqlSessionFactory buildSqlSessionFactory() {
		System.out.println("buildSqlSessionFactory()");
		DataSource dataSource = new PooledDataSource(DRIVER, URL, USERNAME, PASSWORD);
		Environment environment = new Environment("Development", new JdbcTransactionFactory(), dataSource);
		Configuration configuration = new Configuration(environment);
		configuration.addMapper(UserMapper.class);
		configuration.addMapper(ProductMapper.class);
		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		SqlSessionFactory factory = builder.build(configuration);
		return factory;
    }
    public static SqlSessionFactory getSqlSessionFactory() {
		System.out.println("getSqlSessionFactory()");
		if (sqlSessionFactory != null)
			return sqlSessionFactory;
		return buildSqlSessionFactory();
	}
}