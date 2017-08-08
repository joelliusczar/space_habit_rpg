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

@interface DailyEditControlKeep()
@property (weak,nonatomic) DailyEditController *delegate;
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
        _rateSetterView = [[RateSetterView alloc] init];
        _rateSetterView.delegate = self.delegate;
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
        _reminderListView = [ReminderListView newWithDueDateInfo:self.delegate.modelForEditing
                             andBackViewController:self.delegate.editorContainer
                             andTimeStore:SharedGlobal];
    }
    return _reminderListView;
}

-(NSArray<UIView*> *)allControls{
    if(nil==_allControls){
        _allControls = [NSArray arrayWithObjects:
                        self.noteView
                        ,self.urgencySlider
                        ,self.difficultySlider
                        ,self.streakResetterView
                        ,self.reminderListView
                        ,nil];
    }
    return _allControls;
}

-(instancetype)initWithDailyEditController:(DailyEditController *)delegate{
    if(self = [super init]){
        _delegate = delegate;
    }
    return self;
}


@end
