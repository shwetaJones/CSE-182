/* CountLastPlaces Query */
SELECT  L.horseID, H.horseName, COUNT(L.HorseID) AS lastCount, MAX(L.finishPosition) AS maxLastPlaceFinish
FROM Horses H, LastPlaceHorsesView L
WHERE L.horseID = H.horseID
GROUP BY L.horseID, H.horseName
HAVING MAX(L.finishPosition)>= 3;

/* CountLastPlaces Query Output - Before Deletions 
 horseid |     horsename     | lastcount | maxlastplacefinish 
---------+-------------------+-----------+--------------------
     530 | Easy Rider        |         1 |                  5
     550 | Tiz the Law       |         2 |                  3
     551 |                   |         4 |                  5
     555 | Essential Quality |         4 |                  7
     575 |                   |         2 |                  3
(5 rows)
*/

/* Deletions SQL Statements */
DELETE FROM HorseRaceResults 
WHERE raceTrackID = 3008
AND raceDate = DATE'2022-02-26'
AND raceNum = 2
AND horseID = 555;

DELETE FROM HorseRaceResults
WHERE raceTrackID = 3001
AND raceDate = DATE'2021-08-11'
AND raceNum = 1
AND horseID = 551;

SELECT  L.horseID, H.horseName, COUNT(L.HorseID) AS lastCount, MAX(L.finishPosition) AS maxLastPlaceFinish
FROM Horses H, LastPlaceHorsesView L
WHERE L.horseID = H.horseID
GROUP BY L.horseID, H.horseName
HAVING MAX(L.finishPosition)>= 3; 

/* CountLastPlaces Query Output - After Deletions
 horseid |     horsename     | lastcount | maxlastplacefinish 
---------+-------------------+-----------+--------------------
     530 | Easy Rider        |         1 |                  5
     550 | Tiz the Law       |         2 |                  3
     553 | Night Rider       |         1 |                  6
     555 | Essential Quality |         3 |                  5
     575 |                   |         2 |                  3
     589 |                   |         2 |                  4
*/
