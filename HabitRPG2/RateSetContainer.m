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
    if(nil==_weeklyActiveDays){
        _weeklyActiveDays = [[WeeklyActiveDays alloc] init];
        [_weeklyActiveDays changeBackgroundColorTo:self.backgroundColor];
        _weeklyActiveDays.delegate = self.weeklyDaysDelegate;
    }
    return _weeklyActiveDays;
}


-(MonthlyActiveDays *)monthlyActiveDays{
    if(nil==_monthlyActiveDays){
        _monthlyActiveDays = [MonthlyActiveDays
                              newWithDaily:self.daily];
        [self commonTableSetup: _monthlyActiveDays];
    }
    return _monthlyActiveDays;
}


-(YearlyActiveDays *)yearlyActiveDays{
    if(nil == _yearlyActiveDays){
        _yearlyActiveDays = [YearlyActiveDays
                             newWithDaily:self.daily];
        [self commonTableSetup:_yearlyActiveDays];
    }
    return _yearlyActiveDays;
}


+(instancetype)newWithDaily:(Daily * _Nonnull)daily{
    NSAssert(daily,@"daily was nil");
    
    RateSetContainer *instance = [[RateSetContainer alloc] init];
    instance.daily = daily;
    instance.defaultSize = instance.frame.size;
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

-(IBAction)setRateTypeBtn_click_action:(UIButton *)sender
                              ForEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        RateTypeSelector *typeSelector = [[RateTypeSelector alloc]
                                          initWithRateType:self.daily.rateType
                                          andDelegate:self];
        [self.resizeResponder pushViewControllerToNearestParent:typeSelector];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)updateRateType:(RateType)rateType with:(SHEventInfo *)eventInfo{
    [self updateRateType:rateType];
}


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
        self.currentActiveDaysControl = self.weeklyActiveDays;
        [self.weeklyActiveDays setActiveDaysOfWeek:[self.daily getActiveDaysForRateType:self.daily.rateType][0]];
    }
    else if(rateType == MONTHLY_RATE){
        [self switchActiveDaysControlFor:self.monthlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
        self.currentActiveDaysControl = self.monthlyActiveDays;
    }
    else if(rateType == YEARLY_RATE){
        [self switchActiveDaysControlFor:self.yearlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
        self.currentActiveDaysControl = self.yearlyActiveDays;
        
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


-(void)scrollVisibleToControl:(SHView *)control{
    SEL delegateSel = @selector(scrollVisibleToControl:);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder scrollVisibleToControl:self];
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


-(IBAction)invertRateTypeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        [self updateRateType:invertRateType(self.daily.rateType)];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
