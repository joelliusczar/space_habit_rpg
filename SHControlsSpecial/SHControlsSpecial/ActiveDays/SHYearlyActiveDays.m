//
//  SHYearlyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHYearlyActiveDays.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/SHListItemCell.h>
#import "SHYearPartPicker.h"
#import <SHCommon/SHInterceptor.h>
#import <SHControls/SHEventInfo.h>
#import <SHModels/SHModelConstants.h>
#import <SHModels/SHListRateItem.h>
#import <SHGlobal/SHConstants.h>

@interface SHYearlyActiveDays ()
@end

@implementation SHYearlyActiveDays

+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)activeDays
  inverseActiveDays:(SHListRateItemCollection*)inverseActiveDays
{
    SHYearlyActiveDays *instance = [[SHYearlyActiveDays alloc] init];
    instance.activeDays = activeDays;
    instance.inverseActiveDays = inverseActiveDays;
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add day of the year" forState:UIControlStateNormal];
    return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  (void)tableView; (void)section;
  return self.activeDays.count;;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SHListItemCell *cell = [SHListItemCell getListItemCell:tableView];
  SHListRateItem *rateItem = self.activeDays[indexPath.row];
  NSString *month = NSCalendar.currentCalendar.monthSymbols[rateItem.majorOrdinal];
  cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %ld",month,rateItem.minorOrdinal + 1];
  return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
  [self hideKeyboard];
  SHYearPartPicker *dayOfYearPicker = [[SHYearPartPicker alloc] init];
  [self showSHSpinPicker:dayOfYearPicker];
  [eventInfo.senderStack addObject:self];
  [super addItemBtn_press_action:eventInfo];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
  UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
  [self addCellWithMonth:[picker selectedRowInComponent:0]
    dayOfMonth:[picker selectedRowInComponent:1]];
  [eventInfo.senderStack addObject:self];
  [super pickerSelection_action:eventInfo];
}


-(void)addCellWithMonth:(NSInteger)month dayOfMonth:(NSInteger)dayOfMonth{
  SHListRateItem *rateItem = [[SHListRateItem alloc] initWithMajorOrdinal:month
    minorOrdinal:dayOfMonth + 1];
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
