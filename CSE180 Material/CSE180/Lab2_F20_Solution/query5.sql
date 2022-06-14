/**
For each sold house for which the following are all true:
a) The buyer’s name starts with the letter ‘S’ (uppercase), and
b) the sold date was between February 10, 2020 and April 29, 2020 (including those dates), and
c) the price for which the house was sold was greater than its for sale price, and
d) there is at least one different house that is still for sale (isStillForSale) that has the same broker
who put this house up for sale
Output the houseID, ownerID, buyerID, soldPrice, forSalePrice, brokerID and the companyName of the
broker. The 7 attributes in your result should appear as theHouselD, theOwnerID, theBuyerID, soldPrice,
forSalePrice, theBrokerID and theCompany. No duplicates should appear in your result.
*/

/**Solution Version 1

It is okay for dates to be written using format DATE '02/10/2020' and DATE '04/29/2020'.
It is okay to use table names instead of tuple variable(except for ForSaleHouses)
It is okay to write it as s.soldDate >= '2020-02-10' AND s.soldDate <= DATE '2020-04-29' instead of using BETWEEN clause.
DISTINCT is needed in the solution as the same house might have been sold multiple times.
It's okay to write "f2.isStillForSale" instead of "f2.isStillForSale = TRUE"
*/

SELECT DISTINCT h.houseID AS theHouseID, h.ownerID AS theOwnerID, s.buyerID AS theBuyerID, s.soldPrice AS soldPrice, f1.forSalePrice AS forSalePrice, b.brokerID AS theBrokerID, b.companyName AS theCompany 
FROM   SoldHouses s, Persons p, ForSaleHouses f1, Houses h, Brokers b 
WHERE  s.buyerID = p.personid 
  AND  p.personName LIKE 'S%' 
  AND  h.houseID = s.houseID 
  AND  b.brokerID = f1.brokerID 
  AND  s.houseID = f1.houseID 
  AND  s.forSaleDate = f1.forSaleDate 
  AND  s.soldDate BETWEEN DATE '2020-02-10' AND DATE '2020-04-29' 
  AND  s.soldPrice > f1.forSalePrice 
  AND  EXISTS (SELECT brokerID 
                   FROM   ForSaleHouses f2 
                   WHERE  f2.houseID <> f1.houseID 
                     AND  f2.brokerID = f1.brokerID 
                     AND  f2.isStillForSale = TRUE); 

/**Solution Version 2

It is okay for dates to be written using format DATE '02/10/2020' and DATE '04/29/2020'.
It is okay to use table names instead of tuple variable(except for ForSaleHouses)
It is okay to write it as s.soldDate >= '2020-02-10' AND s.soldDate <= DATE '2020-04-29' instead of using BETWEEN clause.
DISTINCT is needed in the solution as the same house might have been sold multiple times.
It's okay to write "f2.isStillForSale" instead of "f2.isStillForSale = TRUE"
*/

SELECT DISTINCT h.houseID AS theHouseID, h.ownerID AS theOwnerID, s.buyerID AS theBuyerID, s.soldPrice AS soldPrice, f1.forSalePrice AS forSalePrice, b.brokerID AS theBrokerID, b.companyName AS theCompany 
FROM   SoldHouses s, Persons p, ForSaleHouses f1, Houses h, Brokers b, ForSaleHouses f2 
WHERE  s.buyerID = p.personid 
  AND  p.personName LIKE 'S%' 
  AND  h.houseID = s.houseID 
  AND  b.brokerID = f1.brokerID 
  AND  s.houseID = f1.houseID 
  AND  s.forSaleDate = f1.forSaleDate 
  AND  s.soldDate BETWEEN DATE '2020-02-10' AND DATE '2020-04-29' 
  AND  s.soldPrice > f1.forSalePrice 
  AND  f1.houseID <> f2.houseID 
  AND  f1.brokerID = f2.brokerID 
  AND  f2.isStillForSale = TRUE; 

