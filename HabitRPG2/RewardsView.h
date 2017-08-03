//
//  RewardsView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_RewardsDelegate.h"

IB_DESIGNABLE
@interface RewardsView : UIView
@property (weak,nonatomic) UIView *mainView;
@property (weak,nonatomic) id<P_RewardsDelegate> delegate;
@end
