//
//  DailyEditController+ControlLoaders.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "DailyEditController+ControlLoaders.h"
#import "AllSHControls.h"

@implementation DailyEditController (ControlLoaders)


-(SHControlKeep *)buildControlKeep:(Daily *)daily{
    NSAssert(daily,@"Daily should not be null");
    SHControlKeep *keep = [[SHControlKeep alloc] init];

    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NoteView *note = [[NoteView alloc] init];
        note.noteBox.text = daily.note.length>0?daily.note:@"";
        [keep addControlToActionSetWithKey:takeKey(setDelegate:)];
        return note;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        RateSetterView *rateSetter = [[RateSetterView alloc] init];
        return rateSetter;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *difficultySld = [[ImportanceSliderView alloc] init];
        difficultySld.controlName = @"difficulty";
        [difficultySld updateImportanceSlider:daily.difficulty];
        [keep addControlToActionSetWithKey:takeKey(setDelegate:)];
        return difficultySld;
    } withKey:@"difficultySld"];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *urgencySld = [[ImportanceSliderView alloc] init];
        urgencySld.controlName = @"urgency";
        [urgencySld updateImportanceSlider:daily.urgency];
        [keep addControlToActionSetWithKey:takeKey(setDelegate:)];
        return urgencySld;
    } withKey:@"urgencySld"];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        StreakResetterView *resetter = [[StreakResetterView alloc] init];
        resetter.streakCountLbl.hidden = NO;
        resetter.streakResetBtn.hidden = NO;
        resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",daily.streakLength];
        return resetter;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ReminderListView *list = [ReminderListView newWithDueDateInfo:daily];
        list.utilityStore = SharedGlobal;
        
        [keep addControlToActionSetWithKey:takeKey(setDelegate:)];
        [keep addControlToActionSetWithKey:takeKey(setResizeResponder:)];
        return list;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        RateSetContainer *rateContainer = [RateSetContainer newWithDaily:daily];
        rateContainer.utilityStore = SharedGlobal;
        
        [keep addControlToActionSetWithKey:takeKey(setDelegate:)];
        [keep addControlToActionSetWithKey:takeKey(setResizeResponder:)];
        [keep addControlToActionSetWithKey:takeKey(setTblDelegate:)];
        [keep addControlToActionSetWithKey:takeKey(setWeeklyDaysDelegate:)];
        return rateContainer;
    }];
    
    return keep;
}


-(void)setResponders:(SHControlKeep *)keep{
    keep.responderLookup[takeKey(setDelegate:)] = self;
    keep.responderLookup[takeKey(setResizeResponder:)] = self.editorContainer;
    keep.responderLookup[takeKey(setTblDelegate:)] = self;
    keep.responderLookup[takeKey(setWeeklyDaysDelegate:)] = self;
}
@end
