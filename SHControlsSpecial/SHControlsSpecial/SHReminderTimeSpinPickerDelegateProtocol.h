//
//  P_ReminderTimeSpinPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHTimeSpinPickerEventInfo.h"

@protocol SHReminderTimeSpinPickerDelegateProtocol <NSObject>
-(void)pickerSelection_action:(UIPickerView *)sender
                           forEvent:(SHTimeSpinPickerEventInfo *)event;
@end
