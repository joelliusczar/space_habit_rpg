//
//  SHWeeklyActiveDaysDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import UIKit;
@import SHControls;

@protocol SHWeeklyActiveDaysDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo;
@end
