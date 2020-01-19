//
//	SHYearlyActiveDaysViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/16/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import SHControls;
@import SHModels;


@interface SHYearlyActiveDaysViewController : SHItemFlexibleListView
@property (strong,nonatomic) SHMonthlyYearlyRateItemList *yearRateItems;
@property (strong,nonatomic) SHMonthlyYearlyRateItemList *inverseYearRateItems;
+(instancetype)newWithListRateItemCollection:(SHMonthlyYearlyRateItemList *)activeDays
	inverseActiveDays:(SHMonthlyYearlyRateItemList*)inverseActiveDays;
@end
