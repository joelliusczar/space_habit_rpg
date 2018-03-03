//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import <SHModels/Daily+CoreDataClass.h>
#import <SHCommon/SHControlKeep.h>
#import "MonthlyActiveDays.h"
#import "WeeklyActiveDays.h"
#import "YearlyActiveDays.h"

@interface RateSetContainer :
SHView
<P_RateTypeSelectorDelegate
,P_RateSetterDelegate
,P_ResizeResponder>
@property (weak,nonatomic) IBOutlet SHButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet RateSetterView * _Nullable rateSetter;
@property (weak,nonatomic) IBOutlet SHButton * _Nullable invertRateTypeBtn;
@property (readonly,strong,nonatomic) MonthlyActiveDays * _Nullable monthlyActiveDays;
@property (readonly,strong,nonatomic) WeeklyActiveDays * _Nullable weeklyActiveDays;
@property (readonly,strong,nonatomic) YearlyActiveDays * _Nullable yearlyActiveDays;
@property (weak,nonatomic) id<P_RateSetterDelegate> _Nullable delegate;
@property (weak,nonatomic) id<P_ItemFlexibleListDelegate> _Nullable tblDelegate;
@property (weak,nonatomic) id<P_ResizeResponder> _Nullable resizeResponder;
@property (weak,nonatomic) id<P_WeeklyActiveDaysDelegate> _Nullable weeklyDaysDelegate;
@property (strong,nonatomic) _Nullable id<P_UtilityStore> utilityStore;
@property (strong,nonatomic) Daily * _Nonnull daily;
@property (strong,nonatomic) SHControlKeep * _Nullable rateControls;
+(instancetype _Nonnull )newWithDaily:(Daily * _Nonnull)daily;
@end


