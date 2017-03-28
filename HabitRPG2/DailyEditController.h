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
#import "DailyHelper.h"
#import "CommonUtilities.h"


@interface DailyEditController : UIViewController <EditingSaver>
-(id)initWithDataController:(NSObject<P_CoreData> *)dataController AndWithParentDailyController:(DailyViewController *)parentDailyController;
-(void)loadExistingDailyForEditing:(Daily *)daily WithIndexPath:(NSIndexPath *)rowInfo;
@end
