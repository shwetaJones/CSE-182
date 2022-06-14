BEGIN TRANSACTION;

UPDATE RacingPersons R
SET canBeTrainer = TRUE 
FROM ChangeRacingPersons C
WHERE R.personID = C.personID;

INSERT INTO RacingPersons
SELECT personID, personName, registryDate, TRUE, TRUE
FROM ChangeRacingPersons C
WHERE NOT EXISTS(SELECT *
	FROM RacingPersons S
	WHERE S.personID = C.personID);

COMMIT TRANSACTION;

