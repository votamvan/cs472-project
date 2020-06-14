package model;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBCPDataSource {
    private static Connection conn;
    private static String url = "jdbc:sqlite:test.db";
    private DBCPDataSource() {}
    public static Connection getConnection() throws SQLException {
        if (conn == null || conn.isClosed()) {
            conn = DriverManager.getConnection(url);
        }
        return conn;
    }
}