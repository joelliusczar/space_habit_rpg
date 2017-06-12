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


@interface DailyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
-(id)initWithParent:(CentralViewController *)parent;
-(void)setuptab;
-(void)refreshTableAtRow:(NSIndexPath *)row;;
-(void)completeDaily:(Daily *)daily;
-(void)undoCompletedDaily:(Daily *)daily;
-(void)fetchUpdates;
@end
