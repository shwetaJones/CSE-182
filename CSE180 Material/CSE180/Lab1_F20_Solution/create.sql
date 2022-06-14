-- No points will be deducted if the below two lines are not included.
DROP SCHEMA Lab1 CASCADE; 
CREATE SCHEMA Lab1; 

-- 1. When Primary key is a single attribute,it can either be written next to the attribute or as a separate declaration.
-- 2. Data type definitions are not case sensitive, nor are identifiers and keywords such as CREATE, PRIMARY KEY or FOREIGN KEY.
-- 3. Spacing does not matter.
-- 4. No points will be deducted for using INT instead of INTEGER, DECIMAL instead of NUMERIC or CHARACTER instead of CHAR.
-- 5. Comments are not required.
-- 6. Foreign key can be specified in two ways either by referencing the table name e.g. FOREIGN KEY(houseID) REFERENCES Houses or by adding the referenced attribute in the foreign key specification e.g. FOREIGN KEY(houseID) REFERENCES Houses(houseId). Either way is okay.


-- Table creation for Lab1

-- Houses(houseID, address, ownerID, mostRecentSaleDate)
CREATE TABLE Houses (
	houseID INTEGER, 
	address VARCHAR(50), 
	ownerID INTEGER, 
	mostRecentSaleDate DATE,
	PRIMARY KEY(houseID)
);
 -- houseID INTEGER PRIMARY KEY is also correct
 
 

-- Persons(personID, personName, address)
CREATE TABLE Persons (
	personID INTEGER, 
	personName VARCHAR(30), 
	address VARCHAR(50),
	PRIMARY KEY(personID)
);
 -- personID INTEGER PRIMARY KEY is also correct
 
 

-- Brokers(brokerID, brokerLevel, companyName, soldCount)
CREATE TABLE Brokers (
	brokerID INTEGER,
	brokerLevel CHAR(1),
	companyName VARCHAR(30),
	soldCount INTEGER,
	PRIMARY KEY(brokerID)
);
-- brokerID INTEGER PRIMARY KEY is also correct



-- Offers(houseID, offererID, offerDate, offerPrice, isACurrentOffer)
CREATE TABLE Offers (
	houseID INTEGER,
	offererID INTEGER,
	offerDate DATE,
	offerPrice NUMERIC(10,2),
	isACurrentOffer BOOLEAN,
	PRIMARY KEY(houseID,offererID,offerDate),
	FOREIGN KEY(houseID) REFERENCES Houses
);
-- offerPrice DECIMAL(10,2) is also correct
-- FOREIGN KEY(houseID) REFERENCES Houses(houseId) is also correct



-- ForSaleHouses(houseID, forSaleDate, brokerID, forSalePrice, isStillForSale)
CREATE TABLE ForSaleHouses (
	houseID INTEGER,
	forSaleDate DATE,
	brokerID INTEGER,
	forSalePrice NUMERIC(10,2),
	isStillForSale BOOLEAN,
	PRIMARY KEY(houseID,forSaleDate),
	FOREIGN KEY(houseID) REFERENCES Houses
);
-- forSalePrice DECIMAL(10,2) is also correct,
-- FOREIGN KEY(houseID) REFERENCES Houses(houseId) is also correct
 
 

-- SoldHouses(houseID, forSaleDate, soldDate, buyerID, soldPrice)
CREATE TABLE SoldHouses (
	houseID INTEGER,
	forSaleDate DATE,
	soldDate DATE,
	buyerID INTEGER,
	soldPrice NUMERIC(10,2),
	PRIMARY KEY(houseID,forSaleDate),
	FOREIGN KEY(houseID,forSaleDate) REFERENCES ForSaleHouses
);
-- soldPrice DECIMAL(10,2) is also correct
-- FOREIGN KEY(houseID,forSaleDate) REFERENCES ForSaleHouses(houseId,forSaleDate) is also correct