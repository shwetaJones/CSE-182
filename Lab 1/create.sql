DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE RacingPersons(
	personID INTEGER PRIMARY KEY,
	personName VARCHAR(30),
	registryDate DATE, 
	canBeJockey BOOLEAN, 
	canBeTrainer BOOLEAN
);

CREATE TABLE Stables(
	stableID INTEGER PRIMARY KEY,
	stableName VARCHAR(30),
	address VARCHAR(50),
	stableOwnerID INTEGER,
	FOREIGN KEY(stableOwnerID) REFERENCES RacingPersons(personID)
);

CREATE TABLE Horses(
	horseID INTEGER PRIMARY KEY, 
	horseName VARCHAR(30), 
	horseBreed CHAR(1),
	birthDate DATE,
	stableID INTEGER, 
	trainerID INTEGER, 
	horseOwnerID INTEGER,
	FOREIGN KEY(stableID) REFERENCES Stables,
	FOREIGN KEY(trainerID) REFERENCES RacingPersons(personID),
	FOREIGN KEY(horseOwnerID) REFERENCES RacingPersons(personID)	
);

CREATE TABLE Racetracks(
	racetrackID INTEGER PRIMARY KEY, 
	trackName VARCHAR(30), 
	address VARCHAR(50), 
	trackDistance NUMERIC(3, 1)
);

CREATE TABLE Races(
	racetrackID INTEGER, 
	raceDate DATE, 
	raceNum INTEGER, 
	raceStartTime TIME, 
	winningPrize NUMERIC(7, 2),
	PRIMARY KEY(racetrackID, raceDate, raceNum),
	FOREIGN KEY(racetrackID) REFERENCES Racetracks
);

CREATE TABLE HorseRaceResults(
	racetrackID INTEGER, 
	raceDate DATE, 
	raceNum INTEGER, 
	horseID INTEGER, 
	jockeyID INTEGER,
	finishPosition INTEGER,
	raceFinishTime TIME,
	PRIMARY KEY(racetrackID, raceDate, raceNum, horseID),
	FOREIGN KEY (racetrackID, raceDate, raceNum) REFERENCES Races,
	FOREIGN KEY (horseID) REFERENCES Horses,
	FOREIGN KEY (jockeyID) REFERENCES RacingPersons(personID)
);
