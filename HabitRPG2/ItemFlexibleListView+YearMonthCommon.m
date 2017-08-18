//
//  ItemFlexibleListView+YearMonthCommon.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ItemFlexibleListView+YearMonthCommon.h"

@implementation ItemFlexibleListView (YearMonthCommon)

-(void)addNewItem:(UIPickerView *)picker
      backendList:(NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *)backendList
       fieldNames:(NSArray<NSString *> *)fieldNames{
    
    NSInteger value0 = [picker selectedRowInComponent:0];
    NSInteger value1 = [picker selectedRowInComponent:1];
    
    NSDictionary<NSString *,NSNumber *> *insert = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   fieldNames[0],[NSNumber numberWithInteger:value0]
                                                   ,fieldNames[1],[NSNumber numberWithInteger:value1]
                                                   ,nil];
    [backendList addObject:insert];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:backendList.count -1 inSection:0];
    [self.itemTbl insertRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
    
}




@end
