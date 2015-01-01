//
//  KingdomDatabase.m
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2015-01-01.
//  Copyright (c) 2015 Natural20CriticalHit. All rights reserved.
//

#import "KingdomDatabase.h"

@implementation KingdomDatabase

static KingdomDatabase *_database;

- (instancetype) init {
    
    // Instantiate the database and respective objects.
    if (self = [super init]) {
        NSString *sqliteDatabasePath = [[NSBundle mainBundle] pathForResource:@"core" ofType:@"sqlite"];
        if (sqlite3_open([sqliteDatabasePath UTF8String],&_dbObject) != SQLITE_OK)
            NSLog(@"Failed to open sqlite database for core kingdom management assets.");
    }
    return self;
    
}

+ (KingdomDatabase*) database {
    
    // Factory method.
    if (_database == nil) _database = [[KingdomDatabase alloc] init];
    return _database;
    
}

- (void) data {
    
    // Retrieve all data and put into containers.
    
}

- (void) dataForBuildings:(NSMutableDictionary*) dict {
    
    // Acquire the data for buildings.
    NSString *query = @"SELECT id,text,frequency,upgrade_to,number_lots,per_settlement,building_points FROM buildings";
    sqlite3_stmt *statement;
    if (sqlite3_prepare(_dbObject,[query UTF8String],-1,&statement,nil) == SQLITE_OK) {
        
        // Acquire information from each row of the table.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSInteger i = (NSInteger) sqlite3_column_int(statement,0);
            char     *c = (char*)    sqlite3_column_text(statement,1);
            float     f = (float)  sqlite3_column_double(statement,2);
            NSInteger u = (NSInteger) sqlite3_column_int(statement,3);
            NSInteger n = (NSInteger) sqlite3_column_int(statement,4);
            NSInteger p = (NSInteger) sqlite3_column_int(statement,5);
            NSInteger b = (NSInteger) sqlite3_column_int(statement,6);
            NSString *text = [[NSString alloc] initWithUTF8String:c];
            KingdomBuilding *building = [[KingdomBuilding alloc] initWithName:text freq:f lots:n per:p bp:b];
        }
        
    }
    
}

- (void) clear {
    
    // Clean up objects.
    
}

@end
