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
    keep.customProps[@"daily"] = daily;
    
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NoteView *note = [[NoteView alloc] init];
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        note.noteBox.text = daily.note.length>0?daily.note:@"";
        [keep addControlToActionSet:note withKey:takeKey(setDelegate:)];
        return note;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        RateSetterView *rateSetter = [[RateSetterView alloc] init];
        return rateSetter;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *difficultySld = [[ImportanceSliderView alloc] init];
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        difficultySld.controlName = @"difficulty";
        [difficultySld updateImportanceSlider:daily.difficulty];
        [keep addControlToActionSet:difficultySld withKey:takeKey(setDelegate:)];
        controlExtent.key = @"difficultySld";
        return difficultySld;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *urgencySld = [[ImportanceSliderView alloc] init];
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        urgencySld.controlName = @"urgency";
        [urgencySld updateImportanceSlider:daily.urgency];
        [keep addControlToActionSet:urgencySld withKey:takeKey(setDelegate:)];
        controlExtent.key = @"urgencySld";
        return urgencySld;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        StreakResetterView *resetter = [[StreakResetterView alloc] init];
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        resetter.streakCountLbl.hidden = NO;
        resetter.streakResetBtn.hidden = NO;
        resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",daily.streakLength];
        return resetter;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        ReminderListView *list = [ReminderListView newWithDueDateInfo:daily];
        list.utilityStore = SharedGlobal;
        
        [keep addControlToActionSet:list withKey:takeKey(setDelegate:)];
        [keep addControlToActionSet:list withKey:takeKey(setResizeResponder:)];
        return list;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        Daily *daily = (Daily *)keep.customProps[@"daily"];
        RateSetContainer *rateContainer = [RateSetContainer newWithDaily:daily];
        rateContainer.utilityStore = SharedGlobal;
        
        [keep addControlToActionSet:rateContainer withKey:takeKey(setDelegate:)];
        [keep addControlToActionSet:rateContainer withKey:takeKey(setResizeResponder:)];
        [keep addControlToActionSet:rateContainer withKey:takeKey(setTblDelegate:)];
        [keep addControlToActionSet:rateContainer withKey:takeKey(setWeeklyDaysDelegate:)];
        return rateContainer;
    }];
    
    return keep;
}


-(void)setResponders:(SHControlKeep *)keep{
    keep[takeKey(setDelegate:)] = self;
    keep[takeKey(setResizeResponder:)] = self.editorContainer;
    keep[takeKey(setTblDelegate:)] = self;
    keep[takeKey(setWeeklyDaysDelegate:)] = self;
}
@end
