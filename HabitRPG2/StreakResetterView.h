//
//  StreakResetterView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_EditScreenControl.h"
#import "P_StreakResetterDelegate.h"

@interface StreakResetterView : UIView <P_EditScreenControl>
@property (weak,nonatomic) IBOutlet StreakResetterView *mainView;
@property (weak,nonatomic) IBOutlet UILabel *streakCountLbl;
@property (weak,nonatomic) IBOutlet UIButton *streakResetBtn;
@property (weak,nonatomic) id<P_StreakResetterDelegate> delegate;
@end
