//
//  SHStreakResetterView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHButton.h"
#import "SHViewController.h"

IB_DESIGNABLE
@interface SHStreakResetterView : SHViewController
@property (weak,nonatomic) IBOutlet UILabel *streakCountLbl;
@property (weak,nonatomic) IBOutlet SHButton *streakResetBtn;
@property (copy,nonatomic) void (^streakReset)(void);
@end
