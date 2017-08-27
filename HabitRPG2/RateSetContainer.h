//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import "RateSetterView.h"
#import "MonthlyActiveDays.h"
#import "WeeklyActiveDays.h"
#import "YearlyActiveDays.h"
#import "SHView.h"
#import "P_UtilityStore.h"
#import "P_RateTypeSelectorDelegate.h"
#import "P_RateSetterDelegate.h"
#import "Daily+CoreDataClass.h"
#import "EditNavigationController.h"
#import "P_ResizeResponder.h"
#import "P_ItemFlexibleListDelegate.h"

@interface RateSetContainer :
SHView
<P_RateTypeSelectorDelegate
,P_RateSetterDelegate
,P_ResizeResponder>
@property (weak,nonatomic) IBOutlet UIButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet RateSetterView * _Nullable rateSetter;
@property (strong,nonatomic) MonthlyActiveDays * _Nullable monthlyActiveDays;
@property (strong,nonatomic) WeeklyActiveDays * _Nullable weeklyActiveDays;
@property (strong,nonatomic) YearlyActiveDays * _Nullable yearlyActiveDays;
@property (weak,nonatomic) id<P_RateSetterDelegate> _Nullable delegate;
@property (weak,nonatomic) id<P_ItemFlexibleListDelegate> _Nullable tblDelegate;
@property (weak,nonatomic) id<P_ResizeResponder> _Nullable resizeResponder;
@property (strong,nonatomic) _Nullable id<P_UtilityStore> utilityStore;
@property (strong,nonatomic) Daily * _Nonnull daily;
+(instancetype _Nonnull )newWithDaily:(Daily * _Nonnull)daily;
@end

//TODO: work out saving
//TODO: make entire add item view into button
//TODO: fix double cells
