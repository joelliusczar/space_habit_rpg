//
//  YearlyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "YearlyActiveDays.h"
#import "CommonUtilities.h"
#import "ListItemCell.h"
#import "YearPartPicker.h"
#import "Interceptor.h"
#import "SHEventInfo.h"

@interface YearlyActiveDays ()
@end

@implementation YearlyActiveDays

+(instancetype)newWithDaily:(Daily *)daily{
    YearlyActiveDays *instance = [[YearlyActiveDays alloc] init];
    instance.daily = daily;
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add day of the year" forState:UIControlStateNormal];
    return instance;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daily.inUseActiveDays.count;
}

#pragma clang diagnostic pop

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    RateValueItemDict *yearItemDict = self.daily.inUseActiveDays[indexPath.row];
    NSString *month = self.utilityStore.inUseCalendar.monthSymbols[yearItemDict[MONTH_KEY].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",month,yearItemDict[DAY_OF_MONTH_KEY]];
    return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        [self hideKeyboard];
        YearPartPicker *dayOfYearPicker = [[YearPartPicker alloc] init];
        [self showSHSpinPicker:dayOfYearPicker];
        [eventInfo.senderStack addObject:self];
        [super addItemBtn_press_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        [self addCellWithMonth:[picker selectedRowInComponent:0]
                        dayOfMonth:[picker selectedRowInComponent:1]];
        [eventInfo.senderStack addObject:self];
        [super pickerSelection_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)addCellWithMonth:(NSInteger)month dayOfMonth:(NSInteger)dayOfMonth{
    NSInteger row = [self.daily addYearlyItem:self.daily.isInverseRateType
                                     monthNum:month
                                   dayOfMonth:dayOfMonth+1];
    if(row >= 0){
        [self addItemToTableAndScale:row];
    }
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    [self.daily deleteRateValueItem:self.daily.rateType atIndex:indexPath.row];
    [self removeItemFromTableAndScale:indexPath];
}

-(NSInteger)backendListCount{
    return self.daily.inUseActiveDays.count;
}


@end
