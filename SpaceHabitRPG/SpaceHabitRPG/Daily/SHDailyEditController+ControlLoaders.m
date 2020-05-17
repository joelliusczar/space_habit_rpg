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



-(NSMutableArray<SHViewController *> *)buildControlKeep{
	NSAssert(self.activeDays,@"Active days shouldn't be nil");
	NSMutableArray<SHViewController *> *keep = [NSMutableArray array];
	
	NSManagedObjectContext *context = self.context;
	SHObjectIDWrapper *objectIDWrapper = self.objectIDWrapper;
	SHDailyActiveDays *activeDays = self.activeDays;
	__block SHIntervalType rateType = SH_WEEKLY_INTERVAL;
	__block NSString *noteText = @"";
	__block int32_t difficulty = 3;
	__block int32_t urgency = 3;
	__block BOOL newlyInserted = YES;
	__block int32_t streakLength = 0;
	[context performBlockAndWait:^{
		SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
		rateType = daily.intervalType;
		noteText = daily.note.length > 0 ? daily.note : @"";
		difficulty = daily.difficulty;
		urgency = daily.urgency;
		newlyInserted = daily.inserted;
		streakLength = daily.streakLength;
	}];
	
	SHNoteView *note = [[SHNoteView alloc] init];
	note.noteBox.text = noteText;
	note.delegate = self;
	[keep addObject:note];
	
	NSBundle *bundle = [NSBundle bundleForClass:SHRepeatLinkViewController.class];
	SHRepeatLinkViewController *repeatLink = [[SHRepeatLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:bundle];
	repeatLink.editorContainer = self.editorContainerController;
	[repeatLink setupWithContext:context
		andObjectID:objectIDWrapper];
	repeatLink.activeDays = activeDays;
	repeatLink.rateType = rateType;
	[keep addObject:repeatLink];
	
	SHRemindersLinkViewController *remindersLink = [[SHRemindersLinkViewController alloc]
		initWithNibName:@"SHLinkViewController" bundle:bundle];
	remindersLink.editorContainer = self.editorContainerController;
	[remindersLink setupWithContext:context
		andObjectID:objectIDWrapper];
	[keep addObject:remindersLink];
	
	NSBundle *controlsBundle = [NSBundle bundleForClass:SHImportanceSliderView.class];
	SHImportanceSliderView *difficultySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:controlsBundle];
	difficultySld.controlName = @"difficulty";
	[difficultySld updateImportanceSlider:difficulty];
	difficultySld.delegate = self;
	[keep addObject:difficultySld];
	
	SHImportanceSliderView *urgencySld = [[SHImportanceSliderView alloc]
		initWithNibName:NSStringFromClass(SHImportanceSliderView.class)
		bundle:controlsBundle];
	urgencySld.controlName = @"urgency";
	[urgencySld updateImportanceSlider:urgency];
	urgencySld.delegate = self;
	[keep addObject:urgencySld];
	
	SHStreakResetterView *resetter = [[SHStreakResetterView alloc]
		initWithNibName:NSStringFromClass(SHStreakResetterView.class)
		bundle:controlsBundle];
	resetter.streakCountLbl.hidden = !newlyInserted;
	resetter.streakResetBtn.hidden = !newlyInserted;
	resetter.streakCountLbl.text = [NSString stringWithFormat:@"Streak %d",streakLength];
	[keep addObject:resetter];
	
	return keep;
}




@end
