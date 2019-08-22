//
//	SHReminderListView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/25/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHReminderListView.h"
#import "SHReminderCellController.h"
#import <SHControls/SHAddItemsFooter.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHMath.h>
#import "SHReminderTimeSpinPicker.h"
#import <SHControls/UIView+Helpers.h>
#import <SHControls/UIScrollView+ScrollAdjusters.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHNotificationHelper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>
#import <SHModels/SHReminderDTO.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/SHReminder.h>
#import <SHCommon/NSLocale+Helper.h>
#import <SHCommon/NSDate+DateHelper.h>

@interface SHReminderListView()
@end

@implementation SHReminderListView


+(instancetype)newWithContext:(NSManagedObjectContext *)context
	withObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper
{
	SHReminderListView *instance = [[SHReminderListView alloc] init];
	instance.context = context;
	instance.objectIDWrapper = objectIDWrapper;
	[instance commonSetup];
	//[instance.addItemsFooter.addItemBtn setTitle:@"Add New Reminder" forState:UIControlStateNormal];
	return instance;
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
	(void)tableView; (void)section;
	__block NSInteger count = 0;
	[self.context performBlockAndWait:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		count = dueDateItem.reminderCount;
	}];
	return count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	__block NSManagedObjectID *reminderObjectID = nil;
	__block NSString *descText = nil;
	[self.context performBlockAndWait:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		SHReminder *reminder = [dueDateItem reminderAtIndex:indexPath.row];
		reminderObjectID = reminder.objectID;
		NSString *daysBeforeText = reminder.daysBeforeDue == 0 ? @"Every day"
			: [NSString stringWithFormat:@"%d days before",reminder.daysBeforeDue];
		NSDate *time = [NSDate dateWithTimeIntervalSince1970:reminder.reminderHour];
		
		descText = [NSString stringWithFormat:@"%@ at %@",
			daysBeforeText,
			[time staticTimeOfDay]];
	}];
	SHReminderCellController *cell =
	[SHReminderCellController getReminderCell:tableView withParent:self
		andObjectID:reminderObjectID];
	cell.lblRowDesc.text = descText;
	return cell;
}


-(void)addItemBtn_press_action{
	[self hideKeyboard];
	[self.context performBlock:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		NSInteger maxDaysBefore = dueDateItem.maxDaysBeforeSpan;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			SHReminderTimeSpinPicker *timePicker = [[SHReminderTimeSpinPicker alloc]
				initWithDayRange:maxDaysBefore];
			timePicker.spinPickerAction = ^(SHSpinPicker *picker, BOOL *shouldCancel) {
				(void)shouldCancel;
				[self pickerSelection_action: picker];
			};
			[self.parentViewController arrangeAndPushChildVCToFront:timePicker];
		}];
	}];
}


-(void)pickerSelection_action:(SHSpinPicker *)picker{
	NSInteger hour = [picker selectedRowInComponent:SH_HOUR_OF_DAY_COL];
	NSInteger minute = [picker selectedRowInComponent:SH_MINUTE_COL];
	BOOL is24hrs = NSLocale.currentLocale.isUsing24HourFormat;
	int32_t daysBeforeCol = is24hrs ? SH_DAYS_BEFORE_COL_IN_24_HOUR_CLOCK :
		SH_DAYS_BEFORE_COL_IN_12_HOUR_CLOCK;
	NSInteger daysBefore = [picker selectedRowInComponent:daysBeforeCol];
	NSUInteger newIndex = [self insertNewReminder:hour minute:minute daysBefore:daysBefore];
	[self addItemToTableAndScale:newIndex];
}


-(NSUInteger)insertNewReminder:(NSInteger)hour minute:(NSInteger)minute
	daysBefore:(NSInteger)daysBefore
{
	__block NSUInteger index = 0;
	[self.context performBlockAndWait:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		index = [dueDateItem reminderCount];
		SHReminder *reminder = (SHReminder *)[self.context newEntity:SHReminder.entity];
		//we only really care about the hour and minute
		reminder.reminderHour = [NSDate createSimpleTimeWithHour:hour minute:minute second:0].timeIntervalSince1970;
		reminder.daysBeforeDue = [SHMath toIntExact:daysBefore];
		[dueDateItem addNewReminder:reminder];
	}];
	return index;
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
	[self.context performBlock:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		[dueDateItem removeReminderAtIndex:indexPath.row];
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self removeItemFromTableAndScale:indexPath];
		}];
	}];
}


-(NSUInteger)backendListCount{
	__block NSInteger count = 0;
	[self.context performBlockAndWait:^{
		id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
			getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
		count = dueDateItem.reminderCount;
	}];
	return count;
}

@end
