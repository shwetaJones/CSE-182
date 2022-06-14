import java.sql.*;
import java.util.*;

public class MovieTheaterApplication {

    private Connection connection;

    /*
     * Constructor
     */
    public MovieTheaterApplication(Connection connection) {
        this.connection = connection;
    }

    public Connection getConnection()
    {
        return connection;
    }

    public Integer getShowingsCount(String thePriceCode)
    {
        Integer result = 0;
        if(!(thePriceCode.equals("A") || thePriceCode.equals("B") || thePriceCode.equals("C"))){
            System.out.println("PriceCode entered was not A/B/C");
        }

        try {
            String query = "select count(*) from \"Lab4\".Showings where priceCode = ?";
            PreparedStatement statement = connection.prepareStatement(query);
                                        statement.setString(1, thePriceCode);
                                        statement.executeQuery();
            ResultSet resultSet = statement.getResultSet();
            resultSet.next();
            result = resultSet.getInt(1);
            resultSet.close();
            statement.close();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public int updateMovieName(int theMovieID, String newMovieName)
    {
        int result = 0;
        try{
            String query = "Update \"Lab4\".Movies Set name = ? where movieID = ?";
            PreparedStatement statement = connection.prepareStatement(query);
                                statement.setString(1,newMovieName);
                                statement.setInt(2,theMovieID);
                                statement.execute();
            result = statement.getUpdateCount();
            statement.close();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        
        return result;
    }

    public int reduceSomeTicketPrices (int maxTicketCount)
    {
        // There's nothing special about the name storedFunctionResult
        int storedFunctionResult = 0;

        // your code here
        if (maxTicketCount <= 0) {
            System.exit(-1);
        }
        try {
            String query ="SELECT \"Lab4\".reducesometicketpricesfunction(?)";

            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, maxTicketCount);
            statement.executeQuery();
            ResultSet resultSet = statement.getResultSet();

            if (resultSet.next())
                storedFunctionResult = resultSet.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return storedFunctionResult;

    }

};