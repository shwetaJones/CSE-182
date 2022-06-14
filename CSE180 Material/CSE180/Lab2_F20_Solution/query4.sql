/**
For each house that has at least one offer, find the highest offer price for that house. Your output should
include the houseID, its address and the highest offer price for that house. The attributes in your result
should be houseID, address and highOffer. No duplicates should appear in your result
*/

/** Solution Version 1

It is okay to use table names instead of tuple variables.
DISTINCT is not needed in the SELECT because there can only be one tuple for each GROUP BY group.
*/

SELECT o.houseID AS houseID, h.address AS address, MAX(o.offerPrice) AS highOffer 
FROM   Offers o, Houses h 
WHERE  o.houseID = h.houseID 
GROUP  BY o.houseID, 
          h.address; 


/** Solution Version 2

It is okay to use table names instead of tuple variables.
DISTINCT is not needed in the SELECT because there can only be one tuple for each GROUP BY group.
We can write the query without h.address in GROUP BY, because h.houseID, which is the complete primary key of Houses, is a GROUP BY attribute.
*/

SELECT h.houseID AS houseID, h.address AS address, MAX(o.offerPrice) AS highOffer 
FROM   Offers o, Houses h 
WHERE  o.houseID = h.houseID 
GROUP  BY h.houseID;


/** Solution Version 3

It is okay to use table names instead of tuple variables.
DISTINCT is needed for this version because there could be multiple offers for a house that have the same highest offerPrice.
*/

SELECT DISTINCT o.houseID AS houseID, h.address AS address, o.offerPrice AS highOffer 
FROM   Offers o, Houses h 
WHERE  o.houseID = h.houseID 
  AND  o.offerPrice >= ALL (SELECT offerPrice 
                            FROM   Offers ofr 
                            WHERE  ofr.houseID = o.houseID); 


/** Solution Version 4

It is okay to use table names instead of tuple variables.
DISTINCT is needed for this version because there could be multiple offers for a house that have the same highest offerPrice.
*/

SELECT DISTINCT o.houseID AS houseID, h.address AS address, o.offerPrice AS highOffer 
FROM   Offers o, Houses h 
WHERE  o.houseID = h.houseID 
  AND  NOT EXISTS (SELECT offerPrice 
                   FROM   Offers ofr 
                   WHERE  ofr.houseID = o.houseID 
                     AND  ofr.offerPrice > o.offerPrice); 




