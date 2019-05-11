//
//  SHMonthlyActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
// 

#import <SHControls/SHItemFlexibleListView.h>
#import <SHModels/SHListRateItemCollection.h>
 

@interface SHMonthlyActiveDays : SHItemFlexibleListView
@property (strong,nonatomic) SHListRateItemCollection *activeDays;
@property (strong,nonatomic) SHListRateItemCollection *inverseActiveDays;
+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)activeDays
  inverseActiveDays:(SHListRateItemCollection*)inverseActiveDays;
@end
