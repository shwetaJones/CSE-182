SELECT Horses.horseID, Horses.horseName, RacingPersons.personName as horseOwnerTrainerName  
FROM Horses, RacingPersons 
WHERE Horses.trainerID = RacingPersons.personID 
AND RacingPersons.personID = Horses.horseOwnerID  
AND Horses.horseName IS NOT NULL
