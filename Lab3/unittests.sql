/* Tests: Foreign Key Constraint */
INSERT INTO Horses(horseID, horseName, horseBreed, birthDate, stableID, trainerID, horseOwnerID)
VALUES(553, 'Night Rider', 'A', DATE'2019-05-13', 1010, 6008, 6007);

INSERT INTO Horses(horseID, horseName, horseBreed, birthDate, stableID, trainerID, horseOwnerID)
VALUES(553, 'Night Rider', 'A', DATE'2019-05-13', 1004, 6056, 6007);

INSERT INTO Horses(horseID, horseName, horseBreed, birthDate, stableID, trainerID, horseOwnerID)
VALUES(553, 'Night Rider', 'A', DATE'2019-05-13', 1004, 6008, 6021);

/*Tests: General Key #1 Constraints */
/*Passes: */
UPDATE Racetracks
SET trackDistance = 50
WHERE racetrackID = 3056;
/*Violation*/
UPDATE Racetracks
SET trackDistance = -50
WHERE racetrackID = 3056;

/*Tests: General Key #2 Constraints */
/*Passes: */
UPDATE Horses 
SET horseOwnerID = 6021
WHERE horseID = 551; 
/*Violation*/
UPDATE Horses
SET horseOwnerID = 6005
WHERE horseID = 551;

/*Tests: General Key #3 Constraints */
/*Passes: */
UPDATE Races 
SET winningPrize = 13000
WHERE racetrackID = 3022 
AND raceDate = DATE'2021-12-25'
AND raceNum = 2;
/*Violation*/
UPDATE Races
SET winningPrize = 10000
WHERE racetrackID = 3022 
AND raceDate = DATE'2021-12-25'
AND raceNum = 2;
