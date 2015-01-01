//
//  KingdomBuilding.m
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2015-01-01.
//  Copyright (c) 2015 Natural20CriticalHit. All rights reserved.
//

#import "KingdomBuilding.h"

@implementation KingdomBuilding

- (id)initWithName:(NSString *)text freq:(NSNumber *)f upgradeFrom:(KingdomBuilding *)building lots:(NSInteger)n per:(NSInteger)p bp:(NSInteger)b {
    
    if (self = [super init]) {
        self.name = text;
        self.frequency = f;
        self.upgradeFrom = building;
        self.numberLots = n;
        self.numberPerSettlement = p;
        self.numberBuildingPoints = b;
    }
    
    return self;
    
}

@end
