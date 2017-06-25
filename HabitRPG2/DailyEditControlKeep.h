//
//  DailyEditControlKeep.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/19/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_EditScreenControl.h"
#import <UIKit/UIKit.h>
#import "NoteView.h"
#import "ActiveDaysPicker.h"
#import "RateSetterView.h"
#import "ImportanceSliderView.h"
#import "StreakResetterView.h"
#import "P_DailyEditCompound.h"

@interface DailyEditControlKeep : NSObject
@property (strong,nonatomic) NSArray<UIView<P_EditScreenControl> *> *allControls;
@property (strong,nonatomic) NoteView *noteView;
@property (strong,nonatomic) ActiveDaysPicker *activeDaysPicker;
@property (strong,nonatomic) RateSetterView *rateSetterView;
@property (strong,nonatomic) ImportanceSliderView *importanceSliders;
@property (strong,nonatomic) StreakResetterView *streakResetterView;
-(instancetype)initWithDelegate:(id<P_DailyEditCompound>)delegate;
@end
