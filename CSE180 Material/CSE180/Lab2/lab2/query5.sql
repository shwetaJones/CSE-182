/* For each ticket for which all of the following are true: 

    a) the ticket was bought by a customer whose name starts with ‘D’ (capital D), 
    b) the ticket is for a showing whose price code isn't NULL, and
    c) the ticket is on a date between June 1, 2019 and June 30, 2019 (including those dates), and
    d) the ticket is for a theater that has more than 5 seats,

Output the ID, name and address of the customer, the address and number of seats of the theater, and the price code for the showing.  The 6 attributes in your result should appear as custID, custName, custAddress, theaterAddress, theaterSeats and priceCode.
*/

/* Note matching of Primary Key attribute in Customers to corresponding Foreign Key attribute of Tickets as well as matching of Primary Key attributes in Showings to corresponding Foreign Key attributes of Tickets, as well as Primary Key of Theaters to corresponding Foreign Key attribute of Showings.
*/
  
SELECT DISTINCT C.customerID as custID, C.name as custName, C.address as custAddress, Th.address as theaterAddress, Th.numSeats as theaterSeats, S.priceCode
FROM Customers C, Tickets Ti, Showings S, Theaters Th
WHERE C.customerID = Ti.customerID
  AND Ti.theaterID = S.theaterID
  AND Ti.showingDate = S.showingDate
  AND Ti.startTime = S.startTime
  AND Ti.theaterID = Th.theaterID
  AND C.name LIKE 'D%'
  AND Ti.showingDate BETWEEN DATE '2019-06-01' AND DATE '2019-06-30'
  AND S.priceCode IS NOT NULL
  AND Th.numSeats > 5;

/* Instead of using BETWEEEN, could write:
    Ti.showingDate >= '2019-06-01' AND Ti.showingDate <= DATE '2019-06-30'

Also, there are correct ways of writing this using subqueries. 
*/
