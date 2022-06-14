/* There are many other unit tests that pass/fail these constraints */

/* Insert commands that violate Foreign Key constraints. */

/* Violates Foreign key constraint #1 */
INSERT INTO Tickets(theaterID, seatNum, showingDate, startTime, customerID, ticketPrice)
	VALUES(666, 1, DATE '2009-06-23', TIME '11:00:00', 1, 8.50);

/* Violates Foreign key constraint #2 */
INSERT INTO Tickets(theaterID, seatNum, showingDate, startTime, customerID, ticketPrice)
	VALUES(111, 5, DATE '2009-06-23', TIME '11:00:00', 100000, 8.50);

/* Violates Foreign key constraint #3 */
INSERT INTO Tickets(theaterID, seatNum, showingDate, startTime, customerID, ticketPrice)
	VALUES(111, 10, DATE '2009-06-23', TIME '11:00:00', 1, 8.50);

/* General constraints */

/* ticket price, okay */
UPDATE Tickets
SET ticketPrice = 50
WHERE theaterID = 111
  AND seatNum = 1
  and showingDate = DATE '2009-06-23'
  AND startTime = TIME '11:00:00';


/* ticket price, violation */
UPDATE Tickets
SET ticketPrice = -10
WHERE theaterID = 111
  AND seatNum = 1
  and showingDate = DATE '2009-06-23'
  AND startTime = TIME '11:00:00';

/* joinDate, okay */
UPDATE Customers
SET joinDate = DATE '2019-06-23'
WHERE customerID = 1;

/* joinDate, violation */
UPDATE Customers
SET joinDate = DATE '2009-06-23'
WHERE customerID = 1;

/* Showings, okay */
UPDATE Showings
SET priceCode = NULL
WHERE theaterID = 444
  AND showingDate = DATE '2019-06-24'
  AND startTime = TIME '15:00:00';

/* Showings, violation */
UPDATE Showings
SET priceCode = NULL
WHERE movieID IS NOT NULL;
