//
//	SHRemindersLinkViewController.m
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/3/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRemindersLinkViewController.h"
#import "SHReminderListView.h"
#import "SHReminderListContainer.h"

@interface SHRemindersLinkViewController ()
@property (strong, nonatomic) SHReminderListContainer *reminderListView;
@end

@implementation SHRemindersLinkViewController


-(SHReminderListContainer*)reminderListView{
	if(nil == _reminderListView) {

	}
	return _reminderListView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.primaryLabel.text = @"Reminders";
	self.descriptionLabel.text = @"Set reminders";
}


-(void)openNextScreen{
	NSAssert(self.editorContainer,@"You forgot to set the editor container");
	[self.editorContainer arrangeAndPushChildVCToFront:self.reminderListView];
}


@end
