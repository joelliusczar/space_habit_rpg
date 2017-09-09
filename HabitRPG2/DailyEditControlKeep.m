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
@property (strong,nonatomic) Daily *daily;
@property (strong,nonatomic) NSMutableSet<SHView *> *delegateSet;
@property (strong,nonatomic) NSMutableSet<SHView *> *resizeResponderSet;
@end

@implementation DailyEditControlKeep


-(BOOL)wireupDelegate:(SHView *)control{
    SEL delegateSel = @selector(setDelegate:);
    typedef void (*setter)(id,SEL,DailyEditController *);
    if([control respondsToSelector:delegateSel]){
        setter impl = (setter)[control methodForSelector:delegateSel];
        impl(control,delegateSel,self.delegate);
        return true;
    }
    return false;
}


-(BOOL)wireupResizeResponder:(SHView *)control{
    SEL resizeResponderSel = @selector(setResizeResponder:);
    typedef void (*setter)(id,SEL,EditNavigationController *);
    if([control respondsToSelector:resizeResponderSel]){
        setter impl = (setter)[control methodForSelector:resizeResponderSel];
        impl(control,resizeResponderSel,self.resizeResponder);
        return true;
    }
    return false;
}

-(void)setDelegate:(DailyEditController *)delegate{
    _delegate = delegate;
    for(SHView *control in self.delegateSet){
        [self wireupDelegate: control];
    }
}


-(void)setResizeResponder:(EditNavigationController *)resizeResponder{
    _resizeResponder = resizeResponder;
    for(SHView *control in self.resizeResponderSet){
        [self wireupResizeResponder:control];
    }
}


-(void)addToDelegateSet:(SHView *)control{
    if([self wireupDelegate:control]){
        [self.delegateSet addObject:control];
    }
}


-(void)addToResizeResponderSet:(SHView *)control{
    if([self wireupResizeResponder:control]){
        [self.resizeResponderSet addObject:control];
    }
}

-(NoteView *)noteView{
    if(nil==_noteView){
        _noteView = [[NoteView alloc] init];
        [self addToDelegateSet:_noteView];
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
        [self addToDelegateSet:_urgencySlider];
    }
    return _urgencySlider;
}

-(ImportanceSliderView *)difficultySlider{
    if(nil==_difficultySlider){
        _difficultySlider = [[ImportanceSliderView alloc] init];
        [self addToDelegateSet:_difficultySlider];
    }
    return _difficultySlider;
}

-(StreakResetterView *)streakResetterView{
    if(nil==_streakResetterView){
        _streakResetterView = [[StreakResetterView alloc] init];
        [self addToDelegateSet:_streakResetterView];
    }
    return _streakResetterView;
}

-(ReminderListView *)reminderListView{
    if(nil==_reminderListView){
        _reminderListView = [ReminderListView newWithDueDateInfo:self.daily];
        _reminderListView.utilityStore = SharedGlobal;
        [self addToResizeResponderSet:_reminderListView];
        [self addToDelegateSet:_reminderListView];
    }
    return _reminderListView;
}

-(RateSetContainer *)rateSetContainer{
    if(nil==_rateSetContainer){
        _rateSetContainer = [RateSetContainer newWithDaily:self.daily];
        [self addToDelegateSet:_rateSetContainer];
        _rateSetContainer.utilityStore = SharedGlobal;
        [self addToResizeResponderSet:_rateSetContainer];
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

-(instancetype)initWithDaily:(Daily *)daily{
    if(self = [super init]){
        _daily = daily;
    }
    return self;
}


@end
