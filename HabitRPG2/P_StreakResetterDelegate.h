//
//  P_StreakResetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CommonDelegate.h"

@protocol P_StreakResetterDelegate <NSObject,P_CommonDelegate>
-(void)streakResetBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event;
@end
