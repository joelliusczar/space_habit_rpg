//
//  ReminderTimeSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSpinPicker.h"


@interface ReminderTimeSpinPicker :SHSpinPicker
@property (assign,nonatomic) NSInteger dayRange;
-(instancetype)initWithDayRange:(NSInteger)dayRange;
@end
