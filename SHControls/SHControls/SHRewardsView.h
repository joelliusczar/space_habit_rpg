//
//  SHRewardsView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRewardsDelegateProtocol.h"
#import "SHView.h"
@import UIKit;

IB_DESIGNABLE
@interface SHRewardsView : SHView
@property (weak,nonatomic) id<SHRewardsDelegateProtocol> rewardsDelegate;
@end
