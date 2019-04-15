//
//  DailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <SHData/P_CoreData.h>
#import <SHModels/Daily+CoreDataClass.h>
#import "CentralViewController.h"



@interface DailyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (weak,nonatomic) CentralViewController *central;
-(instancetype)initWithCentral:(CentralViewController *)central;

-(void)setuptab;
-(void)completeDaily:(Daily *)daily;
-(void)undoCompletedDaily:(Daily *)daily;
-(void)fetchUpdates;
@end
