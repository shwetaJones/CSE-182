SELECT DISTINCT Racetracks.racetrackID, Racetracks.trackName, Racetracks.trackDistance
FROM Racetracks, Races 
WHERE trackDistance < 20
AND Racetracks.address LIKE '_e%'  
AND Racetracks.trackName LIKE '%Park'
AND Racetracks.racetrackID NOT IN (SELECT Races.racetrackID FROM Races) 
