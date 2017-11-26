//
//  CentralViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import "CoreDataStackController.h"
#import "Daily+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"
#import "P_CentralViewController.h"

@interface CentralViewController : UIViewController <P_CentralViewController>;
@property (weak,nonatomic) IBOutlet UIView *tabsContainer;
@end
