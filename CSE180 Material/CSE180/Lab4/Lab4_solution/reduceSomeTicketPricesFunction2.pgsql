-- Solution #1: This solution orders record by priceCode and customerID in ascending order. So, all we have to do is update first maxTicketCount rows.

CREATE OR REPLACE FUNCTION reduceSomeTicketPricesFunction(maxTicketCount INTEGER)
RETURNS INTEGER AS $$

	DECLARE

	reduction INTEGER;
	newPrice NUMERIC(4,2);
 	changeCount INTEGER;
 	reductionPerTicket INTEGER;

 	tickets CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM Tickets T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  ORDER BY S.priceCode ASC, T.customerID ASC;
 	
 	ftheaterID INTEGER;
 	fshowingDate DATE;
 	fstartTime TIME;
 	fpriceCode CHAR(1);
 	fseatNum INTEGER;
 	fticketPrice NUMERIC(4,2);

	BEGIN
		reduction = 0;
	 	changeCount = 0;

	 	OPEN tickets;

	 	LOOP

			FETCH tickets INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount = maxTicketCount;

			-- We change reductionPerTicket after previous code has been processed.
			CASE fpriceCode
				WHEN  'A' THEN 
					reductionPerTicket = 3;
				WHEN  'B' THEN 
					reductionPerTicket = 2;
				WHEN  'C' THEN 
					reductionPerTicket = 1;
			END CASE;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE Tickets
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
		CLOSE tickets;
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

 	ticketsA CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM Tickets T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'A'
						  ORDER BY T.customerID ASC;

 	ticketsB CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM Tickets T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'B'
						  ORDER BY T.customerID ASC;

 	ticketsC CURSOR FOR SELECT  T.theaterID, T.showingDate, T.startTime, S.priceCode, T.seatNum, T.ticketPrice
						FROM Tickets T, Showings S
						WHERE T.theaterID = S.theaterID
						  AND T.showingDate = S.showingDate
						  AND T.startTime = S.startTime
						  AND S.priceCode IN ('A', 'B', 'C')
						  AND T.ticketPrice IS NOT NULL
						  AND S.priceCode = 'C'
						  ORDER BY T.customerID ASC;
 	
 	ftheaterID INTEGER;
 	fshowingDate DATE;
 	fstartTime TIME;
 	fpriceCode CHAR(1);
 	fseatNum INTEGER;
 	fticketPrice NUMERIC(4,2);

	BEGIN
		reduction = 0;
	 	changeCount = 0;

	 	OPEN ticketsA;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketsA INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount = maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE Tickets
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
		CLOSE ticketsA;

	 	OPEN ticketsB;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketsB INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount = maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE Tickets
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
	 	CLOSE ticketsB;

	 	OPEN ticketsC;
		reductionPerTicket = 3;
	 	LOOP

			FETCH ticketsC INTO ftheaterID, fshowingDate, fstartTime, fpriceCode, fseatNum, fticketPrice;

			-- We exit if there are no more records for the current price code or when we already have processed maxTicketCount number of records 
			EXIT WHEN NOT FOUND
				   OR changeCount = maxTicketCount;

			newPrice = fticketPrice - reductionPerTicket;

			UPDATE Tickets
			SET ticketPrice = newPrice
			WHERE theaterID = ftheaterID
			  AND showingDate = fshowingDate
			  AND startTime = fstartTime
			  AND seatNum = fseatNum;

			changeCount = changeCount + 1;
			reduction = reduction + reductionPerTicket;

	 	END LOOP;
	 	CLOSE ticketsC;

		RETURN reduction;

	END
$$ LANGUAGE plpgsql;
