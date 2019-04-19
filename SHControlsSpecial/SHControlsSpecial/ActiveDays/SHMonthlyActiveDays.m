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


+(instancetype)newWithDaily:(SHDaily *)daily{
    NSAssert(daily,@"daily was nil");
    SHMonthlyActiveDays *instance = [[SHMonthlyActiveDays alloc] init];
    instance.daily = daily;
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add day of the month" forState:UIControlStateNormal];
    return instance;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.daily.inUseActiveDays.count;
    return 0;
    #warning "unimplemeted";
}

#pragma clang diagnostic pop

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SHListItemCell *cell = [SHListItemCell getListItemCell:tableView];
    SHRateValueItemDict *monthItemDict = nil;//self.daily.inUseActiveDays[indexPath.row];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.locale = NSLocale.currentLocale;
    numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *ordinal = [numFormatter stringFromNumber:[monthItemDict[SH_ORDINAL_WEEK_KEY] plusInteger:1]];
    NSString *dayOfWeek = NSCalendar.currentCalendar.weekdaySymbols[monthItemDict[SH_DAY_OF_WEEK_KEY].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",ordinal,dayOfWeek];
    return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
    shWrapReturnVoid wrappedCall = ^(){
        [self hideKeyboard];
        SHMonthPartPicker *dayOfMonthPicker = [[SHMonthPartPicker alloc] init];
        [self showSHSpinPicker:dayOfMonthPicker];
        [eventInfo.senderStack addObject:self];
        [super addItemBtn_press_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    shWrapReturnVoid wrappedCall = ^(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        [self addCellWithWeekOrdinal:[picker selectedRowInComponent:0]
                                        dayOfWeek:[picker selectedRowInComponent:1]];
        [eventInfo.senderStack addObject:self];
        [super pickerSelection_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)addCellWithWeekOrdinal:(NSInteger)weekOrdinal dayOfWeek:(NSInteger)dayOfWeek{
  #warning unimplemented
//    NSInteger row = [self.daily addMonthlyItem:self.daily.isInverseRateType
//                                       ordinal:weekOrdinal
//                                  dayOfWeekNum:dayOfWeek];
//    if(row >= 0){
//        [self addItemToTableAndScale:row];
//    }
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    //[self.daily deleteRateValueItem:self.daily.rateType atIndex:indexPath.row];
    [self removeItemFromTableAndScale:indexPath];
}


-(NSInteger)backendListCount{
    //return self.daily.inUseActiveDays.count;
    return 0;
}



@end
