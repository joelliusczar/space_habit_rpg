//
//  RateSetContainerController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetContainer.h"
#import <SHControls/RateTypeSelector.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHSingletonCluster.h>
#import <SHCommon/SHInterceptor.h>
#import <SHModels/SHRateTypeHelper.h>
#import <SHControls/SHItemFlexibleListView.h>


NSString * const YEARLY_KEY = @"yearly";
NSString * const MONTHLY_KEY = @"monthly";
NSString * const WEEKLY_KEY = @"weekly";
NSString * const TBL_KEY = @"TBL";
NSString * const RESIZEABLE_KEY = @"RESIZE";

@interface SHRateSetContainer ()
@property (assign,nonatomic) CGSize defaultSize;
@property (weak,nonatomic) SHView *currentActiveDaysControl;
@end

@implementation SHRateSetContainer

NSString* const defaultInvertBtnText = @"Triggers only on...";
NSString* const invertedInvertBtnText = @"Triggers all days except...";


-(SHWeeklyActiveDays *)weeklyActiveDays{
    return self.rateControls.controlLookup[WEEKLY_KEY];
}


-(SHMonthlyActiveDays *)monthlyActiveDays{
    return self.rateControls.controlLookup[MONTHLY_KEY];
}


-(SHYearlyActiveDays *)yearlyActiveDays{
    return self.rateControls.controlLookup[YEARLY_KEY];
}


-(SHControlKeep *)rateControls{
    if(nil == _rateControls){
        _rateControls = [self buildControlKeep:self.daily];
    }
    return _rateControls;
}


-(void)setTouchCallback:(void (^)(void))touchCallback{
    _touchCallback = touchCallback;
    self.rateControls.responderLookup[WEEKLY_KEY] = touchCallback;
}


-(void)setTblDelegate:(id<SHItemFlexibleListDelegateProtocol>)tblDelegate{
  _tblDelegate = tblDelegate;
  self.rateControls.responderLookup[TBL_KEY] =  tblDelegate;
}

+(instancetype)newWithDaily:(SHDailyDTO *)daily{
  NSAssert(daily,@"daily was nil");
  
  SHRateSetContainer *instance = [[SHRateSetContainer alloc] init];
  instance.daily = daily;
  instance.defaultSize = instance.frame.size;
  instance.rateControls.responderLookup[RESIZEABLE_KEY] = instance;
  [instance updateRateTypeControls:daily.rateType shouldChange:YES];
  [instance updateRateTypeButtonText];
  [instance updateInvertRateTypeButtonText];
  return instance;
}

-(void)commonTableSetup:(SHItemFlexibleListView *)tbl{
  tbl.holderView = self.activeDaysControlContainer;
  tbl.resizeResponder = self;
  tbl.delegate = self.tblDelegate;
  [tbl changeBackgroundColorTo:self.backgroundColor];
}


-(IBAction)setRateTypeBtn_click_action:(UIButton *)sender
  ForEvent:(UIEvent *)event
{
  (void)sender;(void)event;
  RateTypeSelector *typeSelector = [[RateTypeSelector alloc]
    initWithRateType:self.daily.rateType
    andDelegate:self];
  [self.resizeResponder pushViewControllerToNearestParent:typeSelector];
}


-(void)updateRateType:(SHRateType)rateType with:(SHEventInfo *)eventInfo{
  (void)eventInfo;
  [self updateRateType:rateType];
}


-(IBAction)invertRateTypeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
  (void)sender;(void)event;
  [self updateRateType:shInvertRateType(self.daily.rateType)];
}


-(void)scrollVisibleToControl:(SHView *)control{
  (void)control;
  SEL delegateSel = @selector(scrollVisibleToControl:);
  if([self.resizeResponder respondsToSelector:delegateSel]){
      [self.resizeResponder scrollVisibleToControl:self];
  }
}


-(SHControlKeep *)buildControlKeep:(SHDailyDTO *)daily{
  NSAssert(daily,@"Daily should not be nil");
  SHControlKeep *keep = [[SHControlKeep alloc] init];

  //I want to avoid circular references
  //self->keep->keep now has a strong pointer to self
  SHRateSetContainer* __weak weakSelf = self;
  NSString* errMessage = @"RateSetContainer got itself into an inconsistent state";
  
  SHListRateItemCollection * monthRateItems = daily.monthlyActiveDays;
  SHListRateItemCollection * monthRateItemsInv = daily.monthlyActiveDaysInv;
  keep.controlLookup[MONTHLY_KEY] = vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    (void)controlExtent;
    NSAssert(weakSelf,errMessage);
    SHMonthlyActiveDays *monthly = [SHMonthlyActiveDays newWithListRateItemCollection:monthRateItems
      inverseActiveDays:monthRateItemsInv];
    [weakSelf commonTableSetup:monthly];
    [keep forResponderKey:RESIZEABLE_KEY doSetupAction:^(id responder){
        monthly.resizeResponder = responder;
    }];
    [keep forResponderKey:TBL_KEY doSetupAction:^(id responder){
        monthly.delegate = responder;
    }];
    return monthly;
  });

  SHListRateItemCollection * yearRateItems = daily.yearlyActiveDays;
  SHListRateItemCollection * yearRateItemsInv = daily.yearlyActiveDaysInv;
  keep.controlLookup[YEARLY_KEY] =  vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    (void)controlExtent;
    NSAssert(weakSelf,errMessage);
    SHYearlyActiveDays *yearly = [SHYearlyActiveDays newWithListRateItemCollection:yearRateItems
      inverseActiveDays:yearRateItemsInv];
    [weakSelf commonTableSetup: yearly];
    [keep forResponderKey:RESIZEABLE_KEY doSetupAction:^(id responder){
        yearly.resizeResponder = responder;
    }];
    [keep forResponderKey:TBL_KEY doSetupAction:^(id responder){
        yearly.delegate = responder;
    }];
    return yearly;
  });
  keep.controlLookup[WEEKLY_KEY] = vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    (void)controlExtent;
    NSAssert(weakSelf,errMessage);
    SHWeeklyActiveDays *weekly = [[SHWeeklyActiveDays alloc] init];
    [weekly changeBackgroundColorTo:weakSelf.backgroundColor];
    [keep forResponderKey:WEEKLY_KEY doSetupAction:^(id responder){
      //Does this work?
      weekly.touchCallback = responder;
    }];
    return weekly;
  });
    
    return keep;
}


-(void)updateRateType:(SHRateType)rateType{
  [self resetRate];
  BOOL areSame = shAreSameBaseRateTypes(rateType,self.daily.rateType);
  //it is important that this happen before setRateTypeActiveDaysControl:
  //else it will use the old rateType which will have fucky results
  self.daily.rateType = rateType;
  [self updateRateTypeControls:rateType shouldChange:!areSame];
}


-(void)resetRate{
  self.daily.rate = 1;
  self.rateSetter.rateStep.value = 1;//prevent old stepper value from overwriting
}


-(void)updateRateTypeControls:(SHRateType)rateType shouldChange:(BOOL)shouldChange{
  
  if(shouldChange){
      [self setRateTypeActiveDaysControl:rateType];
  }
  else{
      [self refreshActiveDaysControl];
  }
  [self updateRateTypeButtonText];
  [self updateInvertRateTypeButtonText];
}


-(void)updateRateTypeButtonText{
  NSString *formatText = shGetFormatString(self.daily.rateType,self.daily.rate);
  NSString *updatedText = [NSString stringWithFormat:formatText,self.daily.rate ];
  [self.openRateTypeBtn setTitle:updatedText forState:UIControlStateNormal];
}


-(void)updateInvertRateTypeButtonText{
  NSString *buttonText = !shIsInverseRateType(self.daily.rateType)?defaultInvertBtnText:invertedInvertBtnText;
  [self.invertRateTypeBtn setTitle:buttonText forState:UIControlStateNormal];
}


-(void)refreshActiveDaysControl{
  if([self.currentActiveDaysControl isKindOfClass:SHItemFlexibleListView.class]){
    SHItemFlexibleListView *activeDaysList = (SHItemFlexibleListView *)self.currentActiveDaysControl;
    [activeDaysList resetHeight];
    [activeDaysList setupInitialHeight];
    [activeDaysList refreshTable];
    [self fitControlHeightToSubControlHeight:activeDaysList];
    [self.resizeResponder refreshView];
    
  }
  else if([self.currentActiveDaysControl isKindOfClass:SHWeeklyActiveDays.class]){
    BOOL isInverse = shIsInverseRateType(self.daily.rateType);
    NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.daily.weeklyActiveDays: self.daily.weeklyActiveDays;
    [self.weeklyActiveDays setActiveDaysOfWeek:weekInfo];
  }
}

/*
 rate type should be set on daily already
*/
-(void)setRateTypeActiveDaysControl:(SHRateType)rateType{
  rateType = shExtractBaseRateType(rateType);
  [self updateRateTypeButtonText];
  if(rateType == SH_WEEKLY_RATE){
    [self switchActiveDaysControlFor:self.weeklyActiveDays];
    BOOL isInverse = shIsInverseRateType(self.daily.rateType);
    NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.daily.weeklyActiveDays: self.daily.weeklyActiveDays;
    [self.weeklyActiveDays setActiveDaysOfWeek:weekInfo];
  }
  else if(rateType == SH_MONTHLY_RATE){
    [self switchActiveDaysControlFor:self.monthlyActiveDays];
    [self.resizeResponder scrollByOffset:SH_SUB_TABLE_CELL_HEIGHT];
    [self.resizeResponder scrollVisibleToControl:self];
  }
  else if(rateType == SH_YEARLY_RATE){
    [self switchActiveDaysControlFor:self.yearlyActiveDays];
    [self.resizeResponder scrollByOffset:SH_SUB_TABLE_CELL_HEIGHT];
    [self.resizeResponder scrollVisibleToControl:self];
    
  }
  else if(rateType == SH_DAILY_RATE){
    [self switchActiveDaysControlFor:[[SHView alloc] initEmpty]];
    self.currentActiveDaysControl = nil;
  }
}


-(void)switchActiveDaysControlFor:(SHView *)activeDaysControl{
  NSAssert(activeDaysControl,@"activeDaysControl was nil");
  [self fitControlHeightToSubControlHeight:activeDaysControl];
  [self.activeDaysControlContainer
      replaceSubviewsWith:activeDaysControl];
  self.currentActiveDaysControl = activeDaysControl;
}


-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo{
  [eventInfo.senderStack addObject:self];
  [self.delegate rateStep_valueChanged_action:eventInfo];
  [self updateRateTypeButtonText];
}


-(void)resetHeight{
  [self resizeFrame:self.defaultSize];
  [self.activeDaysControlContainer resizeFrame:CGRectZero.size];
}


-(void)fitControlHeightToSubControlHeight:(SHView *)control{
  
  [self resetHeight];
  CGFloat h = control.frame.size.height;
  [self beginUpdate];
  [self resizeHeightByOffset:h];
  [self.activeDaysControlContainer resizeHeightByOffset:h];
  [self endUpdate];
}


-(void)respondToHeightResize:(CGFloat)change{
  [self resizeHeightByOffset:change];
  [self.activeDaysControlContainer resizeHeightByOffset:change];
  [self notify_respondToHeightResize:change];
}


-(void)notify_respondToHeightResize:(CGFloat)change{
  SEL delegateSel = @selector(respondToHeightResize:);
  if([self.resizeResponder respondsToSelector:delegateSel]){
    [self.resizeResponder respondToHeightResize:change];
  }
}


-(void)scrollByOffset:(CGFloat)offset{
  SEL delegateSel = @selector(scrollByOffset:);
  if([self.resizeResponder respondsToSelector:delegateSel]){
    [self.resizeResponder scrollByOffset:offset];
  }
}


-(void)pushViewControllerToNearestParent:(UIViewController *)child{
  [self.resizeResponder pushViewControllerToNearestParent:child];
}


-(void)beginUpdate{
  SEL delegateSel = @selector(beginUpdate);
  if([self.resizeResponder respondsToSelector:delegateSel]){
    [self.resizeResponder beginUpdate];
  }
}


-(void)endUpdate{
  SEL delegateSel = @selector(endUpdate);
  if([self.resizeResponder respondsToSelector:delegateSel]){
    [self.resizeResponder endUpdate];
  }
}

-(void)changeBackgroundColorTo:(UIColor *)color{
  [super changeBackgroundColorTo:color];
  [self.rateSetter changeBackgroundColorTo:color];
  [self.currentActiveDaysControl changeBackgroundColorTo:color];
}


-(void)hideKeyboard{
  [self.resizeResponder hideKeyboard];
}


-(void)refreshView{
  if([self.resizeResponder respondsToSelector:@selector(refreshView)]){
    [self.resizeResponder refreshView];
  }
}


@end
