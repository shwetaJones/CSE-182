/**
For each offer that is current, give the name of the offerer, the address of the house, and the
mostRecentSaleDate (which is an attribute of Houses) for that house. Order your result in alphabetical
order based on name of the offerer. If there are two tuples in your result that have the same offerer
name, the tuple with the later value for most recent sales date should come first. No duplicates should
appear in your result.
*/

/* 
DISTINCT is needed because there can be multiple offers from the same offerer for the same house.
It is okay to write o.isACurrentOffer = True instead of o.isACurrentOffer.
It is okay to use table names instead of tuple variables.
It is okay not to write ASC with p.personName in ORDER BY, since the default is ASCENDING.
The  two attributes “personName” and “mostRecentSaleDate” should be present in the ORDER BY together.
*/

SELECT DISTINCT p.personName, h.address, h.mostRecentSaleDate 
FROM   Offers o, Persons p, Houses h 
WHERE  o.offererID = p.personID 
  AND  o.houseID = h.houseID 
  AND  o.isACurrentOffer 
ORDER  BY p.personName ASC, h.mostRecentSaleDate DESC;

