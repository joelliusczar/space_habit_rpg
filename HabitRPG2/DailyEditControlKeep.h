//
//  DailyEditControlKeep.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/19/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NoteView.h"
#import "WeeklyActiveDays.h"
#import "RateSetterView.h"
#import "ImportanceSliderView.h"
#import "StreakResetterView.h"
#import "ReminderListView.h"
#import "DailyEditResponder.h"
#import "RateSetContainer.h"
#import "SHView.h"
#import "P_EditControlKeep.h"

@class DailyEditResponder;

@interface DailyEditControlKeep : NSObject<P_EditControlKeep>
@property (strong,nonatomic) NSOrderedSet<SHView *> *allControls;
@property (strong,nonatomic) NoteView *noteView;
@property (strong,nonatomic) WeeklyActiveDays *activeDaysPicker;
@property (strong,nonatomic) RateSetterView *rateSetterView;
@property (strong,nonatomic) ImportanceSliderView *urgencySlider;
@property (strong,nonatomic) ImportanceSliderView *difficultySlider;
@property (strong,nonatomic) StreakResetterView *streakResetterView;
@property (strong,nonatomic) ReminderListView *reminderListView;
@property (strong,nonatomic) RateSetContainer *rateSetContainer;
-(instancetype)initWith:(DailyEditResponder *)delegate and:(EditNavigationController *)resizeResponder;

@end
