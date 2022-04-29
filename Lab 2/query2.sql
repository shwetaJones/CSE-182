SELECT DISTINCT RacingPersons.personID, RacingPersons.personName, RacingPersons.registryDate
FROM RacingPersons, HorseRaceResults 
WHERE RacingPersons.canBeJockey = FALSE
AND RacingPersons.personID = HorseRaceResults.jockeyID
ORDER BY RacingPersons.personName ASC, RacingPersons.registryDate DESC 
