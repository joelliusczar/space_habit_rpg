//
//  SHDailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <SHData/SHCoreDataProtocol.h>
#import <SHModels/SHDaily.h>
#import "SHCentralViewController.h"



@interface SHDailyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (weak,nonatomic) SHCentralViewController *central;
-(instancetype)initWithCentral:(SHCentralViewController *)central;

-(void)setuptab;
-(void)completeDaily:(SHDaily *)daily;
-(void)undoCompletedDaily:(SHDaily *)daily;
-(void)fetchUpdates;
@end
