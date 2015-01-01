//
//  KingdomBuilding.h
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2015-01-01.
//  Copyright (c) 2015 Natural20CriticalHit. All rights reserved.
//

#import "KingdomAsset.h"

@interface KingdomBuilding : KingdomAsset

@property (atomic,copy) NSNumber *frequency;
@property (atomic,copy) KingdomBuilding *upgradeFrom;
@property (atomic) NSInteger numberLots;
@property (atomic) NSInteger numberPerSettlement;
@property (atomic) NSInteger numberBuildingPoints;

@end
