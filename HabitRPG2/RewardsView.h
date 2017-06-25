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

@interface RewardsView : UIView <P_EditScreenControl>
@property (weak,nonatomic) IBOutlet RewardsView *mainView;
@property (weak,nonatomic) id<P_RewardsDelegate> delegate;
@end
