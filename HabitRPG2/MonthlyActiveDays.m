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
#import "ItemFlexibleListView+YearMonthCommon.h"
#import "NSNumber+Helpers.h"

@interface MonthlyActiveDays ()
@property (strong,nonatomic) NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *daysOfMonth;
@end

@implementation MonthlyActiveDays


-(NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *)daysOfMonth{
    if(nil==_daysOfMonth){
        _daysOfMonth = [ItemFlexibleListView extractActiveDays:@"daysOfMonth"
                                                     fromDaily:self.daily];
    }
        
    return _daysOfMonth;
}

+(instancetype)newWithDaily:(Daily *)daily
      andBackViewController:(EditNavigationController *)backViewController{
    NSAssert(daily,@"daily was nil");
    NSAssert(backViewController,@"backViewController was nil");
    
    MonthlyActiveDays *instance = [[MonthlyActiveDays alloc] init];
    instance.backViewController = backViewController;
    instance.daily = daily;
    [instance commonSetup];
    return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daysOfMonth.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    NSDictionary<NSString *,NSNumber *> *monthItemDict = self.daysOfMonth[indexPath.row];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    numFormatter.locale = self.utilityStore.inUseLocale;
    numFormatter.numberStyle = NSNumberFormatterOrdinalStyle;
    NSString *ordinal = [numFormatter stringFromNumber:[monthItemDict[@"ordinal"] plusInteger:1]];
    NSString *dayOfWeek = self.utilityStore.inUseCalendar.weekdaySymbols[monthItemDict[@"dayOfWeek"].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",ordinal,dayOfWeek];
    return cell;
}


-(void)addItemBtn_press_action:(UIButton *)sender
                      forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        MonthPartPicker *dayOfMonthPicker = [[MonthPartPicker alloc] init];
        [self showSHSpinPicker:dayOfMonthPicker];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(UIPickerView *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        [self addNewItem:sender backendList:self.daysOfMonth fieldNames:@[@"ordinal",@"dayOfWeek"]];
        [self scaleTableForAddItem];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(NSInteger)backendListCount{
    return self.daysOfMonth.count;
}


@end
