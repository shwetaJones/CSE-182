-- Reference https://www.postgresql.org/docs/12/plpgsql-cursors.html#PLPGSQL-CURSOR-FOR-LOOP 
-- Below is the code for creating the stored function. If the function already exists it replaces the existing function.
-- increaseSomeOfferPricesFunction take two parameters as input i.e. theOffererID and numOfferIncreases
-- and the function returns an integer value which is the count of rows which were updated.

-- increaseSomeOfferPricesFunction will increase offerPrice by 8000 for some
-- tuples in the Offers table whose offererID attribute value equals theOffererID. It should not change
-- offerPrice values for any other offerer. This Stored Function should count the number of the
-- increases that it has made, and it should return this count.

CREATE OR REPLACE FUNCTION
increaseSomeOfferPricesFunction(theOffererID INTEGER, numOfferIncreases INTEGER)
RETURNS INTEGER AS $$

-- DECLARE numIncreased variable which keeps track of the count of rows updated.

    DECLARE 
    numIncreased INTEGER;

-- DECLARE CURSOR offersCursor for the query which gets the offers for houses which were not sold
-- There are other ways to write the query below and there won't be any deduction if the query written is correct and not overly complex.

    DECLARE offersCursor CURSOR FOR
        SELECT off.houseID, off.forSaleDate, off.offerDate
        FROM Offers off
        WHERE off.offererID = theOffererID
          AND NOT EXISTS ( SELECT *
                           FROM SoldHouses s
                           WHERE s.houseID = off.HouseID
                             AND s.forSaleDate = off.forSaleDate )
        ORDER BY off.offerPrice ASC;
    -- Use of ASC is okay but not necessary.

	BEGIN
	    -- Input Validation
	    IF numOfferIncreases <=  0 THEN
	    	RETURN -1;
	    END IF;

        numIncreased = 0;

-- FOR loop for iterating through offersCursor.

        FOR records IN offersCursor

        LOOP

            -- We exit when we already have performed numOfferIncreases updates.
            EXIT WHEN numIncreased >= numOfferIncreases;

            UPDATE Offers
            SET offerPrice = offerPrice + 8000.00
            WHERE houseID = records.houseID
              AND forSaleDate = records.forSaleDate
              AND offererID = theOffererID
              AND offerDate = records.offerdate;

            numIncreased = numIncreased + 1;

        END LOOP;
     

	RETURN numIncreased;

	END

$$ LANGUAGE plpgsql;
