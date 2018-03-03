//
//  DailyEditController+ControlLoaders.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "DailyEditController+ControlLoaders.h"
#import <SHControls/AllSHControls.h>
#import <SHControlsSpecial/RateSetContainer.h>
#import <SHControlsSpecial/ReminderListView.h>



@implementation DailyEditController (ControlLoaders)


-(SHControlKeep *)buildControlKeep:(Daily *)daily{
    NSAssert(daily,@"Daily should not be null");
    SHControlKeep *keep = [[SHControlKeep alloc] init];

    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NoteView *note = [[NoteView alloc] init];
        note.noteBox.text = daily.note.length>0?daily.note:@"";
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            note.delegate = responder;
        }];
        return note;
    }];
    
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        RateSetContainer *rateContainer = [RateSetContainer newWithDaily:daily];
        rateContainer.utilityStore = SharedGlobal;
        
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            rateContainer.delegate = responder;
        }];
        [keep forResponderKey:@"resize" doSetupAction:^(id responder){
            rateContainer.resizeResponder = responder;
        }];
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            rateContainer.tblDelegate = responder;
        }];
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            rateContainer.weeklyDaysDelegate = responder;
        }];
        return rateContainer;
    }];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *difficultySld = [[ImportanceSliderView alloc] init];
        difficultySld.controlName = @"difficulty";
        [difficultySld updateImportanceSlider:daily.difficulty];
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            difficultySld.delegate = responder;
        }];
        return difficultySld;
    } withKey:@"difficultySld"];
    
    [keep addLoaderBlock:^id(SHControlKeep *keep,ControlExtent *controlExtent){
        ImportanceSliderView *urgencySld = [[ImportanceSliderView alloc] init];
        urgencySld.controlName = @"urgency";
        [urgencySld updateImportanceSlider:daily.urgency];
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            urgencySld.delegate = responder;
        }];
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
        
        
        [keep forResponderKey:@"_" doSetupAction:^(id responder){
            list.delegate = responder;
        }];
        [keep forResponderKey:@"resize" doSetupAction:^(id responder){
            list.resizeResponder = responder;
        }];
        return list;
    }];
    
    
    
    return keep;
}


-(void)setResponders:(SHControlKeep *)keep{
    keep.responderLookup[@"_"] = self;
    keep.responderLookup[@"resize"] = self.editorContainer;
    keep.responderLookup[@"_"] = self;
    keep.responderLookup[@"_"] = self;
}
@end
