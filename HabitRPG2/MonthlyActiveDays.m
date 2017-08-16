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

@interface MonthlyActiveDays ()
@property (strong,nonatomic) NSMutableArray<NSDictionary *> *daysOfMonth;
@end

@implementation MonthlyActiveDays


-(NSMutableArray<NSDictionary *> *)daysOfMonth{
    if(nil==_daysOfMonth){
        if(self.daily.rateType == MONTHLY_RATE){
            NSString *activeDays = self.daily.activeDays;
            NSDictionary *dict = [CommonUtilities jsonStringToDict:activeDays];
            _daysOfMonth = (NSMutableArray<NSDictionary *> *)dict[@"daysOfMonth"];
        }
        else{
            _daysOfMonth = [NSMutableArray<NSDictionary *> array];
        }
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
    NSString *ordinal = [numFormatter stringFromNumber:monthItemDict[@"ordinal"]];
    NSString *dayOfWeek = self.utilityStore.inUseCalendar.weekdaySymbols[monthItemDict[@"dayOfWeek"].integerValue];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%@ %@",ordinal,dayOfWeek];
    return cell;
}

@end
