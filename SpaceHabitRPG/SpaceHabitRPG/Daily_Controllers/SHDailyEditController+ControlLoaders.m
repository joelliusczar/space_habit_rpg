//
//  SHDailyEditController+ControlLoaders.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHDailyEditController+ControlLoaders.h"
#import <SHControls/AllSHControls.h>
#import <SHControlsSpecial/SHRateSetContainer.h>
#import <SHControlsSpecial/SHReminderListView.h>
#import <SHControlsSpecial/SHRepeatLinkViewController.h>
#import <SHData/NSManagedObjectContext+Helper.h>



@implementation SHDailyEditController (ControlLoaders)


-(SHControlKeep *)buildControlKeep{
  SHControlKeep *keep = [[SHControlKeep alloc] init];
  
  NSManagedObjectContext *context = self.context;
  SHObjectIDWrapper *objectIDWrapper = self.objectIDWrapper;
  SHDailyActiveDays *activeDays = self.activeDays;
  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    (void)controlExtent;
    SHNoteView *note = [[SHNoteView alloc] init];
    [context performBlock:^{
      SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
      NSString *noteText = daily.note.length>0?daily.note:@"";
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        note.noteBox.text = noteText;
      }];
    }];
    
    [keep forResponderKey:@"self" doSetupAction:^(id responder){
        note.delegate = responder;
    }];
    return note;
  }];
  
  __weak UIViewController *editorContainerController = self.editorContainerController;
  
  [keep addLoaderBlock:^id(SHControlKeep *keep, SHControlExtent *controlExtent){
    (void)controlExtent;
    NSBundle *bundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
    SHRepeatLinkViewController *repeatLink = [[SHRepeatLinkViewController alloc]
      initWithNibName:@"SHRepeatLinkViewController" bundle:bundle];
    repeatLink.editorContainer = editorContainerController;
    [repeatLink setupWithContext:context
      andObjectID:objectIDWrapper];
    return repeatLink;
  }];
  
//  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    NSBundle *bundle = [NSBundle bundleForClass:SHRateSetContainer.class];
//    SHRateSetContainer *rateContainer = [[SHRateSetContainer alloc]
//      initWithNibName:@"SHRateSetContainer"
//      bundle:bundle];
//    rateContainer.activeDays = activeDays;
//    rateContainer.editorContainer = editorContainer;
//    [rateContainer setupWithContext:context
//      andObjectID:objectIDWrapper];
//    [keep forResponderKey:@"touch" doSetupAction:^(id responder){
//      rateContainer.touchCallback = responder;
//    }];
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        rateContainer.delegate = responder;
//    }];
//    [keep forResponderKey:@"resize" doSetupAction:^(id responder){
//        rateContainer.resizeResponder = responder;
//    }];
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        rateContainer.tblDelegate = responder;
//    }];
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        rateContainer.touchCallback = responder;
//    }];
//    return rateContainer;
//  }];
//
//  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    SHImportanceSliderView *difficultySld = [[SHImportanceSliderView alloc] init];
//    difficultySld.controlName = @"difficulty";
//    [context performBlock:^{
//      SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
//      int32_t difficulty = daily.difficulty;
//      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [difficultySld updateImportanceSlider:difficulty];
//      }];
//    }];
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        difficultySld.delegate = responder;
//    }];
//    return difficultySld;
//  } withKey:@"difficultySld"];
//
//  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    SHImportanceSliderView *urgencySld = [[SHImportanceSliderView alloc] init];
//    urgencySld.controlName = @"urgency";
//    [context performBlock:^{
//      SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
//      int32_t urgency = daily.urgency;
//      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [urgencySld updateImportanceSlider:urgency];
//      }];
//    }];
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        urgencySld.delegate = responder;
//    }];
//    return urgencySld;
//  } withKey:@"urgencySld"];
//
//  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)keep; (void)controlExtent;
//    SHStreakResetterView *resetter = [[SHStreakResetterView alloc] init];
//    resetter.streakCountLbl.hidden = NO;
//    resetter.streakResetBtn.hidden = NO;
//    [context performBlock:^{
//      SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
//      int32_t streakLength = daily.streakLength;
//      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",streakLength];
//      }];
//    }];
//    return resetter;
//  }];
//
//  [keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    SHReminderListView *list = [SHReminderListView newWithContext:context
//      withObjectIDWrapper:objectIDWrapper];
//
//    [keep forResponderKey:@"self" doSetupAction:^(id responder){
//        list.delegate = responder;
//    }];
//    [keep forResponderKey:@"resize" doSetupAction:^(id responder){
//        list.resizeResponder = responder;
//    }];
//    return list;
//  }];
//
  
  
  return keep;
}


-(void)setResponders:(SHControlKeep *)keep{
  __weak typeof(self) weakSelf = self;
  keep.responderLookup[@"self"] = self;
  keep.responderLookup[@"resize"] = self.editorContainerController;
  keep.responderLookup[@"touch"] = ^void(){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return;
    [bSelf modelTouched];
  };
}
@end
