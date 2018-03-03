//
//  MonthlyActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
// 

#import <SHControls/ItemFlexibleListView.h>
#import <SHModels/Daily+CoreDataClass.h>
 

@interface MonthlyActiveDays : ItemFlexibleListView
@property (weak,nonatomic) Daily *daily;
+(instancetype)newWithDaily:(Daily *)daily;
@end
