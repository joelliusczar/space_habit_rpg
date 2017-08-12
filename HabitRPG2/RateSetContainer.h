//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import "RateSetterView.h"
#import "SHView.h"
#import "P_TimeUtilityStore.h"
#import "P_RateTypeSelectorDelegate.h"
#import "Daily+CoreDataClass.h"
#import "EditNavigationController.h"

@interface RateSetContainer : SHView<P_RateTypeSelectorDelegate>
@property (weak,nonatomic) IBOutlet UIButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysView;
@property (weak,nonatomic) IBOutlet RateSetterView * _Nullable rateSetter;
@property (strong,nonatomic) _Nullable id<P_TimeUtilityStore> timeStore;
@property (strong,nonatomic) Daily * _Nonnull daily;
@property (strong,nonatomic) EditNavigationController * _Nonnull backViewController;
+(instancetype _Nonnull )newWithDaily:(Daily * _Nonnull)daily
            andBackViewController:(EditNavigationController * _Nonnull)backViewController
                        andTimeStore:(id<P_TimeUtilityStore> _Nonnull)timeStore;
@end
