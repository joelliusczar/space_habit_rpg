//
//  ReminderTimeSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlController.h"
#import "P_ReminderTimeSpinPickerDelegate.h"


@interface ReminderTimeSpinPicker :
ControlController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@property (weak,nonatomic) id<P_ReminderTimeSpinPickerDelegate> delegate;
@property (weak,nonatomic) NSLocale *inUseLocale;
@property (assign,nonatomic) NSInteger dayRange;
-(instancetype)initWithLocale:(NSLocale *)locale
                  andDayRange:(NSInteger)dayRange;
@end
