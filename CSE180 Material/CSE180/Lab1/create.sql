DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE Movies(
	movieID INT,
	name VARCHAR(30),
	year INT, 
	rating CHAR(1), 
	length INT, 
	totalEarned NUMERIC(7,2),
	PRIMARY KEY(movieID)
);

CREATE TABLE Theaters(
	theaterID INT, 
	address VARCHAR(40), 
	numSeats INT,
	PRIMARY KEY(theaterID)
);

CREATE TABLE TheaterSeats(
	theaterID INT, 
	seatNum INT, 
	brokenSeat BOOLEAN,
	PRIMARY KEY(theaterID, seatNum),
	FOREIGN KEY(theaterID) REFERENCES Theaters
);

CREATE TABLE Showings(
	theaterID INT, 
	showingDate DATE, 
	startTime TIME, 
	movieID INT, 
	priceCode CHAR(1),
	PRIMARY KEY(theaterID, showingDate, startTime),
	FOREIGN KEY(theaterID) REFERENCES Theaters,
	FOREIGN KEY(movieID) REFERENCES Movies
);

CREATE TABLE Customers(
	customerID INT, 
	name VARCHAR(30),
	address VARCHAR(40), 
	joinDate DATE, 
	status CHAR(1),
	PRIMARY KEY(customerID)
);

CREATE TABLE Tickets(
	theaterID INT, 
	seatNum INT, 
	showingDate DATE, 
	startTime TIME, 
	customerID INT, 
	ticketPrice NUMERIC(4,2),
	PRIMARY KEY(theaterID, seatNum, showingDate, startTime),
	FOREIGN KEY(customerID) REFERENCES Customers,
	FOREIGN KEY(theaterID, seatNum) REFERENCES TheaterSeats,
	FOREIGN KEY(theaterID, showingDate, startTime) REFERENCES Showings
);
