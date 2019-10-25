//
//  SHStreakResetterDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "SHCommonDelegateProtocol.h"
#import "SHEventInfo.h"

@protocol SHStreakResetterDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)streakResetBtn_press_action:(SHEventInfo *)eventInfo;
@end
