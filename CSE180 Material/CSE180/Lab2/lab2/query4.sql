
/* Find customers who bought tickets to showings of at least 2 different movies. */

/* Version 1: 
DISTINCT is needed in the SELECT clause so that customers who buy 2 or more tickets to different movies don't show up multiple times in result.

Note matching of Primary Key attribute in Customers to corresponding Foreign Key attribute of Tickets as well as matching of Primary Key attributes in Showings to corresponding Foreign Key attributes of Tickets.
*/

SELECT DISTINCT C.customerID, C.name 
FROM Customers AS C, Tickets AS T1, Tickets AS T2, Showings AS S1, Showings AS S2
WHERE (C.name LIKE '%a%' OR C.name LIKE '%A%')

  AND C.customerID = T1.customerID
  AND T1.theaterID = S1.theaterID
  AND T1.showingDate = S1.showingDate
  AND T1.startTime = S1.startTime

  AND C.customerID = T2.customerID
  AND T2.theaterID = S2.theaterID
  AND T2.showingDate = S2.showingDate
  AND T2.startTime = S2.startTime
  AND S1.movieID != S2.movieID;

/* Version 2: 
DISTINCT is not needed in the SELECT clause because there can't be more than one result tuple for each group.

DISTINCT is needed in the HAVING clause to count different movies. 
Otherwise, query would count number of movies seen by  customer, whether or not the movies were different, and a customer could have seen the same movie more than once.

This solution would be easy to modify if question had asked for customers who bought tickets for (for example) 5 or more different movies.
*/

SELECT C.customerID, C.name
FROM Customers C, Tickets T, Showings S
WHERE C.customerID = T.customerID
  AND (C.name LIKE '%a%' OR C.name LIKE '%A%')
  AND T.theaterID = S.theaterID
  AND T.showingDate = S.showingDate      
  AND T.startTime = S.startTime
GROUP BY C.customerID, C.name
HAVING COUNT(DISTINCT S.movieID) >= 2;

/* It's okay NOT to have C.name in the GROUP BY clause because C.customerID appears in the GROUP BY clause, and customerID is the Primary Key of Customers.
*/