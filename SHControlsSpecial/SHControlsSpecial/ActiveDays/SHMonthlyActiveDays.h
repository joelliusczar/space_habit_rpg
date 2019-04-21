//
//  SHMonthlyActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
// 

#import <SHControls/SHItemFlexibleListView.h>
#import <SHModels/SHDaily.h>
 

@interface SHMonthlyActiveDays : SHItemFlexibleListView
@property (weak,nonatomic) SHDaily *daily;
+(instancetype)newWithDaily:(SHDaily *)daily;
@end
