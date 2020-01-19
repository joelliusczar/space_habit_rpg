//
//	SHDailyEditController+ControlLoaders.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/21/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHDailyEditController+ControlLoaders.h"
#import "SHRepeatLinkViewController.h"
#import "SHRemindersLinkViewController.h"
@import SHControls;




@implementation SHDailyEditController (ControlLoaders)



-(SHControlKeep *)buildControlKeep{
	NSAssert(self.activeDays,@"Active days shouldn't be nil");
	SHControlKeep *keep = [[SHControlKeep alloc] init];
	
	NSManagedObjectContext *context = self.context;
	SHObjectIDWrapper *objectIDWrapper = self.objectIDWrapper;
	SHDailyActiveDays *activeDays = self.activeDays;
	__block BOOL newlyInserted = NO;
	__block SHRateType rateType;
	__block NSInteger interval = 1;
	[context performBlockAndWait:^{
		SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
		newlyInserted = daily.inserted;
		rateType = daily.rateType;
		interval = daily.rate;
	}];
	
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
	
	__weak SHViewController *editorContainerController = self.editorContainerController;
	
	[keep addLoaderBlock:^id(SHControlKeep *keep, SHControlExtent *controlExtent){
		(void)controlExtent; (void)keep;
		NSBundle *bundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
		SHRepeatLinkViewController *repeatLink = [[SHRepeatLinkViewController alloc]
			initWithNibName:@"SHLinkViewController" bundle:bundle];
		repeatLink.editorContainer = editorContainerController;
		[repeatLink setupWithContext:context
			andObjectID:objectIDWrapper];
		repeatLink.activeDays = activeDays;
		repeatLink.rateType = rateType;
		return repeatLink;
	}];
	
	[keep addLoaderBlock:^id(SHControlKeep *keep, SHControlExtent *controlExtent){
		(void)controlExtent; (void)keep;
		NSBundle *bundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
		SHRemindersLinkViewController *remindersLink = [[SHRemindersLinkViewController alloc]
			initWithNibName:@"SHLinkViewController" bundle:bundle];
		remindersLink.editorContainer = editorContainerController;
		[remindersLink setupWithContext:context
			andObjectID:objectIDWrapper];
		return remindersLink;
	}];
	
	[keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
		(void)controlExtent;
		NSBundle *bundle = [NSBundle bundleForClass:SHImportanceSliderView.class];
		SHImportanceSliderView *difficultySld = [[SHImportanceSliderView alloc]
			initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
			bundle:bundle];
		difficultySld.controlName = @"difficulty";
		[context performBlock:^{
			SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
			int32_t difficulty = daily.difficulty;
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[difficultySld updateImportanceSlider:difficulty];
			}];
		}];
		[keep forResponderKey:@"self" doSetupAction:^(id responder){
				difficultySld.delegate = responder;
		}];
		return difficultySld;
	} withKey:@"difficultySld"];

	[keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
		(void)controlExtent;
		NSBundle *bundle = [NSBundle bundleForClass:SHImportanceSliderView.class];
		SHImportanceSliderView *urgencySld = [[SHImportanceSliderView alloc]
			initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
			bundle:bundle];
		urgencySld.controlName = @"urgency";
		[context performBlock:^{
			SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
			int32_t urgency = daily.urgency;
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[urgencySld updateImportanceSlider:urgency];
			}];
		}];
		[keep forResponderKey:@"self" doSetupAction:^(id responder){
				urgencySld.delegate = responder;
		}];
		return urgencySld;
	} withKey:@"urgencySld"];
	
	if(!newlyInserted) {
		[keep addLoaderBlock:^id(SHControlKeep *keep,SHControlExtent *controlExtent){
			(void)keep; (void)controlExtent;
			NSBundle *bundle = [NSBundle bundleForClass:SHStreakResetterView.class];
			SHStreakResetterView *resetter = [[SHStreakResetterView alloc]
				initWithNibName:NSStringFromClass(SHStreakResetterView.class)
				bundle:bundle];
			resetter.streakCountLbl.hidden = NO;
			resetter.streakResetBtn.hidden = NO;
			[context performBlock:^{
				SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
				int32_t streakLength = daily.streakLength;
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",streakLength];
				}];
			}];
			return resetter;
		}];
	}
	
	return keep;
}


-(void)setResponders:(SHControlKeep *)keep{
	__weak SHDailyEditController *weakSelf = self;
	keep.responderLookup[@"self"] = self;
	keep.responderLookup[@"resize"] = self.editorContainerController;
	keep.responderLookup[@"touch"] = ^void(){
		SHDailyEditController *bSelf = weakSelf;
		if(nil == bSelf) return;
		[bSelf modelTouched];
	};
}


@end
