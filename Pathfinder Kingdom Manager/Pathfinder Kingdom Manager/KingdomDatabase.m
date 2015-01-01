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
        
        // Open database.
        NSString *sqliteDatabasePath = [[NSBundle mainBundle] pathForResource:@"core" ofType:@"sqlite"];
        if (sqlite3_open([sqliteDatabasePath UTF8String],&_dbObject) != SQLITE_OK)
            NSLog(@"Failed to open sqlite database for core kingdom management assets.");
        
        // Initialize containers.
        self.buildingData = [[NSMutableDictionary alloc] init];
        self.personalData = [[NSMutableDictionary alloc] init];
        self.professnData = [[NSMutableDictionary alloc] init];
        self.eventData    = [[NSMutableDictionary alloc] init];
        
    }
    return self;
    
}

+ (KingdomDatabase*) database {
    
    // Factory method.
    if (_database == nil) _database = [[KingdomDatabase alloc] init];
    return _database;
    
}

- (void) read {
    
    // Retrieve all data and put into containers.
    [self dataForBuildings];
    
}

- (void) dataForBuildings {
    
    // Create a temporary container to store row information for later object reference if it is an upgrade.
    NSMutableArray *upgBuildings = [[NSMutableArray alloc] init];
    typedef struct {
        NSInteger index;
        char *text;
        float frequency;
        NSInteger upgrade;
        NSInteger numLots;
        NSInteger perSet;
        NSInteger bp;
    } rowItems;
    
    // Acquire the data for buildings.
    NSString *query = @"SELECT id,text,frequency,upgrade_to,number_lots,per_settlement,building_points FROM buildings";
    sqlite3_stmt *statement;
    if (sqlite3_prepare(_dbObject,[query UTF8String],-1,&statement,nil) == SQLITE_OK) {
        
        // Acquire information from each row of the table.
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            // Extract the row data.
            NSInteger i = (NSInteger) sqlite3_column_int(statement,0);
            char     *c = (char*)    sqlite3_column_text(statement,1);
            float     f = (float)  sqlite3_column_double(statement,2);
            NSInteger u = (NSInteger) sqlite3_column_int(statement,3);
            NSInteger n = (NSInteger) sqlite3_column_int(statement,4);
            NSInteger p = (NSInteger) sqlite3_column_int(statement,5);
            NSInteger b = (NSInteger) sqlite3_column_int(statement,6);
            
            if (u > 0) { // Is an upgrade to another building.
            
                // Store them in a struct.
                rowItems  r; r.index = i; r.text  = c; r.frequency = f; r.upgrade = u;
                r.numLots = n; r.perSet = p; r.bp = b;
            
                // Store row in temporary container.
                NSValue *row = [NSValue valueWithBytes:&r objCType:@encode(rowItems)];
                [upgBuildings addObject:row];
                
            }
            
            else { // Not an upgrade. Can instantiate.
                
                NSString *text = [[NSString alloc] initWithUTF8String:c];
                NSNumber *freq = [[NSNumber alloc] initWithFloat:f];
                KingdomBuilding *building;
                building = [[KingdomBuilding alloc] initWithName:text freq:freq upgradeFrom:nil lots:n per:p bp:b];
                [self.buildingData setObject:building forKey:[[NSNumber alloc] initWithInteger:i]];
                
            }
            
        }
        
    }
    
    // Initialize all of the KingdomBuilding objects that were upgrades.
    for (id i in [upgBuildings objectEnumerator]) {
        
        // Get the pointer to the rowItems struct.
        rowItems r; [(NSValue*)i getValue:&r];
        
        // Instantiate the object.
        NSString *text = [[NSString alloc] initWithUTF8String:r.text];
        NSNumber *freq = [[NSNumber alloc] initWithFloat:r.frequency];
        KingdomBuilding *upgrade  = [self.buildingData objectForKey:[[NSNumber alloc] initWithInteger:r.upgrade]];
        KingdomBuilding *building = [[KingdomBuilding alloc] initWithName:text freq:freq upgradeFrom:upgrade lots:r.numLots per:r.perSet bp:r.bp];
        [self.buildingData setObject:building forKey:[[NSNumber alloc] initWithInteger:r.index]];
        
    }
    
}

- (void) clear {
    
    // Clean up objects.
    
}

@end
