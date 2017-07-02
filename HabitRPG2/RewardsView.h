//
//  RewardsView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_RewardsDelegate.h"
#import "P_EditScreenControl.h"
#import "ControlController.h"

@interface RewardsView : ControlController <P_EditScreenControl>
@property (weak,nonatomic) id<P_RewardsDelegate> delegate;
@end
