/* Look at pairs of movies where one is the 2011 Avengers movie and the other has a greater length.  In your result, movies with the largest year should appear first; within each year, movies should be in alphabetized by name.
*/

/* Version 1:
DISTINCT is not needed because there is (at most) one 2011 Avengers movie.  We look at each OtherMovie  once, outputting its Primary Key in result.
*/

SELECT OtherMovie.movieID, OtherMovie.name, OtherMovie.year, OtherMovie.length 
FROM Movies Avengers, Movies OtherMovie
WHERE Avengers.name = 'Avengers' 
  AND Avengers.year = 2011
  AND OtherMovie.length > Avengers.length
ORDER BY OtherMovie.year DESC, OtherMovie.name ASC;

/* Okay not to write ASC in either version, since the default is ASCENDING */

/* Version 2:

DISTINCT is not needed because we look at each OtherMovie  once, outputting its Primary Key in result.
*/

SELECT OtherMovie.movieID, OtherMovie.name, OtherMovie.year, OtherMovie.length 
FROM Movies OtherMovie
WHERE EXISTS ( SELECT *
               FROM Movies Avengers
	       WHERE Avengers.name = 'Avengers' 
	         AND Avengers.year = 2011
	         AND OtherMovie.length > Avengers.length )
ORDER BY OtherMovie.year DESC, OtherMovie.name ASC;

/* Could also write variation that uses IN or = ANY.  Could even write this using just =, since there can't be more than one 2011 Avengers movie.  That wouldn't be correct if there could be more than one 2011 Avengers movie.
*/

