
 /* Name is needed for this constraint, but it doesn't have to be positive_tickePrice. */

ALTER TABLE Tickets 
ADD CONSTRAINT positive_tickePrice 
    CHECK(ticketPrice > 0);



/* Name is not required for this constraint, but okay to have name. */

ALTER TABLE Customers 
ADD CONSTRAINT joinDate_constraint 
  CHECK(joinDate >= DATE '2015-11-27');

/* Could also write date constant as DATE '11/27/2015 
   Could also write:   CHECK( NOT(joinDate < DATE '2015-11-27') )  
*/



/* Name is not required for this constraint, but okay to have name. */
/* As described in class, IF A THEN B logically correspond to (NOT A) OR B */

ALTER TABLE Showings 
ADD CHECK( (movieID IS NULL) OR (priceCode IS NOT NULL) );

/* The extra parenthesis around the two conditions aren't necessary. */
   There are other logically equivalent ways to write this constraint, such as
	CHECK( (movieID IS NULL AND priceCode IS NULL) OR (priceCode IS NOT NULL) 
*/
