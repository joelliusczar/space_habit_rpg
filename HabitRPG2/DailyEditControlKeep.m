//
//  DailyEditControlKeep.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/19/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyEditControlKeep.h"
#import "ControlController.h"
#import "SingletonCluster.h"
#import "Daily+CoreDataClass.h"

@interface DailyEditControlKeep()
@property (weak,nonatomic) DailyEditController *delegate;
@end

@implementation DailyEditControlKeep

-(NoteView *)noteView{
    if(nil==_noteView){
        _noteView = [[NoteView alloc] initDefault];
        _noteView.delegate = self.delegate;
        [_noteView view];
    }
    return _noteView;
}

-(ActiveDaysPicker *)activeDaysPicker{
    if(nil==_activeDaysPicker){
        _activeDaysPicker =
        [[ActiveDaysPicker alloc] initDefault];
        _activeDaysPicker.delegate = self.delegate;
        [_activeDaysPicker view];
    }
    return _activeDaysPicker;
}

-(RateSetterView *)rateSetterView{
    if(nil==_rateSetterView){
        _rateSetterView = [[RateSetterView alloc] initDefault];
        _rateSetterView.delegate = self.delegate;
        [_rateSetterView view];
    }
    return _rateSetterView;
}

-(ImportanceSliderView *)importanceSliders{
    if(nil==_importanceSliders){
        _importanceSliders =
        [[ImportanceSliderView alloc] initDefault];
        _importanceSliders.delegate = self.delegate;
        [_importanceSliders view];
    }
    return _importanceSliders;
}

-(StreakResetterView *)streakResetterView{
    if(nil==_streakResetterView){
        _streakResetterView = [[StreakResetterView alloc] initDefault];
        _streakResetterView.delegate = self.delegate;
        [_streakResetterView view];
    }
    return _streakResetterView;
}

-(ReminderListView *)reminderListView{
    if(nil==_reminderListView){
        _reminderListView = [[ReminderListView alloc]
                             initWithDueDateInfo:self.delegate.modelForEditing
                             andBackViewController:self.delegate.editorContainer
                             andLocale:SharedGlobal.inUseLocale];
    }
    return _reminderListView;
}

-(NSArray<ControlController*> *)allControls{
    if(nil==_allControls){
        _allControls = [NSArray arrayWithObjects:
                        self.noteView
                        ,self.activeDaysPicker
                        ,self.rateSetterView
                        ,self.importanceSliders
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
