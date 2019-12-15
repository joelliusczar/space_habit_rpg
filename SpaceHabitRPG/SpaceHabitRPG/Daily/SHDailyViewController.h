//
//  SHDailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import "SHCentralViewController.h"
@import UIKit;
@import SHData;
@import SHModels;



@interface SHDailyViewController : SHViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (weak,nonatomic) SHCentralViewController *central;
@property (weak,nonatomic) IBOutlet SHView *addDailiesBtn;
-(instancetype)initWithCentral:(SHCentralViewController *)central;

-(void)setuptab;
-(void)completeDaily:(SHDaily *)daily;
-(void)undoCompletedDaily:(SHDaily *)daily;
-(void)fetchUpdates;
@end
