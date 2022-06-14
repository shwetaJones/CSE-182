import java.sql.*;
import java.io.*;
import java.util.*;

/**
 * A class that connects to PostgreSQL and disconnects.
 * You will need to change your credentials below, to match the usename and password of your account
 * in the PostgreSQL server.
 * The name of your database in the server is the same as your username.
 * You are asked to include code that tests the methods of the MovieTheaterApplication class
 * in a similar manner to the sample RunFilmsApplication.java program.
*/


public class RunMovieTheaterApplication
{
    public static void main(String[] args) {
    	
    	Connection connection = null;
    	try {
    	    //Register the driver
    		Class.forName("org.postgresql.Driver"); 
    	    // Make the connection.
            // You will need to fill in your real username (twice) and password for your
            // Postgres account in the arguments of the getConnection method below.
            connection = DriverManager.getConnection(
                                                     "jdbc:postgresql://cse180-db.lt.ucsc.edu/",
                                                     "",
                                                     "");
            
            if (connection != null)
                System.out.println("Connected to the database!");

            /* Include your code below to test the methods of the MovieTheaterApplication class.
             * The sample code in RunFilmsApplication.java should be useful.
             * That code tests other methods for a different database schema.
             * Your code below: */
            
            MovieTheaterApplication app = new MovieTheaterApplication(connection);

            String priceCode = "B";
            Integer showingsCount = app.getShowingsCount(priceCode);
            System.out.println(String.format("/* \n* Output of getShowingsCount \n* when the parameter thePriceCode is ‘%s’. \n%d \n*/", priceCode, showingsCount));

            Integer theMovieID = 101;
            String newMovieName = "Avatar 1";
            Integer updateResult = app.updateMovieName(theMovieID, newMovieName);
            System.out.println(String.format("/* \n* Output of updateMovieName when theMovieID is %d\n* and newMovieName is ‘%s’\n%d\n*/", theMovieID, newMovieName, updateResult));

            theMovieID = 888;
            newMovieName = "Star Wars: A New Hope";
            updateResult = app.updateMovieName(theMovieID, newMovieName);
            System.out.println(String.format("/* \n* Output of updateMovieName when theMovieID is %d \n* and newMovieName is ‘%s’\n%d\n*/", theMovieID, newMovieName, updateResult));

            Integer reductionResult = app.reduceSomeTicketPrices(15);
            System.out.println(String.format("/* \n* Output of reduceSomeTicketPrices when maxTicketCount is %d \n%d\n*/", 15, reductionResult));
            reductionResult = app.reduceSomeTicketPrices(99);
            System.out.println(String.format("/* \n* Output of reduceSomeTicketPrices when maxTicketCount is %d \n%d\n*/", 99, reductionResult));

            
            /*******************
            * Your code ends here */
            
    	}
    	catch (SQLException | ClassNotFoundException e) {
    		System.out.println("Error while connecting to database: " + e);
    		e.printStackTrace();
    	}
    	finally {
    		if (connection != null) {
    			// Closing Connection
    			try {
					connection.close();
				} catch (SQLException e) {
					System.out.println("Failed to close connection: " + e);
					e.printStackTrace();
				}
    		}
    	}
    }
}
