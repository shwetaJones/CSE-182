BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
/* Okay to have READ WRITE; okay to say WORK instead of TRANSACTION */

UPDATE Showings S
SET movieID = M.movieID
FROM ModifyShowings M
WHERE S.theaterID = M.theaterID
  AND S.showingDate = M.showingDate
  AND S.startTime = M.startTime;

INSERT INTO Showings
SELECT theaterID, showingDate, startTime, movieID, NULL
FROM ModifyShowings M
WHERE NOT EXISTS( SELECT *
		  FROM Showings S
		  WHERE M.theaterID = S.theaterID
		    AND M.showingDate = S.showingDate
		    AND M.startTime = S.startTime );

COMMIT TRANSACTION;

/* Writing the INSERT before the UPDATE will lose some credit, before the data that 
was inserted will also be updated unnecessarily.  Yes, the result will be the same, 
but it's extra effort. 
*/

/* Here's another correct way to write the UPDATE */

UPDATE Showings S
SET movieID = M.movieID
FROM ModifyShowings M
WHERE S.theaterID = M.theaterID
  AND S.showingDate = M.showingDate
  AND S.startTime = M.startTime
  AND S.movieID != M.movieID;

*/


