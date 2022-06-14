/* Could use name of table/view instead of tuple variables */

SELECT M.rating, COUNT(*) 
FROM Movies M, earningsView E
WHERE M.movieID = E.movieID
  AND M.totalEarned != E.computedEarnings
GROUP BY M.rating
HAVING EVERY (M.year < 2019);

/* Okay to write either <> or !=  in the WHERE clause */

/* For COUNT in the SELECT clause, okay to have any attribute that can't be NULL.
   For example, movieID and totalEarned can't be NULL because of the WHERE clause.
*/

/* Could also so equivalent of the HAVING clause using a subquery using the following
   much more complicated query, which loses points for complexity
*/

SELECT M.rating, COUNT(*) 
FROM Movies M, earningsView E
WHERE M.movieID = E.movieID
  AND M.totalEarned != E.computedEarnings
  AND NOT EXISTS ( SELECT *
		   FROM Movies M2, earningsView E2
                   WHERE M2.movieID = E2.movieID
		     AND M2.totalEarned != E2.computedEarnings
		     AND M2.rating = M.rating
	             AND NOT ( M2.year < 2019 )
GROUP BY M.rating;

/* AND NOT ( M2.year < 2019 ) could also be written as  M2.year >= 2019  */

/* All of the stuff in the subquery inside the NOT EXISTS is needed!
   That says that's there's no misreported movies that has the same rating as M
   that wasn't made before 2019.
   The version using HAVING is much easier to write (and understand)
*/