//
//  ReminderTimeSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSpinPicker.h"
#import "P_ReminderTimeSpinPickerDelegate.h"
#import "P_UtilityStore.h"


@interface ReminderTimeSpinPicker :
SHSpinPicker
@property (weak,nonatomic) id<P_ReminderTimeSpinPickerDelegate> delegate;
@property (strong,nonatomic) id<P_UtilityStore> utilityStore;
@property (assign,nonatomic) NSInteger dayRange;
-(instancetype)initWithDayRange:(NSInteger)dayRange;
@end
