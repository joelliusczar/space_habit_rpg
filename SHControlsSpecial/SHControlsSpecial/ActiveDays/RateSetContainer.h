//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import <SHModels/SHDaily+CoreDataClass.h>
#import <SHCommon/SHControlKeep.h>
#import "MonthlyActiveDays.h"
#import "WeeklyActiveDays.h"
#import "YearlyActiveDays.h"

@interface RateSetContainer :
SHView
<RateTypeSelectorDelegateProtocol
,SHRateSetterDelegateProtocol
,SHResizeResponderProtocol>
@property (weak,nonatomic) IBOutlet SHButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet SHRateSetterView * _Nullable rateSetter;
@property (weak,nonatomic) IBOutlet SHButton * _Nullable invertRateTypeBtn;
@property (readonly,strong,nonatomic) MonthlyActiveDays * _Nullable monthlyActiveDays;
@property (readonly,strong,nonatomic) WeeklyActiveDays * _Nullable weeklyActiveDays;
@property (readonly,strong,nonatomic) YearlyActiveDays * _Nullable yearlyActiveDays;
@property (weak,nonatomic) id<SHRateSetterDelegateProtocol> _Nullable delegate;
@property (weak,nonatomic) id<P_ItemFlexibleListDelegate> _Nullable tblDelegate;
@property (weak,nonatomic) id<SHResizeResponderProtocol> _Nullable resizeResponder;
@property (weak,nonatomic) id<P_WeeklyActiveDaysDelegate> _Nullable weeklyDaysDelegate;
@property (strong,nonatomic) SHDaily * _Nonnull daily;
@property (strong,nonatomic) SHControlKeep * _Nullable rateControls;
+(instancetype _Nonnull )newWithDaily:(SHDaily * _Nonnull)daily;
@end


