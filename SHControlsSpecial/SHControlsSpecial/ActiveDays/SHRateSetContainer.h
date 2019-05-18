//
//  RateSetContainerController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#import <SHCommon/SHControlKeep.h>
#import "SHMonthlyActiveDays.h"
#import "SHWeeklyActiveDays.h"
#import "SHYearlyActiveDays.h"
#import <SHData/SHObjectIDWrapper.h>
#import <SHModels/SHDailyActiveDays.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHRateSetContainer :
SHView
<RateTypeSelectorDelegateProtocol
,SHRateSetterDelegateProtocol
,SHResizeResponderProtocol>
@property (weak,nonatomic) IBOutlet SHButton  * _Nullable openRateTypeBtn;
@property (weak,nonatomic) IBOutlet UIView  * _Nullable activeDaysControlContainer;
@property (weak,nonatomic) IBOutlet SHRateSetterView * _Nullable rateSetter;
@property (weak,nonatomic) IBOutlet SHButton * _Nullable invertRateTypeBtn;
@property (readonly,strong,nonatomic) SHMonthlyActiveDays * monthlyActiveDays;
@property (readonly,strong,nonatomic) SHWeeklyActiveDays * weeklyActiveDays;
@property (readonly,strong,nonatomic) SHYearlyActiveDays * yearlyActiveDays;
@property (weak,nonatomic) id<SHRateSetterDelegateProtocol> _Nullable delegate;
@property (weak,nonatomic) id<SHItemFlexibleListDelegateProtocol> _Nullable tblDelegate;
@property (weak,nonatomic) id<SHResizeResponderProtocol> _Nullable resizeResponder;
@property (copy,nonatomic) void (^touchCallback)(void);
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;
@property (strong,nonatomic) SHControlKeep * _Nullable rateControls;
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
+(instancetype)newWithContext:(NSManagedObjectContext *)context
  andObjectID:(SHObjectIDWrapper*)objectIDWrapper;
  
@end

NS_ASSUME_NONNULL_END
