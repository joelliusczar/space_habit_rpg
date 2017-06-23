//
//  DailyEditController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyViewController.h"
#import "EditingSaver.h"
#import "P_CoreData.h"
#import "constants.h"
#import "Daily+CoreDataClass.h"
#import "P_DailyEditCompound.h"


@interface DailyEditController : UIViewController <EditingSaver, UITableViewDataSource, UITableViewDelegate,P_DailyEditCompound>
-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController;
-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController ToEdit:(Daily *)daily AtIndexPath:(NSIndexPath *)rowInfo;
-(void)loadExistingDailyForEditing:(Daily *)daily;
@end
