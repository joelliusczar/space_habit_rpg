//
//  DailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <SHData/SHCoreDataProtocol.h>
#import <SHModels/SHDaily+CoreDataClass.h>
#import "CentralViewController.h"



@interface DailyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (weak,nonatomic) CentralViewController *central;
-(instancetype)initWithCentral:(CentralViewController *)central;

-(void)setuptab;
-(void)completeDaily:(SHDaily *)daily;
-(void)undoCompletedDaily:(SHDaily *)daily;
-(void)fetchUpdates;
@end
