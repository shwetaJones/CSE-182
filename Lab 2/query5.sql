SELECT DISTINCT Horses.horseID AS theHorseID, Horses.horseName AS theHorseName, RP1.personName AS theOwnerName, Stables.stableName AS theStableName, RP2.personName AS theStableOwnerName 
FROM HorseRaceResults, Horses, Stables, RacingPersons RP1, RacingPersons RP2
WHERE HorseRaceResults.finishPosition = 1
AND HorseRaceResults.horseID = Horses.horseID
AND Stables.stableOwnerID = RP2.personID
AND Horses.stableID = Stables.stableID
AND Horses.horseOwnerID = RP1.personID
AND HorseRaceResults.horseID = Horses.horseID
