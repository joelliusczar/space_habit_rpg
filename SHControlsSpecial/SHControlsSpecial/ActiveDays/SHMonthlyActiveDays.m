//
//  SHMonthlyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMonthlyActiveDays.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHGlobal/SHConstants.h>
#import <SHControls/SHListItemCell.h>
#import <SHCommon/SHSingletonCluster.h>
#import "SHMonthPartPicker.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSNumber+Helper.h>
#import <SHControls/SHEventInfo.h>
#import <SHModels/SHModelConstants.h>

@interface SHMonthlyActiveDays ()
@end

@implementation SHMonthlyActiveDays


+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)activeDays
  inverseActiveDays:(SHListRateItemCollection*)inverseActiveDays
{
  SHMonthlyActiveDays *instance = [[SHMonthlyActiveDays alloc] init];
  instance.activeDays = activeDays;
  instance.inverseActiveDays = inverseActiveDays;
  [instance commonSetup];
  [instance.addItemsFooter.addItemBtn setTitle:@"Add day of the month" forState:UIControlStateNormal];
  return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  (void)tableView; (void)section;
  return self.activeDays.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SHListItemCell *cell = [SHListItemCell getListItemCell:tableView];
  SHListRateItem *rateItem = self.activeDays[indexPath.row];
  NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
  numFormatter.locale = NSLocale.currentLocale;
  numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
  NSString *ordinal = [numFormatter stringFromNumber:@(rateItem.majorOrdinal)];
  NSString *dayOfWeek = NSCalendar.currentCalendar.weekdaySymbols[rateItem.minorOrdinal];
  cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",ordinal,dayOfWeek];
  return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
  [self hideKeyboard];
  SHMonthPartPicker *dayOfMonthPicker = [[SHMonthPartPicker alloc] init];
  [self showSHSpinPicker:dayOfMonthPicker];
  [eventInfo.senderStack addObject:self];
  [super addItemBtn_press_action:eventInfo];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
  UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
  [self addCellWithWeekOrdinal:[picker selectedRowInComponent:0]
    dayOfWeek:[picker selectedRowInComponent:1]];
  [eventInfo.senderStack addObject:self];
  [super pickerSelection_action:eventInfo];
}


-(void)addCellWithWeekOrdinal:(NSInteger)weekOrdinal dayOfWeek:(NSInteger)dayOfWeek{
  SHListRateItem *rateItem = [[SHListRateItem alloc] initWithMajorOrdinal:weekOrdinal
    minorOrdinal:dayOfWeek];
  NSInteger row = [self.activeDays addRateItem:rateItem];
  if(row >= 0){
    [self addItemToTableAndScale:row];
  }
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
  [self.activeDays removeRateItemAtIndex:indexPath.row];
  [self removeItemFromTableAndScale:indexPath];
}



@end
