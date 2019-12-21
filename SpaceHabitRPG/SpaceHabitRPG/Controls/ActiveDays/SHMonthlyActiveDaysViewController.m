//
//	SHMonthlyActiveDaysViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMonthlyActiveDaysViewController.h"
#import "SHMonthPartPicker.h"
@import SHCommon;

@import SHControls;
@import SHModels;

@interface SHMonthlyActiveDaysViewController ()
@end

@implementation SHMonthlyActiveDaysViewController


+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)activeDays
	inverseActiveDays:(SHListRateItemCollection*)inverseActiveDays
{
	SHMonthlyActiveDaysViewController *instance = [[SHMonthlyActiveDaysViewController alloc] init];
	instance.monthRateItems = activeDays;
	instance.inverseMonthRateItems = inverseActiveDays;
	[instance commonSetup];
	return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	(void)tableView; (void)section;
	return self.monthRateItems.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SHListItemCell *cell = [SHListItemCell getListItemCell:tableView];
	SHListRateItem *rateItem = self.monthRateItems[indexPath.row];
	NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
	numFormatter.locale = NSLocale.currentLocale;
	numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
	NSString *ordinal = [numFormatter stringFromNumber:@(rateItem.majorOrdinal + 1)];
	NSString *dayOfWeek = NSCalendar.currentCalendar.weekdaySymbols[rateItem.minorOrdinal];
	cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@ of the month",ordinal,dayOfWeek];
	return cell;
}


-(void)addItemBtn_press_action{
	#warning this may need to be put back
	//[self hideKeyboard];
	[super addItemBtn_press_action];
	SHMonthPartPicker *dayOfMonthPicker = [[SHMonthPartPicker alloc] init];
	__weak SHMonthlyActiveDaysViewController *weakSelf = self;
	dayOfMonthPicker.spinPickerAction = ^(SHSpinPicker *picker,BOOL *shouldCancel) {
		SHMonthlyActiveDaysViewController *bSelf = weakSelf;
		*shouldCancel = ![bSelf addCellWithPickerSelection: picker];
	};
	[self.linkedViewController arrangeAndPushChildVCToFront:dayOfMonthPicker];
}


-(BOOL)addCellWithPickerSelection:(SHSpinPicker *)picker{
	NSInteger weekOrdinal = [picker selectedRowInComponent: 0];
	NSInteger dayOfWeek = [picker selectedRowInComponent: 1];
	SHListRateItem *rateItem = [[SHListRateItem alloc] initWithMajorOrdinal:weekOrdinal
		minorOrdinal:dayOfWeek];
	NSInteger row = [self.monthRateItems addRateItem:rateItem];
	if(row >= 0){
		[self addItemToTableAndScale:row];
		return YES;
	}
	else {
		[picker animateInvalidSelection];
		return NO;
	}
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
	[self.monthRateItems removeRateItemAtIndex:indexPath.row];
	[self removeItemFromTableAndScale:indexPath];
}


-(NSUInteger)backendListCount{
	return self.monthRateItems.count;
}

@end
