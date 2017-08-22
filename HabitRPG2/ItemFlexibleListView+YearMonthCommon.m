//
//  ItemFlexibleListView+YearMonthCommon.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ItemFlexibleListView+YearMonthCommon.h"
#import "CommonUtilities.h"
#import "constants.h"
#import "UIView+Helpers.h"

@implementation ItemFlexibleListView (YearMonthCommon)

-(void)addNewItem:(UIPickerView *)picker
      backendList:(NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *)backendList
       fieldNames:(NSArray<NSString *> *)fieldNames{
    
    NSInteger value0 = [picker selectedRowInComponent:0];
    NSInteger value1 = [picker selectedRowInComponent:1];
    
    NSDictionary<NSString *,NSNumber *> *insert = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSNumber numberWithInteger:value0],fieldNames[0]
                                                   ,[NSNumber numberWithInteger:value1],fieldNames[1]
                                                   ,nil];
    [backendList addObject:insert];
}


+(NSMutableArray *)extractActiveDays:(NSString *)rateTypeKey fromDaily:(Daily *)daily{
    NSAssert(daily,@"daily is nil");
    NSString *activeDays = daily.activeDays;
    NSDictionary *dict = [CommonUtilities jsonStringToDict:activeDays];
    return dict[rateTypeKey]?dict[rateTypeKey]:[NSMutableArray array];
}




@end
