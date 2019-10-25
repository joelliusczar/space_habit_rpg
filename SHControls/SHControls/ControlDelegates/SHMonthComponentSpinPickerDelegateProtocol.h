//
//  SHMonthComponentSpinPickerDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "SHEventInfo.h"

@protocol SHMonthComponentSpinPickerDelegateProtocol <NSObject>
-(void)pickerSelection_action:(SHEventInfo *)eventInfo;
@end
