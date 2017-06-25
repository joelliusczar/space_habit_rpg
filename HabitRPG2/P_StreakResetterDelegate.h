//
//  P_StreakResetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_StreakResetterDelegate <NSObject>
-(void)streakResetBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event;
@end
