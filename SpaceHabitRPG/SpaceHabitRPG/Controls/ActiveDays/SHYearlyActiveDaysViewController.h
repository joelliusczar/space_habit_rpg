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
@property (strong,nonatomic) SHListRateItemCollection *yearRateItems;
@property (strong,nonatomic) SHListRateItemCollection *inverseYearRateItems;
+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)activeDays
	inverseActiveDays:(SHListRateItemCollection*)inverseActiveDays;
@end
