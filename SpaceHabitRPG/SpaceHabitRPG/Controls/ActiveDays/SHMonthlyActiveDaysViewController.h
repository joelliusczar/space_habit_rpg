//
//	SHMonthlyActiveDaysViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
// 

@import SHControls;
@import SHModels;
 

@interface SHMonthlyActiveDaysViewController : SHItemFlexibleListView
@property (strong,nonatomic) SHMonthlyYearlyRateItemList *monthRateItems;
@property (strong,nonatomic) SHMonthlyYearlyRateItemList *inverseMonthRateItems;
+(instancetype)newWithListRateItemCollection:(SHMonthlyYearlyRateItemList *)monthRateItems
	inverseActiveDays:(SHMonthlyYearlyRateItemList*)inverseMonthRateItems;
@end
