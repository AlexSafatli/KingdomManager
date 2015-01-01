//
//  KingdomDatabase.h
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2015-01-01.
//  Copyright (c) 2015 Natural20CriticalHit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class KingdomBuilding;
@class KingdomProfession;
@class KingdomEvent;

@interface KingdomDatabase : NSObject

@property (atomic) sqlite3 *dbObject;
@property (atomic) NSMutableDictionary *buildingData;
@property (atomic) NSMutableDictionary *personalData;
@property (atomic) NSMutableDictionary *professnData;
@property (atomic) NSMutableDictionary *eventData;

+ (KingdomDatabase*) database;
- (void) data;
- (void) clear;

@end
