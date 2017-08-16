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
#import "SHView.h"
#import "P_UtilityStore.h"
#import "P_RateTypeSelectorDelegate.h"
#import "P_RateSetterDelegate.h"
#import "Daily+CoreDataClass.h"
#import "EditNavigationController.h"

@interface RateSetContainer :
SHView<P_RateTypeSelectorDelegate,P_RateSetterDelegate>
@property (weak,nonatomic) IBOutlet UIButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet RateSetterView * _Nullable rateSetter;
@property (strong,nonatomic) MonthlyActiveDays * _Nullable monthlyActiveDays;
@property (strong,nonatomic) WeeklyActiveDays * _Nullable weeklyActiveDays;
@property (weak,nonatomic) id<P_RateSetterDelegate> _Nullable delegate;
@property (strong,nonatomic) _Nullable id<P_UtilityStore> utilityStore;
@property (strong,nonatomic) Daily * _Nonnull daily;
@property (strong,nonatomic) EditNavigationController * _Nonnull backViewController;
+(instancetype _Nonnull )newWithDaily:(Daily * _Nonnull)daily
            andBackViewController:(EditNavigationController * _Nonnull)backViewController;
@end
