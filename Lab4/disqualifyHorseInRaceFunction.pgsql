CREATE OR REPLACE FUNCTION
disqualifyHorseInRaceFunction(theHorseID INTEGER, theRacetrackID INTEGER, theRaceDate DATE, theRaceNum INTEGER)
RETURNS INTEGER AS $$


    DECLARE
    	numImproved		INTEGER;
    	theHorseID	INTEGER;
        secondHorseID	INTEGER;
        theFinishPosition	INTEGER;
        val 	INTEGER;
	checkHorseID INTEGER;
	checkFinishPosition INTEGER;

    DECLARE posCursor CURSOR FOR
    	    SELECT hrr.horseID, hrr.finishPosition
            FROM HorseRaceResults hrr
            WHERE hrr.horseID <> theHorseID 
	      AND hrr.racetrackID = theRaceTrackID
              AND hrr.raceDate = theRaceDate
              AND hrr.raceNum = theRaceNum;

    BEGIN 
	SELECT COUNT(*) INTO val 
	FROM HorseRaceResults hrr 
	WHERE hrr.horseID = theHorseID
              AND hrr.racetrackID = theRaceTrackID
              AND hrr.raceDate = theRaceDate
              AND hrr.raceNum = theRaceNum;

	SELECT hrr.horseID, hrr.finishPosition INTO checkHorseID, checkFinishPosition
            FROM HorseRaceResults hrr
            WHERE hrr.horseID = theHorseID 
	      AND hrr.racetrackID = theRaceTrackID
              AND hrr.raceDate = theRaceDate
              AND hrr.raceNum = theRaceNum;

        IF val = 0 THEN
		RETURN -1;
	ELSEIF checkFinishPosition IS  NULL THEN
		RETURN -2;
	ELSE
		UPDATE HorseRaceResults
            	SET finishPosition = NULL
            	WHERE horseID = secondHorseID
            	AND racetrackID = theRacetrackID
            	AND raceDate = theRaceDate
           	AND raceNum = theRaceNum;
		END IF;

	numImproved := 0; 
	
	OPEN posCursor;
        LOOP
 
            FETCH posCursor INTO secondHorseID, theFinishPosition;

            EXIT WHEN NOT FOUND;
	    
	    -- IF theFinishPosition = NULL AND secondHorseID = theHorseID THEN
		-- RETURN -2;
		-- EXIT;
		-- END IF;
	    
            -- UPDATE HorseRaceResults
            -- SET finishPosition = NULL
            -- WHERE horseID = secondHorseID
            -- AND racetrackID = theRacetrackID
            -- AND raceDate = theRaceDate
            -- AND raceNum = theRaceNum;
	    
	    IF theFinishPosition > checkFinishPosition THEN 
		
		
            	UPDATE HorseRaceResults
            	SET finishPosition = finishPosition - 1
            	WHERE finishPosition = theFinishPosition
            	AND racetrackID = theRacetrackID
            	AND raceDate = theRaceDate
            	AND raceNum = theRaceNum;

            	numImproved := numImproved + 1;
		END IF; 

        END LOOP;
        CLOSE posCursor;

    RETURN numImproved;

    END

$$ LANGUAGE plpgsql;
