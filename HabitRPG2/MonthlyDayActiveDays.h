//
//  MonthlyDayActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
// 

#import "ItemFlexibleListView.h"
#import "Daily+CoreDataClass.h"

@interface MonthlyDayActiveDays : ItemFlexibleListView
@property (weak,nonatomic) Daily *daily;
+(instancetype)newWithDaily:(Daily *)daily
      andBackViewController:(EditNavigationController *)backViewController;
@end
