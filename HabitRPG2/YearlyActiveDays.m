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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daily.inUseActiveDays.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    NSDictionary<NSString *,NSNumber *> *yearItemDict = self.daily.inUseActiveDays[indexPath.row];
    NSString *month = self.utilityStore.inUseCalendar.monthSymbols[yearItemDict[@"month"].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",month,yearItemDict[@"day"]];
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
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        NSInteger row = [self.daily addYearlyItem:self.daily.isInverseRateType
                    monthNum:[picker selectedRowInComponent:0]
                    dayOfMonth:[picker selectedRowInComponent:1]];
        [self scaleTableForAddItem:row];
        [eventInfo.senderStack addObject:self];
        [super pickerSelection_action:eventInfo];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(NSInteger)backendListCount{
    return self.daily.inUseActiveDays.count;
}


@end
