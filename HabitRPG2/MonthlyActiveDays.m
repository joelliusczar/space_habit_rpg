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

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daily.inUseActiveDays.count;
}

#pragma clang diagnostic pop

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    RateValueItemDict *monthItemDict = self.daily.inUseActiveDays[indexPath.row];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.locale = self.utilityStore.inUseLocale;
    numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *ordinal = [numFormatter stringFromNumber:[monthItemDict[ORDINAL_WEEK_KEY] plusInteger:1]];
    NSString *dayOfWeek = self.utilityStore.inUseCalendar.weekdaySymbols[monthItemDict[DAY_OF_WEEK_KEY].integerValue];
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
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        [self addCellWithWeekOrdinal:[picker selectedRowInComponent:0]
                                        dayOfWeek:[picker selectedRowInComponent:1]];
        [eventInfo.senderStack addObject:self];
        [super pickerSelection_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)addCellWithWeekOrdinal:(NSInteger)weekOrdinal dayOfWeek:(NSInteger)dayOfWeek{
    NSInteger row = [self.daily addMonthlyItem:self.daily.isInverseRateType
                                       ordinal:weekOrdinal
                                  dayOfWeekNum:dayOfWeek];
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
