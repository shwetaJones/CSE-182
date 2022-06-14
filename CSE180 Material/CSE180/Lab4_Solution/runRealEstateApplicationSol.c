/**
 * runRealEstateApplication skeleton, to be modified by students
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "libpq-fe.h"

/* Okay to have a .h file, as long as .h file is provided. */
/* Okay to use actual constant. */
/* Okay to use 1000 instead of 1001; that's what our skeleton file did.  */
/* 1001 is to allow length 1000, with null \0 terminator.  */
#define bufsiz 1001

/* Exit after closing connection to the server, and frees memory used by the PGconn object. */
static void do_exit(PGconn *conn)
{
    PQfinish(conn);
    exit(EXIT_SUCCESS);
}


/* The three C functions that you need to complete for Lab4 should appear below.
 * You need to write these functions, as described in Lab4 Section 4 (and Section 5, which
 * describes the Stored Function used by the third C function.
 * In main, you need to write the tests of those function, as described in Lab4, Section 6.
 */


 /* brokerLevel is an attribute in the Brokers table.  The getBrokerLevelCount function has a char
 * (not a sting) argument, theBrokerLevel, and it should return the number of Brokers whose
 *  brokerLevel value equals theBrokerLevel.
 *
 * A value of theBrokerLevel  that is not ‘A’, ‘B’, ‘C’ or ‘D’ is an error, and you should exit.
 */
int getBrokerLevelCount(PGconn *conn, char theBrokerLevel) {
    if (!(theBrokerLevel=='A' || theBrokerLevel=='B' || theBrokerLevel=='C' || theBrokerLevel=='D'))
	{	
        printf("theBrokerLevel entered was %c and not amongst A/B/C/D",theBrokerLevel);
		exit(EXIT_FAILURE);
	}

    char stmt[bufsiz] = "SELECT COUNT(*) FROM Brokers WHERE brokerLevel='";
    strncat(stmt, &theBrokerLevel,1);
    strcat(stmt, "'");
    
    PGresult *res = PQexec(conn, stmt);
    
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
        PQclear(res);
        do_exit(conn);
    }
    int k = atoi(PQgetvalue(res, 0, 0));
    PQclear(res);
    return(k);
}


/* Brokers work at companies.  The company that a broker works at is indicated by the companyName
 * attribute in the Brokers table  Sometimes the company that a broker works at changes, perhaps
 * the original company was bought by another company.
 *
 * The updateCompanyName function has two arguments, a string argument oldCompanyName and another
 * string argument, newCompanyName.  For every broker in the Brokers table (if any) whose
 * companyName equals oldCompanyName, updateCompanyName should update their companyName to be
 * newCompanyName.  (Of course, there might not be any tuples whose companyName matches
 * oldCompanyName.)  updateCompanyName should return the number of tuples that were updated
 * (which might be 0).
 */
int updateCompanyName(PGconn *conn, char *oldCompanyName, char *newCompanyName) {
    char stmt[bufsiz] = "Update Brokers SET companyName = '";
    strcat(stmt, newCompanyName);
    strcat(stmt, "' WHERE companyName ='");
    strcat(stmt, oldCompanyName);
    strcat(stmt, "'");
    
    PGresult *res = PQexec(conn, stmt);
    
    if (PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        fprintf(stderr, "UPDATE failed: %s", PQerrorMessage(conn));
        PQclear(res);
        do_exit(conn);
    }
    int k = atoi(PQcmdTuples(res));
    PQclear(res);
    return(k);
}


/* increaseSomeOfferPrices: This method has two integer parameters, theOffererID, and
 * numOfferIncreases.  increaseSomeOfferPrice invokes a Stored Function,
 * increaseSomeOfferPricesFunction, that you will need to implement and store in the database
 * according to the description in Section 5.  The Stored Function increaseSomeOfferPricesFunction
 *  should have the same parameters, theOffererID and numOfferIncreases as
 * increaseSomeOfferPrices.
 *
 * A value of numOfferIncreases that’s not positive is an error, and you should exit.
 *
 * An offerer is a person who made an offer trying to buy a house that’s for sale.  The Offers
 * table has an offererID attribute, which gives the ID of the offerer, and an offerPrice
 * attribute, which gives the offer price that’s the offerer made because they want to buy the
 * house.  increaseSomeOfferPricesFunction will increase the offerPrice for some (but not
 * necessarily all) of the Offers made by theOffererID.  Section 5 explains which Offers should
 * have their offerPrice increased, and also tells you how much you should increase those
 * offerPrice values.  The increaseSomeOfferPrices function should return the same integer result
 * that the increaseSomeOfferPricesFunction Stored Function returns.
 *
 * The increaseSomeOfferPrices function must only invoke the Stored Function
 * increaseSomeOfferPricesFunction, which does all of the work for this part of the assignment;
 * increaseSomeOfferPrices should not do the work itself.
 */
int increaseSomeOfferPrices(PGconn *conn, int theOffererID, int numOfferIncreases) {
    if (numOfferIncreases<=0)
	{	
        printf("numOfferIncreases entered was %d which is not greater than 0",numOfferIncreases);
		exit(EXIT_FAILURE);
	}
    char stringGottenFromNum[bufsiz];                  /* Doesn't have to be this big */
    char stmt[bufsiz] = "SELECT increaseSomeOfferPricesFunction(";
    sprintf(stringGottenFromNum, "%d", theOffererID);
    strcat(stmt, stringGottenFromNum);
    strcat(stmt, ",");
    sprintf(stringGottenFromNum, "%d", numOfferIncreases);
    strcat(stmt, stringGottenFromNum);
    strcat(stmt, ")");
    
    PGresult *res = PQexec(conn, stmt);
    
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        fprintf(stderr, "FUNCTION failed: %s", PQerrorMessage(conn));
        PQclear(res);
        do_exit(conn);
    }
    
    int k = atoi(PQgetvalue(res, 0, 0));
    PQclear(res);
    return(k);

}

int
main(int argc, char **argv)
{   
    PGconn     *conn;
    int theResult;
    
    char *userID = argv[1];
    char *pwd = argv[2];
    /* No points will be deducted if a constant is used  */
    char conninfo[bufsiz] = "host=cse180-db.lt.ucsc.edu user=";
    strcat(conninfo, userID);
    strcat(conninfo, " password=");
    strcat(conninfo, pwd);
    
    /* Make a connection to the database */
    conn = PQconnectdb(conninfo);
    
    /* Check to see that the backend connection was successfully made */
    if (PQstatus(conn) != CONNECTION_OK)
    {
        fprintf(stderr, "Connection to database failed: %s",
                PQerrorMessage(conn));
        do_exit(conn);
    }

        
    /* Perform the call to getBrokerLevelCount described in Section 6 of Lab4,
     * and print its output.
     */
    char ch = 'B';
    theResult = getBrokerLevelCount(conn, ch);
    printf("/*\n * Output of getBrokerLevelCount\n * when the parameter theBrokerLevel is '%c'\n %d\n */\n\n", ch, theResult);
        
    /* Perform the call to updateCompanyName described in Section 6 of Lab4
     * and print its output.
     */
    char oldCompanyName[31];
    char newCompanyName[31];
    strcpy(oldCompanyName, "Weathervane Group Realty");
    strcpy(newCompanyName, "Catbird Estates");
    theResult = updateCompanyName(conn, oldCompanyName, newCompanyName);
    
    printf("/*\n * Output of updateCompanyName when oldCompanyName is\n");
    printf(" * '%s' and newCompanyName is '%s'\n", oldCompanyName, newCompanyName);
    printf(" %d\n */\n\n", theResult);
   
    strcpy(oldCompanyName, "Intero");
    strcpy(newCompanyName, "Sotheby");
    theResult = updateCompanyName(conn, oldCompanyName, newCompanyName);
    
    printf("/*\n * Output of updateCompanyName when oldCompanyName is\n");
    printf(" * '%s' and newCompanyName is '%s'\n", oldCompanyName, newCompanyName);
    printf(" %d\n */\n\n", theResult);
        
    /* Perform the two calls to increaseSomeOfferPrices described in Section 6 of Lab4
     * and print their outputs.
     * Okay to assign the arguments to variables, but don't have to do that.
     */
    
    theResult = increaseSomeOfferPrices(conn,13,4);
    printf("/* \n * Output of increaseSomeOfferPrices when theOffererID  is 13\n * and numOfferIncreases is 4 is \n %d\n */\n\n", theResult);
    
    theResult = increaseSomeOfferPrices(conn,13,2);
    printf("/* \n * Output of increaseSomeOfferPrices when theOffererID is 13\n * and numOfferIncreases is 2 is \n %d\n */\n\n", theResult);
    
    do_exit(conn);
    return 0;

}


