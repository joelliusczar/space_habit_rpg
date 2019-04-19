//
//  SHRewardsViewProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCommonDelegateProtocol.h"
#import "SHEventInfo.h"

@protocol SHRewardsDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)addRewardsBtn_press_action:(SHEventInfo *)eventInfo;
@end
