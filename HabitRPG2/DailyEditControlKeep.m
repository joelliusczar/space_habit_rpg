//
//  DailyEditControlKeep.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/19/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditControlKeep.h"
#import "SingletonCluster.h"
#import "Daily+CoreDataClass.h"
#import "EditNavigationController.h"

@interface DailyEditControlKeep()
@end

@implementation DailyEditControlKeep

-(NoteView *)noteView{
    if(nil==_noteView){
        _noteView = [[NoteView alloc] init];
        _noteView.delegate = self.delegate;
    }
    return _noteView;
}


-(RateSetterView *)rateSetterView{
    if(nil==_rateSetterView){
        _rateSetterView = self.rateSetContainer.rateSetter;
    }
    return _rateSetterView;
}

-(ImportanceSliderView *)urgencySlider{
    if(nil==_urgencySlider){
        _urgencySlider = [[ImportanceSliderView alloc] init];
        _urgencySlider.delegate = self.delegate;
    }
    return _urgencySlider;
}

-(ImportanceSliderView *)difficultySlider{
    if(nil==_difficultySlider){
        _difficultySlider = [[ImportanceSliderView alloc] init];
        _difficultySlider.delegate = self.delegate;
    }
    return _difficultySlider;
}

-(StreakResetterView *)streakResetterView{
    if(nil==_streakResetterView){
        _streakResetterView = [[StreakResetterView alloc] init];
        _streakResetterView.delegate = self.delegate;
    }
    return _streakResetterView;
}

-(ReminderListView *)reminderListView{
    if(nil==_reminderListView){
        _reminderListView = [ReminderListView newWithDueDateInfo:self.delegate.daily];
        _reminderListView.utilityStore = SharedGlobal;
        _reminderListView.resizeResponder = self.resizeResponder;
        _reminderListView.delegate = self.delegate;
    }
    return _reminderListView;
}

-(RateSetContainer *)rateSetContainer{
    if(nil==_rateSetContainer){
        _rateSetContainer = [RateSetContainer newWithDaily:self.delegate.daily];
        _rateSetContainer.delegate = self.delegate;
        _rateSetContainer.utilityStore = SharedGlobal;
        _rateSetContainer.resizeResponder = self.resizeResponder;
        _rateSetContainer.tblDelegate = self.delegate;
    }
    return _rateSetContainer;
}

-(NSOrderedSet<UIView*> *)allControls{
    if(nil==_allControls){
        _allControls = [NSOrderedSet orderedSetWithObjects:
                        self.noteView
                        ,self.rateSetContainer
                        ,self.urgencySlider
                        ,self.difficultySlider
                        ,self.streakResetterView
                        ,self.reminderListView
                        ,nil];
    }
    return _allControls;
}

-(void)dealloc{
    _delegate = nil;
}


@end
