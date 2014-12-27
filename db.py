''' Connect, access, + manipulate data from a remote SQL server or from a sqlite file. '''

# Date:   Nov 7 2013
# Author: Alex Safatli
# E-mail: safatli@cs.dal.ca

import sqlite3 as sqllite
from abc import ABCMeta as abstractclass, abstractmethod

class database(object):

    ''' Allow interfacing with a SQL/sqlite database. '''
    
    __metaclass__ = abstractclass
    cursor = None # Cursor for the database object.
    
    @abstractmethod
    def getTables(self): pass
    
    @abstractmethod
    def getColumns(self,table): pass  
    
    def isEmpty(self):
        ''' Determine if the database is empty. '''
        return (len(self.getTables()) == 0)
    def getHeaders(self,table):
        ''' Get only header names for a given table's columns. '''
        return [x[0] for x in self.getColumns(table)]
    def getRecordsColumn(self,table,col):
        ''' Get all data for a single colmun from records for a table. '''
        self.query("""SELECT %s FROM %s""" % (col,table))
        return self.cursor.fetchall()
    def getRecords(self,table):
        ''' Get all records from a given table in the database. '''
        self.query("""SELECT * FROM %s""" % (table))
        return self.cursor.fetchall()
    def iterRecords(self,table):
        ''' Get a record, one at a time, from a table in the database. '''
        self.query("""SELECT * FROM %s""" % (table))
        nextitem = self.cursor.fetchone()
        while nextitem != None:
            yield nextitem
            nextitem = self.cursor.fetchone()
    def filterRecords(self,table,condn):
        ''' Get all records from a given table following a condition. '''
        self.query("""SELECT * FROM %s WHERE %s""" % (table,condn))
        return self.cursor.fetchall()
    def getRecordsAsDict(self,table):
        ''' Acquires records using getRecords() and then leverages
        access using a dictionary data structure. '''
        d = {}
        items = self.getRecords(table)
        if len(items) == 0: return {}
        headers = self.getHeaders(table)
        if len(items[-1]) != len(headers): return None
        for header in headers: d[header] = []
        for item in items:
            for i in xrange(len(headers)):
                header = headers[i]
                value  = item[i]
                d[header].append(value)
        return d
    def newTable(self,tablename,*args):
        self.query("""CREATE TABLE %s (%s)""" % (
            tablename,', '.join(['%s %s' % (x,y) for x,y in args])))
    def insertRecords(self,tablename,items):
        self.querymany('''INSERT INTO %s VALUES (%s)''' % (
            tablename,', '.join(['?' for x in items[0]])),items)
    def insertRecord(self,tablename,record):
        self.insertRecords(tablename,[record])

    @abstractmethod
    def query(self,q): pass
    
    @abstractmethod
    def querymany(self,q,i): pass

    @abstractmethod
    def close(self): pass

class SQLiteDatabase(database):
    
    def __init__(self,filepath):
        self.filepath = filepath
        self.socket   = sqllite.connect(filepath)
        self.cursor   = self.socket.cursor()

    def getColumns(self,table):
        ''' Return column information for a given table. '''
        self.query("""PRAGMA table_info(%s)""" % (table))
        return self.cursor.fetchall()

    def getTables(self):
        self.query("""SELECT name FROM sqlite_master WHERE type='table';""")
        return [x[0] for x in self.cursor.fetchall()]   

    def query(self,q):
        # Execute an sqlite query.
        self.cursor.execute(q)

    def querymany(self,q,i):
        self.cursor.executemany(q,i)

    def close(self):
        # Close the connection.
        self.socket.commit()
        self.socket.close()    