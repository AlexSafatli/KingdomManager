//
//  DetailViewController.h
//  Pathfinder Kingdom Manager
//
//  Created by Alex Safatli on 2014-12-31.
//  Copyright (c) 2014 Natural20CriticalHit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

