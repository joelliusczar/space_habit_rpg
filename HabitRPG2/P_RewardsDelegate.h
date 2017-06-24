//
//  P_RewardsView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_RewardsDelegate <NSObject>
-(void)addRewardsBtn_press_action:(UIButton *)sender
                         forEvent:(UIEvent *)event;
@end
