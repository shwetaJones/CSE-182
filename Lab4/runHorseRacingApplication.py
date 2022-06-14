#! /usr/bin/env python

#  runHorseRacingApplication Solution

import psycopg2, sys, datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runHorseRacingApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

# The three Python functions that for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third C function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


 # winCountForHorse (myConn, theHorseID):
 # The winCountForHorse Python function returns the number of times that a horse particular ID
 # finished first in a race.  The arguments for winCountForHorse  are the database connection and
 # the ID of the horse.
 #
 # It is not an error if there is no horse with that ID.  If there are no races in which the horse
 # finished first, then winCountForHorse  should return 0.

def winCountForHorse (myConn, theHorseID):

    # Python function to be supplied by students
    # You'll need to figure out value to return.
    try:
        myCursor = myConn.cursor()
        stmt = "SELECT COUNT(horseID) FROM HorseRaceResults WHERE finishPosition = 1 AND horseID={}".format(theHorseID)
        myCursor.execute(stmt, (theHorseID,))
    except:
        print("Statement", stmt, "is bad", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    row = myCursor.fetchall()
    winCount = row[0][0]
    if winCount == 0:
        return 0
    else:
        return winCount
    myCursor.close()

# end winCountForHorse


# updateRacetrackAddress (myConn, oldAddress, newAddress ):
# address is an attribute of the racetracks table.  Sometimes the address of a racetrack may change. different city.
#
# Besides the database connection, the updateRacetrackAddress Python function has two arguments, a
# string argument oldAddress and a string argument newAddress.  For every racetrack in the racetracks
# table (if any) whose address equals oldAddress, updateRacetrackAddress  should change that
# racetrack’s address to be newAddress.
#
# There might be no racetrack whose address equals oldAddress; that’s not an error.  There also might
# be one or more racetracks whose address equals oldAddress (since multiple racetracks might have
# the same address).  updateRacetrackAddress should return the number of racetracks whose address
# was updated.

def updateRacetrackAddress (myConn, oldAddress, newAddress ):
    
    # Python function to be supplied by students
    # You'll need to figure out value to return.
    try:
        myCursor = myConn.cursor()
        stmt = "UPDATE Racetracks SET address = '" + newAddress + "' WHERE address = '" + oldAddress + "'"
        myCursor.execute(stmt, (oldAddress, newAddress, ))
        #myCursor.execute(stmt)
        numUpdated = myCursor.rowcount
        return numUpdated
    except:
        print("Update for", oldAddress, "to", newAddress, "is bad", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    #return myCursor.rowcount()
    myCursor.close()
    #rowCount = str(myCursor.rowcount)
    #return rowCount 
# end updateRacetrackAddress


# disqualifyHorseInRace (myConn, theHorseID, theRacetrackID, theRaceDate, theRaceNum):
# Besides the database connection, this Python function has four other parameters:
#    theHorseID which is an integer,
#    theRacetrackID which is an integer,
#    theRaceDate which is a date,
#    theRaceNum, which is an integer
# disqualifyHorseInRace invokes a Stored Function, disqualifyHorseInRaceFunction, that you will
# need to implement and store in the database according to the description in Section 5.
# The Stored Function disqualifyHorseInRaceFunction has all the same parameters as
# disqualifyHorseInRace (except for the database connection, which is not a parameter for the
# Stored Function), and it returns an integer.
#
# Section 5 tells you what “disqualifying a horse in a race” mean, and explains the integer value
# that disqualifyHorseInRaceFunction returns.  The disqualifyHorseInRace Python function returns
# the same integer value that the disqualifyHorseInRaceFunction Stored Function returns.
#
# The disqualifyHorseInRace function must only invoke the Stored Function
# disqualifyHorseInRaceFunction, which does all of the work for this part of the assignment;
# disqualifyHorseInRace should not do any of the work itself.

def disqualifyHorseInRace (myConn, theHorseID, theRacetrackID, theRaceDate, theRaceNum):

# We're gving you the code for disqualifyHorseInRace, but you'll have to write
# the Stored Function disqualifyHorseInRaceFunction yourselves in a PL/pgSQL file named
# disqualifyHorseInRaceFunction.pgsql
        
    try:
        myCursor = myConn.cursor()
        sql = "SELECT disqualifyHorseInRaceFunction(%s, %s, %s, %s)"
        myCursor.execute(sql, (theHorseID, theRacetrackID, theRaceDate, theRaceNum ))
    except:
        print("Call of disqualifyHorseInRaceFunction on", theHorseID, theRacetrackID, theRaceDate, theRaceNum, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end disqualifyHorseInRace

def printStatements(horseID, raceTrackID, raceDate, raceNum, numImproved):
    if numImproved == -1:
        print("Horse count not be found")
    elif numImproved == -2:
        print("Horse finish position is null")
    else:
        print("The horse with id ", str(horseID), "that raced on ", str(raceTrackID), " that raced on the day ", str(raceDate), " with the race number ", str(raceNum), " and the number of improvements is ", str(numImproved))

def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using myConn.commit when we want to commit.
    myConn.autocommit = True
    
    # There are other correct ways of writing all of these calls correctly in Python.
        
    # Perform the calls to winCountForHorse  described in Section 6 of Lab4.
    # Print their outputs from here, not in winCountForHorses.
    # You may use a Python method to help you do the printing.
    # TEST 1
    horseID = 526
    numWin = winCountForHorse(myConn, horseID)
    print("Horse " + str(horseID) + " won " + str(numWin) + " races")
    # TEST 2
    horseID = 555
    numWin = winCountForHorse(myConn, horseID)
    print("Horse " + str(horseID) + " won " + str(numWin) + " races")

    # Perform the calls to updateRacetrackAddress  described in Section 6 of Lab4.
    # Print their outputs from here, not in updateRacetrackAddress.
    # You may use a Python method to help you do the printing.
    # TEST 1
    oldAddress = "Kellogg Rd 6301, Cincinnati, OH 45230"
    newAddress = "6301 Kellogg Road, Cincinnati, OH 45230"
    numUpdates = updateRacetrackAddress(myConn, oldAddress, newAddress)
    print("Number of racetracks with whose address was changed from " + oldAddress + " to " + newAddress + " is " + str(numUpdates))
 
    oldAddress = "Elmont, NY 11003"
    newAddress = "Belmont Park, NY 11003"
    numUpdates = updateRacetrackAddress(myConn, oldAddress, newAddress)
    print("Number of racetracks with whose address was changed from " + oldAddress + " to " + newAddress + " is " + str(numUpdates))
    # Perform the calls to disqualifyHorseInRace described in Section 6 of Lab4,
    # Print their outputs from here, not in disqualifyHorseInRace.
    # You may use a Python method to help you do the printing.
    #
    # Reminder:  As the Lab4 pdf tells you:
    #
    # Note:  Since we’ve included the datetime() class in the Python skeleton for
    # runHorseRacingApplication.py, writing datetime.date(2021, 8, 11) giving you a Python
    # date object that corresponds to August 11, 2021, and that Python date object can be
    # the argument for a PL/pgSQL stored function which expects a date parameter.
    # TEST 1
    horseID = 552
    racetrackID = 3008
    raceDate = '2021-08-11'
    raceNum = 1
    numImproved = disqualifyHorseInRace(myConn, horseID, racetrackID, raceDate, raceNum)
    printStatements(horseID, racetrackID, raceDate, raceNum, numImproved) 

    # TEST 2
    horseID = 553
    racetrackID = 3008
    raceDate = '2021-08-11'
    raceNum = 1
    numImproved = disqualifyHorseInRace(myConn, horseID, racetrackID, raceDate, raceNum)
    printStatements(horseID, racetrackID, raceDate, raceNum, numImproved)
 
    # TEST 3
    horseID = 575
    racetrackID = 3008
    raceDate = '2021-08-11'
    raceNum = 1
    numImproved = disqualifyHorseInRace(myConn, horseID, racetrackID, raceDate, raceNum)
    printStatements(horseID, racetrackID, raceDate, raceNum, numImproved)
    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
