//
//  P_MonthComponentSpinPickerDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHEventInfo.h"

@protocol P_MonthComponentSpinPickerDelegate <NSObject>
-(void)pickerSelection_action:(SHEventInfo *)eventInfo;
@end
