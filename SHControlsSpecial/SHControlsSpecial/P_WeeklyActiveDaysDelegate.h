//
//  P_WeeklyActiveDaysDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SHControls/SHCommonDelegateProtocol.h>
#import <SHControls/SHEventInfo.h>

@protocol P_WeeklyActiveDaysDelegate <NSObject,SHCommonDelegateProtocol>
-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo;
@end
