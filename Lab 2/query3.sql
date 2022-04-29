SELECT HorseRaceResults.horseID, HorseRaceResults.raceDate, HorseRaceResults.finishPosition, HorseRaceResults.raceFinishTime-Races.raceStartTime AS horseRaceInterval
FROM HorseRaceResults, Races, Horses 
WHERE HorseRaceResults.raceFinishTime-Races.raceStartTime > INTERVAL '00:02:00'
AND Races.raceDate < '2021-12-14'
AND HorseRaceResults.horseID = Horses.horseID 
AND HorseRaceResults.raceDate = Races.raceDate
AND HorseRaceResults.raceTrackID = Races.raceTrackID
AND HorseRaceResults.raceNum = Races.raceNum
