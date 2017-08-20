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

@interface YearlyActiveDays ()
@property (strong,nonatomic) NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *daysOfYear;
@end

@implementation YearlyActiveDays

-(NSMutableArray<NSDictionary<NSString*,NSNumber *> *> *)daysOfYear{
    if(nil == _daysOfYear){
        NSString *activeDays = self.daily.activeDays;
        NSDictionary *dict = [CommonUtilities
                              jsonStringToDict:activeDays];
        if(dict[@"daysOfYear"]){
            _daysOfYear = dict[@"daysOfYear"];
        }
        else{
            _daysOfYear = [NSMutableArray array];
        }
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
    
}


-(NSInteger)backendListCount{
    return self.daysOfYear.count;
}


@end
