//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import <SHCommon/SHControlKeep.h>
#import "SHMonthlyActiveDaysViewController.h"
#import "SHWeeklyActiveDaysViewController.h"
#import "SHYearlyActiveDaysViewController.h"
#import <SHData/SHObjectIDWrapper.h>
#import <SHModels/SHDailyActiveDays.h>
#import <SHControls/SHNestedControlProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHRateSetContainer :
UIViewController
<SHRateTypeSelectorDelegateProtocol
,SHRateSetterDelegateProtocol
,SHResizeResponderProtocol>
@property (weak,nonatomic) IBOutlet UIButton  * _Nullable openRateTypeBtn;
//@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet UIView *rateSetterContainer;
@property (strong,nonatomic) SHRateSetterView * _Nullable rateSetter;
@property (weak,nonatomic) IBOutlet UIButton * _Nullable invertRateTypeBtn;
@property (readonly,strong,nonatomic) SHMonthlyActiveDaysViewController * monthlyActiveDays;
@property (readonly,strong,nonatomic) SHWeeklyActiveDaysViewController * weeklyActiveDays;
@property (readonly,strong,nonatomic) SHYearlyActiveDaysViewController * yearlyActiveDays;
@property (weak,nonatomic) id<SHRateSetterDelegateProtocol> _Nullable delegate;
@property (weak,nonatomic) id<SHItemFlexibleListDelegateProtocol> _Nullable tblDelegate;
@property (weak,nonatomic) id<SHResizeResponderProtocol> _Nullable resizeResponder;
@property (copy,nonatomic) void (^touchCallback)(void);
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
@property (strong,nonatomic) SHControlKeep * _Nullable rateControls;
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@property (weak,nonatomic) UIViewController *editorContainer;
-(void)setupWithContext:(NSManagedObjectContext *)context
  andObjectID:(SHObjectIDWrapper*)objectIDWrapper;
@end

NS_ASSUME_NONNULL_END
