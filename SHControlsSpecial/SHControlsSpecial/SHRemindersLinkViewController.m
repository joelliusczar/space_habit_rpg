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
		NSAssert(self.context,@"You forgot to call setupWithContext:andObjectID:");
		NSBundle *bundle = [NSBundle bundleForClass:SHReminderListContainer.class];
		_reminderListView = [[SHReminderListContainer alloc]
			initWithNibName:NSStringFromClass(SHReminderListContainer.class)
			bundle:bundle];
		[_reminderListView setupWithContext:self.context andObjectID:self.objectIDWrapper];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}
*/

@end
