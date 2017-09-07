//
//  MonthlyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonthlyActiveDays.h"
#import "CommonUtilities.h"
#import "constants.h"
#import "ListItemCell.h"
#import "SingletonCluster.h"
#import "MonthPartPicker.h"
#import "ViewHelper.h"
#import "Interceptor.h"
#import "NSNumber+Helpers.h"
#import "SHEventInfo.h"

@interface MonthlyActiveDays ()
@end

@implementation MonthlyActiveDays


+(instancetype)newWithDaily:(Daily *)daily{
    NSAssert(daily,@"daily was nil");
    MonthlyActiveDays *instance = [[MonthlyActiveDays alloc] init];
    instance.daily = daily;
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add day of the month" forState:UIControlStateNormal];
    return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daily.inUseActiveDays.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    NSDictionary<NSString *,NSNumber *> *monthItemDict = self.daily.inUseActiveDays[indexPath.row];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.locale = self.utilityStore.inUseLocale;
    numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *ordinal = [numFormatter stringFromNumber:[monthItemDict[@"ordinal"] plusInteger:1]];
    NSString *dayOfWeek = self.utilityStore.inUseCalendar.weekdaySymbols[monthItemDict[@"dayOfWeek"].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",ordinal,dayOfWeek];
    return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        [self hideKeyboard];
        MonthPartPicker *dayOfMonthPicker = [[MonthPartPicker alloc] init];
        [self showSHSpinPicker:dayOfMonthPicker];
        [eventInfo.senderStack addObject:self];
        [super addItemBtn_press_action:eventInfo];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        NSInteger row = [self.daily addMonthlyItem:self.daily.isInverseRateType
                    ordinal:[picker selectedRowInComponent:0]
                    dayOfWeekNum:[picker selectedRowInComponent:1]];
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
