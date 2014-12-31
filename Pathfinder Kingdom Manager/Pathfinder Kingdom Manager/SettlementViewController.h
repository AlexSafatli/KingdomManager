//
//  SettlementViewController.h
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2014-12-31.
//  Copyright (c) 2014 Natural20CriticalHit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildingViewController.h"

@class BuildingViewController;

@interface SettlementViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) BuildingViewController *detailViewController;

@end
