/**
Find the ID and name of each broker whose company is ‘Weathervane Group Realty’, and who had at least
one house for sale before October 1, 2020 that is not still for sale, and where their “for sale house” sold
for one million or more No duplicates should appear in your result.
(Careful; the same house could be put up for sale more than once, perhaps with different brokers.)
*/


/** Solution Version 1

DISTINCT is needed because a broker could have had more than one house for sale before October 1, 2020 that is not for sale, and where that “for sale house” sold for one million or more.
It is okay to use table names instead of tuple variables.
It is okay to write f.isStillForSale  = False instead of NOT f.isStillForSale.
s.soldPrice can be also written without table name or a tuple variable as it only appears in SoldHouses.
Date constant can also be written as DATE '10/1/2020' or DATE '10/01/2020'.
*/

SELECT DISTINCT b.brokerID, p.personName
FROM            Brokers b, Persons p, ForSaleHouses f, SoldHouses s 
WHERE           b.brokerID = p.personID 
  AND           b.companyName = 'Weathervane Group Realty' 
  AND          	b.brokerID = f.brokerid 
  AND           f.forSaleDate < DATE '2020-10-01' 
  AND           f.houseID = s.houseID 
  AND           f.forSaleDate = s.forSaleDate 
  AND           NOT f.isStillForSale 
  AND           s.soldPrice >= 1000000;


/** Solution Version 2

DISTINCT is not needed in this scenarios, because there can be only one broker with a given brokerID, and that brokerID can match the personID of only one person.
It is okay to use table names instead of tuple variables.
It is okay to write f.isStillForSale  = False instead of NOT f.isStillForSale.
s.soldPrice can be also written without table name or a tuple variable as it only appears in SoldHouses.
Date constant can also be written as DATE '10/1/2020' or DATE '10/01/2020'.
*/

SELECT 	b.brokerID, p.personName
FROM   	Brokers b, Persons p
WHERE  	b.brokerID = p.personID 
  AND   b.companyName = 'Weathervane Group Realty'       
  AND   EXISTS (   
          SELECT *
          FROM   ForSaleHouses f,SoldHouses s
          WHERE  b.brokerID = f.brokerID
            AND  f.forSaleDate < DATE '2020-10-01'
            AND  f.houseID = s.houseID
            AND  f.forSaleDate = s.forSaleDate
            AND  NOT f.isStillForSale
            AND  s.soldPrice >= 1000000 );