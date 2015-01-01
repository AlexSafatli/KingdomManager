''' Generate a city as an sqlite file using definitions from a core sqlite database. '''

import sys, db
from random import choice,randint,uniform as runiform

DB_LOC_TABLE = 'buildings'
DB_PER_TABLE = 'personalities'
DB_PRO_TABLE = 'professions'
DB_EVE_TABLE = 'events'

# Check input for database file path.

if len(sys.argv) != 2:
    print 'Usage: %s database_location' % (sys.argv[0])
    exit(2)
dbPath = sys.argv[1]

# Define function for weighted probability choice.

def selection(choices):
    # Each item in choice is a (selection,weight).
    tot  = sum(w for c,w in choices) # Sum weights.
    r    = runiform(0,tot)
    for c,w in choices:
        r -= w
        if r < 0: return c
    raise AssertionError('Did not choose a selection at random.')

# Load the database.

dbObj = db.SQLiteDatabase(dbPath)
locations = dbObj.getRecords(DB_LOC_TABLE)
personalities = dbObj.getRecords(DB_PER_TABLE)
professions = dbObj.getRecords(DB_PRO_TABLE)
events = dbObj.getRecords(DB_EVE_TABLE)

# Get (id,weight) tuple for location and profession tables.

locs = []
for loc in locations:
    locs.append((loc[1],loc[2]))
pros = []
for pro in professions:
    pros.append((pro[1],pro[2]))

# Print a single worker and location for debugging.

worker = selection(pros)
building = selection(locs)

print worker
print building
