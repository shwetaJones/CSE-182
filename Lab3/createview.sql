CREATE VIEW LastPlaceHorsesView AS
SELECT DISTINCT H.horseID, H.raceTrackID, H.raceDate, H.raceNum, H.finishPosition  
FROM HorseRaceResults H
WHERE H.finishPosition >= ALL (SELECT R.finishPosition
	FROM HorseRaceResults R
	WHERE R.raceTrackID = H.raceTrackID 
	AND R.raceDate = H.raceDate
	AND R.raceNum = H.raceNum);
