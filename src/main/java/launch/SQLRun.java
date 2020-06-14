package launch;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;

public class SQLRun {
    final static String url = "jdbc:sqlite:test.db";

    public static void createDatabase() throws SQLException {
        final Connection conn = DriverManager.getConnection(url);
        PreparedStatement stmt = null;
        final String sql[] = {
                // table users
                "CREATE TABLE IF NOT EXISTS users (id integer PRIMARY KEY AUTOINCREMENT,"
                        + "fullname text NOT NULL, username text NOT NULL, password text NOT NULL);",
                "INSERT INTO users VALUES (1, 'Admin User', 'admin', '123456');",
                "INSERT INTO users VALUES (2, 'John Smith', 'smith', '123456');",
                // table products
                "CREATE TABLE IF NOT EXISTS products (id integer PRIMARY KEY AUTOINCREMENT,"
                        + "title text NOT NULL, overview text NOT NULL, price text NOT NULL,"
                        + "genres text, release_date text, poster_path text, imdb_id text);"
        };
        for (int i = 0; i < sql.length; i++) {
            System.out.println(sql[i]);
            stmt = conn.prepareStatement(sql[i]);
            stmt.executeUpdate();
        }
        conn.close();
    }

    public static void importData(final String csvFile) throws SQLException, IOException, CsvException {
        final CSVReader reader = new CSVReader(new FileReader(csvFile));
        List<String[]> list = new ArrayList<String[]>();
        list = reader.readAll();
        reader.close();
        // insert to table <products>
        String columns = String.join(",", list.get(0));
        String sql = "INSERT INTO products(" + columns + ") VALUES(?,?,?,?,?,?,?,?)";
        final Connection conn = DriverManager.getConnection(url);
        final PreparedStatement stmt = conn.prepareStatement(sql);
        for (int r = 1; r < list.size(); r++) {
            final String[] line = list.get(r);
            for (int j = 0; j < line.length; j++)
                stmt.setString(j + 1, line[j]);
            stmt.executeUpdate();
        }
        conn.close();
    }

    public static void main(final String[] args) {
        try {
            createDatabase();
            importData("movies.csv");
        } catch (final Exception e) {
            e.printStackTrace();
        }
    }
}