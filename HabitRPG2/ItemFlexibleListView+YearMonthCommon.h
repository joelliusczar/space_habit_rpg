//
//  ItemFlexibleListView+YearMonthCommon.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ItemFlexibleListView.h"
#import "Daily+CoreDataClass.h"

@interface ItemFlexibleListView (YearMonthCommon)
-(void)addNewItem:(UIPickerView *)picker
      backendList:(NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *)backendList
       fieldNames:(NSArray<NSString *> *)fieldNames;
+(NSMutableArray *)extractActiveDays:(NSString *)rateTypeKey fromDaily:(Daily *)daily;
@end
