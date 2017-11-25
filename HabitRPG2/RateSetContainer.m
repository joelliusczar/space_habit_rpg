//
//  RateSetContainerController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateSetContainer.h"
#import "RateTypeSelector.h"
#import "ViewHelper.h"
#import "UIView+Helpers.h"
#import "SingletonCluster.h"
#import "Interceptor.h"
#import "RateTypeHelper.h"
#import "ItemFlexibleListView.h"

NSString * const YEARLY_KEY = @"yearly";
NSString * const MONTHLY_KEY = @"monthly";
NSString * const WEEKLY_KEY = @"weekly";

@interface RateSetContainer ()
@property (assign,nonatomic) CGSize defaultSize;
@property (weak,nonatomic) SHView *currentActiveDaysControl;
@end

@implementation RateSetContainer

NSString* const defaultInvertBtnText = @"Triggers only on...";
NSString* const invertedInvertBtnText = @"Triggers all days except...";


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}


-(WeeklyActiveDays *)weeklyActiveDays{
    return self.rateControls.controlLookup[WEEKLY_KEY];
}


-(MonthlyActiveDays *)monthlyActiveDays{
    return self.rateControls.controlLookup[MONTHLY_KEY];
}


-(YearlyActiveDays *)yearlyActiveDays{
    return self.rateControls.controlLookup[YEARLY_KEY];
}


-(SHControlKeep *)rateControls{
    if(nil == _rateControls){
        _rateControls = [self buildControlKeep:self.daily];
    }
    return _rateControls;
}


-(void)setWeeklyDaysDelegate:(id<P_WeeklyActiveDaysDelegate>)weeklyDaysDelegate{
    _weeklyDaysDelegate = weeklyDaysDelegate;
    self.rateControls.responderLookup[WEEKLY_KEY] = weeklyDaysDelegate;
}


-(void)setTblDelegate:(id<P_ItemFlexibleListDelegate>)tblDelegate{
    _tblDelegate = tblDelegate;
    self.rateControls.responderLookup[@"tbl"] =  tblDelegate;
}

+(instancetype)newWithDaily:(Daily * _Nonnull)daily{
    NSAssert(daily,@"daily was nil");
    
    RateSetContainer *instance = [[RateSetContainer alloc] init];
    instance.daily = daily;
    instance.defaultSize = instance.frame.size;
    instance.rateControls.responderLookup[takeKey(setDelegate:)] = instance;
    instance.rateControls.responderLookup[takeKey(setResizeResponder:)] = instance;
    [instance updateRateTypeControls:daily.rateType shouldChange:YES];
    [instance updateRateTypeButtonText];
    [instance updateInvertRateTypeButtonText];
    return instance;
}

-(void)commonTableSetup:(ItemFlexibleListView *)tbl{
    tbl.utilityStore = self.utilityStore;
    tbl.holderView = self.activeDaysControlContainer;
    tbl.resizeResponder = self;
    tbl.delegate = self.tblDelegate;
    [tbl changeBackgroundColorTo:self.backgroundColor];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(IBAction)setRateTypeBtn_click_action:(UIButton *)sender
                              ForEvent:(UIEvent *)event{
    RateTypeSelector *typeSelector = [[RateTypeSelector alloc]
                                      initWithRateType:self.daily.rateType
                                      andDelegate:self];
    [self.resizeResponder pushViewControllerToNearestParent:typeSelector];
}


-(void)updateRateType:(RateType)rateType with:(SHEventInfo *)eventInfo{
    [self updateRateType:rateType];
}


-(IBAction)invertRateTypeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    [self updateRateType:invertRateType(self.daily.rateType)];
}


-(void)scrollVisibleToControl:(SHView *)control{
    SEL delegateSel = @selector(scrollVisibleToControl:);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder scrollVisibleToControl:self];
    }
}


-(SHControlKeep *)buildControlKeep:(Daily *)daily{
    NSAssert(daily,@"Daily should not be nil");
    SHControlKeep *keep = [[SHControlKeep alloc] init];
    
    RateSetContainer * __weak weakSelf = self;
    NSString *errMessage = @"RateSetContainer got itself into an inconsistent state";
    
    
    keep.controlLookup[MONTHLY_KEY] = vw(^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NSAssert(weakSelf,errMessage);
        MonthlyActiveDays *monthly = [MonthlyActiveDays newWithDaily:daily];
        [weakSelf commonTableSetup:monthly];
        [keep forResponderKey:@"resize" doSetupAction:^(id responder){
            monthly.resizeResponder = responder;
        }];
        [keep forResponderKey:@"tbl" doSetupAction:^(id responder){
            monthly.delegate = responder;
        }];
        return monthly;
    });
    
    keep.controlLookup[YEARLY_KEY] =  vw(^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NSAssert(weakSelf,errMessage);
        YearlyActiveDays *yearly = [YearlyActiveDays newWithDaily:daily];
        [weakSelf commonTableSetup: yearly];
        [keep forResponderKey:@"resize" doSetupAction:^(id responder){
            yearly.resizeResponder = responder;
        }];
        [keep forResponderKey:@"tbl" doSetupAction:^(id responder){
            yearly.delegate = responder;
        }];
        return yearly;
    });
    keep.controlLookup[WEEKLY_KEY] = vw(^id(SHControlKeep *keep,ControlExtent *controlExtent){
        NSAssert(weakSelf,errMessage);
        WeeklyActiveDays *weekly = [[WeeklyActiveDays alloc] init];
        [weekly changeBackgroundColorTo:weakSelf.backgroundColor];
        [keep forResponderKey:WEEKLY_KEY doSetupAction:^(id responder){
            weekly.delegate = responder;
        }];
        return weekly;
    });
    
    return keep;
}

#pragma clang diagnostic pop





-(void)updateRateType:(RateType)rateType{
    [self resetRate];
    BOOL areSame = areSameBaseRateTypes(rateType,self.daily.rateType);
    //it is important that this happen before setRateTypeActiveDaysControl:
    //else it will use the old rateType which will have fucky results
    [self.daily rateType_w:rateType];
    [self updateRateTypeControls:rateType shouldChange:!areSame];
}


-(void)resetRate{
    [self.daily rate_w:1];
    self.rateSetter.rateStep.value = 1;//prevent old stepper value from overwriting
}


-(void)updateRateTypeControls:(RateType)rateType shouldChange:(BOOL)shouldChange{
    
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
    NSString *formatText = getFormatString(self.daily.rateType,self.daily.rate);
    NSString *updatedText = [NSString stringWithFormat:formatText,self.daily.rate ];
    [self.openRateTypeBtn setTitle:updatedText forState:UIControlStateNormal];
}


-(void)updateInvertRateTypeButtonText{
    NSString *buttonText = !self.daily.isInverseRateType?defaultInvertBtnText:invertedInvertBtnText;
    [self.invertRateTypeBtn setTitle:buttonText forState:UIControlStateNormal];
}


-(void)refreshActiveDaysControl{
    if([self.currentActiveDaysControl isKindOfClass:ItemFlexibleListView.class]){
        ItemFlexibleListView *activeDaysList = (ItemFlexibleListView *)self.currentActiveDaysControl;
        [activeDaysList resetHeight];
        [activeDaysList setupInitialHeight];
        [activeDaysList refreshTable];
        [self fitControlHeightToSubControlHeight:activeDaysList];
        [self.resizeResponder refreshView];
        
    }
    else if([self.currentActiveDaysControl isKindOfClass:WeeklyActiveDays.class]){
        [self.weeklyActiveDays setActiveDaysOfWeek:
                                [self.daily getActiveDaysForRateType:self.daily.rateType][0]];
    }
}

/*
 rate type should be set on daily already
*/
-(void)setRateTypeActiveDaysControl:(RateType)rateType{
    rateType = extractBaseRateType(rateType);
    [self updateRateTypeButtonText];
    if(rateType == WEEKLY_RATE){
        [self switchActiveDaysControlFor:self.weeklyActiveDays];
        [self.weeklyActiveDays setActiveDaysOfWeek:[self.daily getActiveDaysForRateType:self.daily.rateType][0]];
    }
    else if(rateType == MONTHLY_RATE){
        [self switchActiveDaysControlFor:self.monthlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
    }
    else if(rateType == YEARLY_RATE){
        [self switchActiveDaysControlFor:self.yearlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
        
    }
    else if(rateType == DAILY_RATE){
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
