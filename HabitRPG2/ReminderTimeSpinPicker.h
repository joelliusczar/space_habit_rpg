//
//  ReminderTimeSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlController.h"

@interface ReminderTimeSpinPicker : ControlController<UIPickerViewDataSource>
@property (weak,nonatomic) IBOutlet UIPickerView *picker;
@end
