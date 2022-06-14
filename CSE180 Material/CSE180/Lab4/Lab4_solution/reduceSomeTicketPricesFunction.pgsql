-- Solution #1: This solution orders record by priceCode and customerID in ascending order. So, all we have to do is update first maxTicketCount rows.

CREATE OR REPLACE FUNCTION reduceSomeTicketPricesFunction(maxTicketCount INTEGER)
RETURNS INTEGER AS $$

	DECLARE

	reduction INTEGER;
	newPrice NUMERIC(4,2);
 	changeCount INTEGER;
 	reductionPerTicket INTEGER;
 	
 	ftheaterID INTEGER;
 	fshowingDate DATE;
 	fstartTime TIME;
 	fpriceCode CHAR(1);
 	fseatNum INTEGER;
 	fticketPrice NUMERIC(4,2);

 	DECLARE ticketCursor CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM ticketCursor T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  ORDER BY S.priceCode ASC, T.customerID ASC; -- Use of ASC is okay but not necessary.

	BEGIN

	    -- Input Validation
	    IF maxTicketCount < 0 THEN
	    	RETURN -1;
	    END IF;
		reduction = 0;
	 	changeCount = 0;

	 	OPEN ticketCursor;

	 	LOOP

			FETCH ticketCursor INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount >= maxTicketCount;

			-- We change reductionPerTicket after previous code has been processed.
			IF fpriceCode =  'A' THEN 
				reductionPerTicket = 3;
			ELSIF fpriceCode =  'B' THEN 
				reductionPerTicket = 2;
			ELSE  'C' THEN 
				reductionPerTicket = 1;
			END if;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE ticketCursor
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
		CLOSE ticketCursor;
		RETURN reduction;

	END
$$ LANGUAGE plpgsql;


-- Solution #2: This creates 3 different cursors to update records for each priceCode

CREATE OR REPLACE FUNCTION reduceSomeTicketPricesFunction(maxTicketCount INTEGER)
RETURNS INTEGER AS $$

	DECLARE

	reduction INTEGER;
	newPrice NUMERIC(4,2);
 	changeCount INTEGER;
 	reductionPerTicket INTEGER;
 	
 	ftheaterID INTEGER;
 	fshowingDate DATE;
 	fstartTime TIME;
 	fpriceCode CHAR(1);
 	fseatNum INTEGER;
 	fticketPrice NUMERIC(4,2);

 	DECLARE ticketCursorA CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM ticketCursor T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'A'
						  ORDER BY T.customerID ASC; -- Use of ASC is okay but not necessary.

 	DECLARE ticketCursorB CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM ticketCursor T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'B'
						  ORDER BY T.customerID ASC; -- Use of ASC is okay but not necessary.

 	DECLARE ticketCursorC CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM ticketCursor T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'C'
						  ORDER BY T.customerID ASC; -- Use of ASC is okay but not necessary.

	BEGIN
	    -- Input Validation
	    IF maxTicketCount < 0 THEN
	    	RETURN -1;
	    END IF;

		reduction = 0;
	 	changeCount = 0;

	 	OPEN ticketCursorA;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketCursorA INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount >= maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE ticketCursor
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
		CLOSE ticketCursorA;

	 	OPEN ticketCursorB;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketCursorB INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount >= maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE ticketCursor
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
	 	CLOSE ticketCursorB;

	 	OPEN ticketCursorC;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketCursorC INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount >= maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE ticketCursor
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
	 	CLOSE ticketCursorC;

		RETURN reduction;

	END
$$ LANGUAGE plpgsql;
