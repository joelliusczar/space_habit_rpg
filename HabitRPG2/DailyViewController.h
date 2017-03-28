//
//  DailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "P_CoreData.h"
#import "CentralViewController.h"
#import "Daily+CoreDataClass.h"




@interface DailyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
-(id)initWithDataController:(NSObject<P_CoreData> *)dataController AndWithParent:(CentralViewController *)parent;
-(void)setuptab:(NSObject<P_CoreData> *)dataController;
-(void)showNewDaily:(Daily *)daily;
-(void)refreshTableAtRow:(NSIndexPath *)row;
-(void)removeItemFromViewAtRow:(NSIndexPath *)rowInfo;
-(void)completeDaily:(Daily *)daily;
-(void)undoCompletedDaily:(Daily *)daily;
@end
