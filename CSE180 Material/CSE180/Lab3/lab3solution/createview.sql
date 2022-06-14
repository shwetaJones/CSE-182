/* Solution #1, using UNION of the sum of ticket prices for movies that have showings
   with tickets, together with 0 as the sum of ticket prices for movies that don't have
   showings with tickets.
*/

CREATE VIEW earningsView AS 

      /* Get computed earnings for movies that have showings with tickets. */

      ( SELECT S.movieID, SUM(T.ticketPrice) as computedEarnings
	FROM Showings S, Tickets T
	WHERE S.theaterID = T.theaterID
	  AND S.showingDate = T.showingDate
	  AND S.startTime = T.startTime
	  AND S.movieID IS NOT NULL
	GROUP BY S.movieID )

	UNION

      /* The computed earnings is 0 for movies that have NO showings with tickets. */ 

      ( SELECT M.movieID, 0 as computedEarnings
	FROM Movies M
	WHERE NOT EXISTS( SELECT * FROM Showings S, Tickets T
			  WHERE S.theaterID = T.theaterID
			    AND S.showingDate = T.showingDate
			    AND S.startTime = T.startTime
			    AND S.movieID IS NOT NULL
			    AND M.movieID = S.movieID) );

/* We'll give full credit if you wrote the first part of the UNION without checking
   whether S.movieID IS NOT NULL.  Same applies to Solutions #2 and #2 below.
*/

/* Solution #2, using a second view that gets computed earnings for each movie that
   has showings with tickets
*/

CREATE VIEW computedEarningsView AS
	SELECT S.movieID, SUM(T.ticketPrice) AS computedEarnings
	FROM Showings S, Tickets T
	WHERE S.theaterID = T.theaterID
	  AND S.showingDate = T.showingDate
	  AND S.startTime = T.startTime
	  AND S.movieID IS NOT NULL
	GROUP BY S.movieID;

CREATE VIEW earningsView AS
	SELECT M.movieID, CASE 
			    WHEN Cev.computedEarnings IS NOT NULL
			    THEN Cev.computedEarnings
			    ELSE 0
			  END
	FROM Movies M LEFT OUTER JOIN computedEarningsView Cev
        WHERE M.movieID = Cev.movieID;

/* Could use  ON M.movieID = Cev.movieID  instead of  WHERE M.movieID = Cev.movieID
   in both Solution #2 and Solution #3
*/

/* Those who've learned about COALESCE (which we'll discuss later) could simplify the
   SELECT clause by writing:

	SELECT M.movieID, COALESCE(Cev.computedEarnings, 0)

   This could also be used in Solution #3.
*/

/* Solution #3 is similar to Solution #2, but instead of defining computedEarningsView
   as a view, it uses a query for it in the FROM clause, with tuple variable CE.  
*/

CREATE VIEW earningsView AS 
	SELECT M.movieID, CASE 
			    WHEN CE.computedEarnings IS NOT NULL
			    THEN CE.computedEarnings
			    ELSE 0
			  END
	FROM Movies M LEFT OUTER JOIN
		( SELECT S.movieID, SUM(T.ticketPrice) AS computedEarnings
		  FROM Showings S, Tickets T
		  WHERE S.theaterID = T.theaterID
		    AND S.showingDate = T.showingDate
		    AND S.startTime = T.startTime
		    AND S.movieID IS NOT NULL
		  GROUP BY S.movieID ) CE 
		WHERE M.movieID = CE.movieID;