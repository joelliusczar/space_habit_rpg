//
//  StreakResetterView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_StreakResetterDelegate.h"
#import "SHView.h"
#import "SHButton.h"

IB_DESIGNABLE
@interface StreakResetterView : SHView
@property (weak,nonatomic) IBOutlet UILabel *streakCountLbl;
@property (weak,nonatomic) IBOutlet SHButton *streakResetBtn;
@property (weak,nonatomic) id<P_StreakResetterDelegate> delegate;
@end