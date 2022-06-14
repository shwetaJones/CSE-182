/* Foreign Key constraints do not have to be named.  */

/* For all Foreign Key constraints, could explicitly indicated Referenced column, 
   e.g., writing:
        REFERENCES Showings(theaterID, showingDate, startTime) 
    for first constraint
*/

/* First Foreign Key Constraint */
ALTER TABLE Tickets 
	ADD CONSTRAINT showing_constraint FOREIGN KEY(theaterID, showingDate, startTime) 
	REFERENCES Showings;

/* An equivalent way to write first Foreign Key Constraint */
ALTER TABLE Tickets 
	ADD CONSTRAINT showing_constraint FOREIGN KEY(theaterID, showingDate, startTime) 
	REFERENCES Showings 
		ON DELETE RESTRICT 
		ON UPDATE RESTRICT;

/* Could write DEFAULT instead of RESTRICT */



/* Second Foreign Key Constraint */
ALTER TABLE Tickets 
	ADD CONSTRAINT customer_constraint FOREIGN KEY(customerID) 
	REFERENCES Customers 
		ON DELETE SET NULL 
		ON UPDATE CASCADE;



/* Third Foreign Key Constraint */
ALTER TABLE Tickets 
	ADD CONSTRAINT theater_constraint FOREIGN KEY(theaterID, seatNum) 
	REFERENCES TheaterSeats 
		ON DELETE CASCADE 
		ON UPDATE CASCADE;