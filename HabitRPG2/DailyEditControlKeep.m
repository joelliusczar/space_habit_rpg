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

-(ImportanceSliderView *)importanceSliders{
    if(nil==_importanceSliders){
        _importanceSliders =
        [[ImportanceSliderView alloc] init];
        _importanceSliders.delegate = self.delegate;
    }
    return _importanceSliders;
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
        _reminderListView = [[ReminderListView alloc]
                             initWithDueDateInfo:self.delegate.modelForEditing
                             andBackViewController:self.delegate.editorContainer
                             andLocale:SharedGlobal.inUseLocale];
    }
    return _reminderListView;
}

-(NSArray<UIView*> *)allControls{
    if(nil==_allControls){
        _allControls = [NSArray arrayWithObjects:
                        self.noteView
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
