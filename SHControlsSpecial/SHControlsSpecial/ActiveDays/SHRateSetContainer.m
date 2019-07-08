//
//  RateSetContainerController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetContainer.h"
#import <SHControls/SHRateTypeSelector.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHSingletonCluster.h>
#import <SHCommon/SHInterceptor.h>
#import <SHModels/SHRateTypeHelper.h>
#import <SHControls/SHItemFlexibleListView.h>
#import <SHModels/SHDaily.h>
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHData/NSManagedObjectContext+Helper.h>

NSString * const YEARLY_KEY = @"yearly";
NSString * const MONTHLY_KEY = @"monthly";
NSString * const WEEKLY_KEY = @"weekly";
NSString * const TBL_KEY = @"TBL";
NSString * const RESIZEABLE_KEY = @"RESIZE";

@interface SHRateSetContainer ()
@property (assign,nonatomic) CGSize defaultSize;
@property (weak,nonatomic) UIViewController<SHNestedControlProtocol> *currentActiveDaysControl;
@end

@implementation SHRateSetContainer

NSString* const defaultInvertBtnText = @"Triggers only on...";
NSString* const invertedInvertBtnText = @"Triggers all days except...";


-(SHWeeklyActiveDaysViewController *)weeklyActiveDays{
    return self.rateControls.controlLookup[WEEKLY_KEY];
}


-(SHMonthlyActiveDaysViewController *)monthlyActiveDays{
    return self.rateControls.controlLookup[MONTHLY_KEY];
}


-(SHYearlyActiveDaysViewController *)yearlyActiveDays{
    return self.rateControls.controlLookup[YEARLY_KEY];
}


-(SHControlKeep *)rateControls{
    if(nil == _rateControls){
        _rateControls = [self buildControlKeep];
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

-(void)setupWithContext:(NSManagedObjectContext *)context
  andObjectID:(SHObjectIDWrapper*)objectIDWrapper
{
  self.context = context;
  self.objectIDWrapper = objectIDWrapper;;
  self.rateControls.responderLookup[RESIZEABLE_KEY] = self;
  __block SHRateType rateType = SH_DAILY_RATE;
  [context performBlockAndWait:^{
    SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:objectIDWrapper];
    rateType = daily.rateType;
  }];
  [self updateRateTypeControls:rateType shouldChange:YES];
}

-(void)viewDidLoad{
  [super viewDidLoad];
  self.rateSetter = [[SHRateSetterView alloc] init];
  //[self pushChildVC:self.rateSetter toViewOfParent:self.rateSetterContainer];
  
}

-(void)commonTableSetup:(SHItemFlexibleListView *)tbl{
  [self addChildViewController:tbl];
  [self.view addSubview:tbl.view];
  [tbl didMoveToParentViewController:self];
  tbl.resizeResponder = self;
  tbl.delegate = self.tblDelegate;
  [tbl changeBackgroundColorTo:self.view.backgroundColor];
}


-(IBAction)setRateTypeBtn_click_action:(UIButton *)sender
  ForEvent:(UIEvent *)event
{
  (void)sender;(void)event;
  __block SHRateType rateType = SH_DAILY_RATE;
  [self.context performBlockAndWait:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    rateType = daily.rateType;
  }];
  SHRateTypeSelector *typeSelector = [[SHRateTypeSelector alloc]
    initWithRateType:rateType andDelegate:self];
  [self.resizeResponder pushViewControllerToNearestParent:typeSelector];
}


-(void)updateRateType:(SHRateType)rateType with:(SHEventInfo *)eventInfo{
  (void)eventInfo;
  [self updateRateType:rateType];
}


-(IBAction)invertRateTypeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
  (void)sender;(void)event;
  __block SHRateType rateType = SH_DAILY_RATE;
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    rateType = daily.rateType;
  }];
  [self updateRateType:shInvertRateType(rateType)];
}


-(void)scrollVisibleToControl:(SHView *)control{
  (void)control;
  SEL delegateSel = @selector(scrollVisibleToControl:);
  if([self.resizeResponder respondsToSelector:delegateSel]){
      [self.resizeResponder scrollVisibleToControl:self];
  }
}


-(SHControlKeep *)buildControlKeep{
  SHControlKeep *keep = [[SHControlKeep alloc] init];

  #warning cleanup
  //I want to avoid circular references
  //self->keep->keep now has a strong pointer to self
  __weak SHRateSetContainer* weakSelf = self;
  NSString* errMessage = @"RateSetContainer got itself into an inconsistent state";
//  shGetListRateCollection getMonthRateItems = self.activeDays.monthlyActiveDaysLazy;
//  shGetListRateCollection getMonthRateItemsInv = self.activeDays.monthlyActiveDaysInvLazy;
//  keep.controlLookup[MONTHLY_KEY] = vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    NSAssert(weakSelf,errMessage);
//    NSLog(@"Doing it this way!");
//    SHMonthlyActiveDaysViewController *monthly = [SHMonthlyActiveDaysViewController newWithListRateItemCollection:getMonthRateItems()
//      inverseActiveDays:getMonthRateItemsInv()];
//    NSLog(@"Inito!");
//    [weakSelf commonTableSetup:monthly];
//    NSLog(@"table!");
//    [keep forResponderKey:RESIZEABLE_KEY doSetupAction:^(id responder){
//        monthly.resizeResponder = responder;
//    }];
//    [keep forResponderKey:TBL_KEY doSetupAction:^(id responder){
//        monthly.delegate = responder;
//    }];
//    return monthly;
//  });
//
//  shGetListRateCollection getYearRateItems = self.activeDays.yearlyActiveDaysLazy;
//  shGetListRateCollection getYearRateItemsInv = self.activeDays.yearlyActiveDaysInvLazy;
//  keep.controlLookup[YEARLY_KEY] =  vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
//    (void)controlExtent;
//    NSAssert(weakSelf,errMessage);
//    SHYearlyActiveDaysViewController *yearly = [SHYearlyActiveDaysViewController newWithListRateItemCollection:getYearRateItems()
//      inverseActiveDays:getYearRateItemsInv()];
//    [weakSelf commonTableSetup: yearly];
//    [keep forResponderKey:RESIZEABLE_KEY doSetupAction:^(id responder){
//        yearly.resizeResponder = responder;
//    }];
//    [keep forResponderKey:TBL_KEY doSetupAction:^(id responder){
//        yearly.delegate = responder;
//    }];
//    return yearly;
//  });
  keep.controlLookup[WEEKLY_KEY] = vw(^id(SHControlKeep *keep,SHControlExtent *controlExtent){
    (void)controlExtent;
    typeof(weakSelf) bSelf = weakSelf;
    NSAssert(bSelf,errMessage);
    SHWeeklyActiveDaysViewController *weekly = [[SHWeeklyActiveDaysViewController alloc] init];
    [weekly setupCustomOptions];
    #warning put this back?
    //[weekly changeBackgroundColorTo:weakSelf.view.backgroundColor];
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
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    BOOL areSame = shAreSameBaseRateTypes(rateType,daily.rateType);
    //it is important that this happen before setRateTypeActiveDaysControl:
    //else it will use the old rateType which will have fucky results
    daily.rateType = rateType;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self updateRateTypeControls:rateType shouldChange:!areSame];
    }];
  }];
  
}


-(void)resetRate{
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    daily.rate = 1;
  }];
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
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    NSString *formatText = shGetFormatString(daily.rateType,daily.rate);
    NSString *updatedText = [NSString stringWithFormat:formatText,daily.rate];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.openRateTypeBtn setTitle:updatedText forState:UIControlStateNormal];
    }];
  }];
}


-(void)updateInvertRateTypeButtonText{
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    NSString *buttonText = !shIsInverseRateType(daily.rateType)?defaultInvertBtnText:invertedInvertBtnText;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.invertRateTypeBtn setTitle:buttonText forState:UIControlStateNormal];
    }];
  }];
}


-(void)refreshActiveDaysControl{
  if([self.currentActiveDaysControl isKindOfClass:SHItemFlexibleListView.class]){
    SHItemFlexibleListView *activeDaysList = (SHItemFlexibleListView *)self.currentActiveDaysControl;
    #warning cleanup
//    [activeDaysList resetHeight];
//    [activeDaysList setupInitialHeight];
//    [activeDaysList refreshTable];
//    [self fitControlHeightToSubControlHeight:activeDaysList];
//    [self.resizeResponder refreshView];
    
  }
  else if([self.currentActiveDaysControl isKindOfClass:SHWeeklyActiveDaysViewController.class]){
    [self.context performBlock:^{
      SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
      BOOL isInverse = shIsInverseRateType(daily.rateType);
      
      NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.activeDays.weeklyActiveDays:
        self.activeDays.weeklyActiveDays;
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.weeklyActiveDays setActiveDaysOfWeek:weekInfo];
      }];
    }];
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
    [self.context performBlock:^{
      SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
      BOOL isInverse = shIsInverseRateType(daily.rateType);
      
      NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.activeDays.weeklyActiveDays:
        self.activeDays.weeklyActiveDays;
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.weeklyActiveDays setActiveDaysOfWeek:weekInfo];
      }];
    }];
  }
  else if(rateType == SH_MONTHLY_RATE){
    [self switchActiveDaysControlFor:self.monthlyActiveDays];
    #warning cleanup
//    [self.resizeResponder scrollByOffset:SH_SUB_TABLE_CELL_HEIGHT];
//    [self.resizeResponder scrollVisibleToControl:self];
  }
  else if(rateType == SH_YEARLY_RATE){
    [self switchActiveDaysControlFor:self.yearlyActiveDays];
    [self.resizeResponder scrollByOffset:SH_SUB_TABLE_CELL_HEIGHT];
    [self.resizeResponder scrollVisibleToControl:self];
    
  }
  else if(rateType == SH_DAILY_RATE){
    [self switchActiveDaysControlFor:[[SHViewController alloc] init]];
    self.currentActiveDaysControl = nil;
  }
}


-(void)switchActiveDaysControlFor:(UIViewController<SHNestedControlProtocol> *)activeDaysControl{
  NSAssert(activeDaysControl,@"activeDaysControl was nil");
  [self fitControlHeightToSubControlHeight:activeDaysControl];
  #warning cleanup
//  [self.activeDaysControlContainer
//      replaceSubviewsWith:activeDaysControl];
  self.currentActiveDaysControl = activeDaysControl;
}


-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo{
  [eventInfo.senderStack addObject:self];
  [self.delegate rateStep_valueChanged_action:eventInfo];
  [self updateRateTypeButtonText];
}


-(void)resetHeight{
  #warning clean up
  //[self resizeFrame:self.defaultSize];
  //[self.activeDaysControlContainer resizeFrame:CGRectZero.size];
}


-(void)fitControlHeightToSubControlHeight:(UIViewController *)control{
  (void)control;
  [self resetHeight];
  //CGFloat h = control.frame.size.height;
  [self beginUpdate];
  #warning cleanup
  //[self resizeHeightByOffset:h];
  //[self.activeDaysControlContainer resizeHeightByOffset:h];
  [self endUpdate];
}


-(void)respondToHeightResize:(CGFloat)change{
  #warning clean up
  //[self resizeHeightByOffset:change];
  //[self.activeDaysControlContainer resizeHeightByOffset:change];
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
#warning cleanup
  //[super changeBackgroundColorTo:color];
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


- (IBAction)touchdown_action:(UIButton *)sender forEvent:(UIEvent *)event {
  (void)sender; (void)event;
  [self.editorContainer arrangeAndPushChildVCToFront:self.currentActiveDaysControl];
}


@end
