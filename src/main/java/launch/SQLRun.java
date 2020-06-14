package launch;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SQLRun {
    static String BASE_URL = "https://raw.githubusercontent.com/votamvan/votamvan.github.io/master/lab13/data/";
    static String[] photos = {
        BASE_URL + "toygame/aqua.jpg",
        BASE_URL + "toygame/splashez.jpg",
        BASE_URL + "toygame/zuru.jpg",
        BASE_URL + "electronic/echo3.jpg",
        BASE_URL + "electronic/firetv.jpg",
        BASE_URL + "electronic/fire7.jpg",
        BASE_URL + "cameraphoto/wyze.jpg",
        BASE_URL + "cameraphoto/wansview.jpg",
        BASE_URL + "cameraphoto/zumi.jpg",
        BASE_URL + "videogame/playstation.jpg",
        BASE_URL + "videogame/nintendo.jpg",
        BASE_URL + "videogame/xbox.jpg",
        BASE_URL + "book/white.jpg",
        BASE_URL + "book/antiracist.jpg",
        BASE_URL + "book/covid19.jpg"
    };
    public static void createDatabase(String fileName) throws SQLException{
        String url = "jdbc:sqlite:" + fileName;
        String sql[] = {
            "CREATE TABLE IF NOT EXISTS users (id integer PRIMARY KEY AUTOINCREMENT, fullname text NOT NULL, username text NOT NULL, password text NOT NULL);",
            "INSERT INTO users VALUES (1, 'Admin User', 'admin', '123456');",
            "INSERT INTO users VALUES (2, 'John Smith', 'smith', '123456');",
            "CREATE TABLE IF NOT EXISTS products (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, price text NOT NULL, category text NOT NULL, photo text);",
            "INSERT INTO products VALUES (1, 'Aqua 4-in-1 Monterey Hammock Inflatable Pool Float', '13.54','Toys & Games', '1.png');",
            "INSERT INTO products VALUES (2, 'SplashEZ USA 3-in-1 Splash Pad', '24.99','Toys & Games', '2.png');",
            "INSERT INTO products VALUES (3, 'Inflatable Splash Pad Sprinkler for Kids Toddlers', '25.45','Toys & Games', '3.png');",
            "INSERT INTO products VALUES (4, 'Echo Dot (3rd Gen)', '49.99','Electronics', '4.png');",
            "INSERT INTO products VALUES (5, 'Fire TV Stick streaming media player with Alexa built in', '39.99','Electronics', '5.png');",
            "INSERT INTO products VALUES (6, 'Electronics', '49.99','Electronics', '6.png' );",
            "INSERT INTO products VALUES (7, 'Wyze Cam Pan 1080p Pan/Tilt/Zoom Wi-Fi Indoor Smart Home Camera with Night Vision', '37.98','Camera & Photo', '7.png');",
            "INSERT INTO products VALUES (8, 'Wansview Wireless Security Camera', '29.99','Camera & Photo', '8.png' );",
            "INSERT INTO products VALUES (9, 'Wireless Rechargeable Battery Powered WiFi Camera', '61.19','Camera & Photo', '9.png' );",
            "INSERT INTO products VALUES (10, '$10 PlayStation Store Gift Card', '10.00','Video Games', '10.png' );",
            "INSERT INTO products VALUES (11, '$10 Nintendo eShop Gift Card', '9.99','Video Games', '11.png' );",
            "INSERT INTO products VALUES (12, '$10 Xbox Gift Card', '10.00','Video Games', '12.png' );",
            "INSERT INTO products VALUES (13, 'White Fragility: Why It''s So Hard for White People to Talk About Racism', '12.24','Books', '13.png' );",
            "INSERT INTO products VALUES (14, 'How to Be an Antiracist', '16.26','Books', '14.png' );",
            "INSERT INTO products VALUES (15, 'Unreported Truths about COVID-19 and Lockdowns', '5.99','Books', '15.png' );"
        };
        Connection conn = DriverManager.getConnection(url);
        PreparedStatement stmt = null; 
        for (int i = 0; i < sql.length; i++) {
            System.out.println(sql[i]);
            stmt = conn.prepareStatement(sql[i]);
            stmt.executeUpdate();
        }
        // update photo url
        stmt = conn.prepareStatement("UPDATE products SET photo = ? WHERE id = ?");
        for (int i = 0; i < photos.length; i++) {
            stmt.setString(1, photos[i]);
            stmt.setInt(2, i+1);
            stmt.executeUpdate();
        }
        conn.close();
    }
    public static void main(String[] args) {
        try {
            createDatabase("test.db");
        }catch(SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}