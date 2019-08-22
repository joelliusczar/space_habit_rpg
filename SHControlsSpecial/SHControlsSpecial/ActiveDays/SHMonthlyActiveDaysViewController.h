//
//	SHMonthlyActiveDaysViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
// 

#import <SHControls/SHItemFlexibleListView.h>
#import <SHModels/SHListRateItemCollection.h>
 

@interface SHMonthlyActiveDaysViewController : SHItemFlexibleListView
@property (strong,nonatomic) SHListRateItemCollection *monthRateItems;
@property (strong,nonatomic) SHListRateItemCollection *inverseMonthRateItems;
+(instancetype)newWithListRateItemCollection:(SHListRateItemCollection *)monthRateItems
	inverseActiveDays:(SHListRateItemCollection*)inverseMonthRateItems;
@end
