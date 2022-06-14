/* Find ID and address for theaters have have at least one broken seat. */

/* Version 1
DISTINCT is needed in this version because a theater can have more than one brokenSeat,in which case the result would include that theater more than once.

Okay to write "TheaterSeats.brokenSeat = TRUE" instead of "TheaterSeats.brokenSeat"  
in both Version 1 and Version 2. 
*/

SELECT DISTINCT Theaters.theaterID, Theaters.address 
FROM Theaters, TheaterSeats
WHERE Theaters.theaterID = TheaterSeats.theaterID
  AND TheaterSeats.brokenSeat;

/* Version 2
DISTINCT is not needed in this version because the WHERE clause will be TRUE only once for each theater in Theaters, no matter how many broken seats it has, and the Primary Key of Theaters appears in the result.
*/

SELECT theaterID, address
FROM Theaters
WHERE theaterID IN ( SELECT theaterID 
		     FROM TheaterSeats 
		      WHERE brokenSeat );

