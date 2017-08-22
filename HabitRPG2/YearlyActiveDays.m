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
#import "ItemFlexibleListView+YearMonthCommon.h"

@interface YearlyActiveDays ()
@property (strong,nonatomic) NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *daysOfYear;
@end

@implementation YearlyActiveDays

-(NSMutableArray<NSDictionary<NSString*,NSNumber *> *> *)daysOfYear{
    if(nil == _daysOfYear){
        _daysOfYear = [YearlyActiveDays
                       extractActiveDays:@"daysOfYear" fromDaily:self.daily];
    }
    return _daysOfYear;
}


+(instancetype)newWithDaily:(Daily *)daily
      andBackViewController:(EditNavigationController *)backViewController{
    YearlyActiveDays *instance = [[YearlyActiveDays alloc] init];
    instance.daily = daily;
    instance.backViewController = backViewController;
    [instance commonSetup];
    return instance;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.daysOfYear.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListItemCell *cell = [ListItemCell getListItemCell:tableView];
    NSDictionary<NSString *,NSNumber *> *yearItemDict = self.daysOfYear[indexPath.row];
    NSString *month = self.utilityStore.inUseCalendar.monthSymbols[yearItemDict[@"month"].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",month,yearItemDict[@"day"]];
    return cell;
}


-(void)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        YearPartPicker *dayOfYearPicker = [[YearPartPicker alloc] init];
        [self showSHSpinPicker:dayOfYearPicker];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)pickerSelection_action:(UIPickerView *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        [self addNewItem:sender backendList:self.daysOfYear fieldNames:@[@"month",@"day"]];
        [self scaleTableForAddItem];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(NSInteger)backendListCount{
    return self.daysOfYear.count;
}


@end
