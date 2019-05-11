//
//  SHDailyEditController+ControlLoaders.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHDailyEditController+ControlLoaders.h"
#import <SHControls/AllSHControls.h>
#import <SHControlsSpecial/SHRateSetContainer.h>
#import <SHControlsSpecial/SHReminderListView.h>
#import <SHModels/SHDueDateItem.h>



@implementation SHDailyEditController (ControlLoaders)


-(SHControlKeep *)buildControlKeep:(SHDailyDTO *)daily{
  NSAssert(daily,@"Daily should not be null");
  SHControlKeep *keep = [[SHControlKeep alloc] init];

  
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHNoteView *note = [[SHNoteView alloc] init];
    note.noteBox.text = daily.note.length>0?daily.note:@"";
    [keep forResponderKey:@"_" doSetupAction:^(id responder){
        note.delegate = responder;
    }];
    return note;
  }];
  
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHRateSetContainer *rateContainer = [SHRateSetContainer newWithDaily:daily];
  
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
        rateContainer.touchCallback = responder;
    }];
    return rateContainer;
  }];
  
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHImportanceSliderView *difficultySld = [[SHImportanceSliderView alloc] init];
    difficultySld.controlName = @"difficulty";
    [difficultySld updateImportanceSlider:daily.difficulty];
    [keep forResponderKey:@"_" doSetupAction:^(id responder){
        difficultySld.delegate = responder;
    }];
    return difficultySld;
  } withKey:@"difficultySld"];
  
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHImportanceSliderView *urgencySld = [[SHImportanceSliderView alloc] init];
    urgencySld.controlName = @"urgency";
    [urgencySld updateImportanceSlider:daily.urgency];
    [keep forResponderKey:@"_" doSetupAction:^(id responder){
        urgencySld.delegate = responder;
    }];
    return urgencySld;
  } withKey:@"urgencySld"];
  
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHStreakResetterView *resetter = [[SHStreakResetterView alloc] init];
    resetter.streakCountLbl.hidden = NO;
    resetter.streakResetBtn.hidden = NO;
    resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",daily.streakLength];
    return resetter;
  }];
  
  NSManagedObjectContext *context = [self.parentDailyController.central.dataController newBackgroundContext];
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    SHDueDateItem *dueDateItem = [SHDueDateItem newWithObjectID:daily.objectID andContext:context];
      SHReminderListView *list = [SHReminderListView newWithDueDateItem:dueDateItem];
    
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
