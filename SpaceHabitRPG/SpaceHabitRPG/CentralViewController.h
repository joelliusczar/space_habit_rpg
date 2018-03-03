//
//  CentralViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditNavigationController.h"
#import <SHData/CoreDataStackController.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Monster+CoreDataClass.h>
#import "P_CentralViewController.h"

@interface CentralViewController : UIViewController <P_CentralViewController>;
@property (weak,nonatomic) IBOutlet UIView *tabsContainer;
@end
