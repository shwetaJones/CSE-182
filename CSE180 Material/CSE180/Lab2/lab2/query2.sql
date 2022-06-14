/* Find the name and year of all movies for which a customer named Donald Duck bought a ticket.
*/

/* Version 1:
Note matching of Primary Key attribute of Customers to corresponding Foreign Key attribute of Tickets as well as matching of Primary Key attributes in Showings to corresponding Foreign Key attributes in Tickets.

DISTINCT is needed because a customer could have bought tickets to more than one showing of the same movie.  Moreover, there could be more than one customer named Donald Duck, so two customers with that name could have bought tickets to the same movie showing
*/

SELECT DISTINCT M.name, M.year 
FROM Customers C, Tickets T, Showings S, Movies M
WHERE C.name = 'Donald Duck'
  AND C.customerID = T.customerID
  AND T.theaterID = S.theaterID
  AND T.showingDate = S.showingDate
  AND T.startTime = S.startTime
  AND S.movieID = M.movieID;

/* Version 2. 
DISTINCT is not needed because for each movie in Movies, the WHERE clause will be evaluated exactly once, and the key of Movies is output in the result.
*/

SELECT M.name, M.year
FROM Movies M
WHERE EXISTS ( SELECT *
               FROM Customers C, Tickets T, Showings S
               WHERE C.name = 'Donald Duck' 
                 AND C.customerID = T.customerID
                 AND T.theaterID = S.theaterID
                 AND T.showingDate = S.showingDate
                 AND T.startTime = S.startTime
                 AND M.movieID = S.movieID );
