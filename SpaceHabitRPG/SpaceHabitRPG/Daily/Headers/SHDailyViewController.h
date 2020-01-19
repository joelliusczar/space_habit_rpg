//
//  SHDailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import "SHCentralViewController.h"
#import "SHHabitViewController.h"
@import UIKit;
@import SHModels;



@interface SHDailyViewController : SHHabitViewController
-(void)completeDaily:(SHDaily *)daily;
-(void)undoCompletedDaily:(SHDaily *)daily;
@end
