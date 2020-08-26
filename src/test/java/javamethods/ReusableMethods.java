
/**
 * Created by Michelle Ye
 */

package javamethods;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.util.Calendar;


public class ReusableMethods {


    final static Logger log = LogManager.getLogger(String.valueOf(ReusableMethods.class));

    public static int InvalidateOAT(String url,String user,String password,String accountToken) throws ClassNotFoundException, SQLException {

        String SQL = "update accounts set inactivetime=now() where accounttoken='"+ accountToken+"';";
        String dbUrl = "jdbc:postgresql://"+url;
//        System.out.println("Invalidate OAT Query: " + SQL);
        int affectedrows = 0;
        Connection c = null;
        try {

            Class.forName("org.postgresql.Driver");
            c = DriverManager.getConnection(dbUrl, user, password);
            PreparedStatement pstmt = c.prepareStatement(SQL);
            affectedrows = pstmt.executeUpdate();
//            System.out.println("Rows affected " + affectedrows);
        } catch (SQLException ex) {
            System.out.println("Exception " + ex.getMessage());

        }
        return affectedrows;
    }



}



