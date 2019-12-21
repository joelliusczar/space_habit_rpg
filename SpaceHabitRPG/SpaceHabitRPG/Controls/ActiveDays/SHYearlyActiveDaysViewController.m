//
//	SHYearlyActiveDaysViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/16/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHYearlyActiveDaysViewController.h"
#import "SHYearPartPicker.h"
@import SHCommon;
@import SHControls;
@import SHModels;


@interface SHYearlyActiveDaysViewController ()
@end

@implementation SHYearlyActiveDaysViewController

+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)rateItems
	inverseActiveDays:(SHListRateItemCollection*)inverseRateItems
{
	SHYearlyActiveDaysViewController *instance = [[SHYearlyActiveDaysViewController alloc] init];
	instance.yearRateItems = rateItems;
	instance.inverseYearRateItems = inverseRateItems;
	[instance commonSetup];
	//[instance.addItemsFooter.addItemBtn setTitle:@"Add day of the year" forState:UIControlStateNormal];
	return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	(void)tableView; (void)section;
	return self.yearRateItems.count;;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	SHListItemCell *cell = [SHListItemCell getListItemCell:tableView];
	SHListRateItem *rateItem = self.yearRateItems[indexPath.row];
	NSString *month = NSCalendar.currentCalendar.monthSymbols[rateItem.majorOrdinal];
	cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %ld",month,rateItem.minorOrdinal + 1];
	return cell;
}


-(void)addItemBtn_press_action{
	#warning this may need to be put back
	//[self hideKeyboard];
	SHYearPartPicker *dayOfYearPicker = [[SHYearPartPicker alloc] init];
	__weak SHYearlyActiveDaysViewController *weakSelf = self;
	dayOfYearPicker.spinPickerAction =	^(SHSpinPicker *picker,BOOL *shouldCancel) {
		SHYearlyActiveDaysViewController *bSelf = weakSelf;
		*shouldCancel = ![bSelf addCellWithPickerSelection:picker];
	};
	[self.linkedViewController arrangeAndPushChildVCToFront:dayOfYearPicker];
}


-(BOOL)addCellWithPickerSelection:(SHSpinPicker *)picker{
	NSInteger month = [picker selectedRowInComponent:0];
	NSInteger dayOfMonth = [picker selectedRowInComponent:1];
	SHListRateItem *rateItem = [[SHListRateItem alloc] initWithMajorOrdinal:month
		minorOrdinal:dayOfMonth];
	NSInteger row = [self.yearRateItems addRateItem:rateItem];
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
	[self.yearRateItems removeRateItemAtIndex:indexPath.row];
	[self removeItemFromTableAndScale:indexPath];
}



@end
