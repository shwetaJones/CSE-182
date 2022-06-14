/**
For each person who has the string ‘son’ appearing anywhere in their name (lowercase letters), give the
name of the person, the address of their house, and the name of the owner of that house. No duplicates
should appear in your result.
*/

/**
Two instances would be needed for Persons table, first for the personname and second for the owner name.
It's much better to have different attributes/aliases for personName, e.g., personName and ownerName, but not doing that works in PostgreSQL and you won't lose points.

DISTINCT is not needed(!) since (personName, housedID) is UNIQUE, and neither personName nor houseID can be NULL. (Why can't personName be NULL?  Because NULL would not satisfy "personName LIKE '%son%'") And for a particular houseID, there can only be one owner.

However, we won't deduct any points on this one if you used DISTINCT, since this is a particularly subtle point, and our posted solution was originally wrong.

However, we won't deduct any points on this one if you used DISTINCT, since this is a particularly subtle point, and our posted solution was originally wrong.
*/

SELECT p.personName AS personName, h.address AS address, o.personName AS ownerName 
FROM   Persons p, Houses h, Persons o 
WHERE  p.houseID = h.houseID 
  AND  p.personName LIKE '%son%' 
  AND  h.ownerID = o.personID; 
