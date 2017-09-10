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
    [instance updateRateType:daily.rateType shouldForceLoad:YES];
    [instance updateRateTypeButtonText];
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
    [self updateRateType:rateType shouldForceLoad:NO];
}


-(void)updateRateType:(RateType)rateType shouldForceLoad:(BOOL)shouldForceLoad{
    
    if(rateType != self.daily.rateType){
        //no need to update if they are the same.
        //Besides, it causes the Save btn to become
        //inconviently enabled sometimes
        [self.daily rate_w:1];
    }
    self.rateSetter.rateStep.value = 1; //prevent old stepper value from overwriting
    BOOL areSame = areSameBaseRateTypes(rateType,self.daily.rateType);
    //it is important that this happen before setRateTypeActiveDaysControl:
    //else it will use the old rateType which will have fucky results
    self.daily.rateType = rateType;
    if(shouldForceLoad||!areSame){
        [self setRateTypeActiveDaysControl:rateType];
    }
    else{
        [self refreshActiveDaysControl];
    }
    [self updateRateTypeButtonText];
}


-(void)updateRateTypeButtonText{
    NSString *formatText = getFormatString(self.daily.rateType,self.daily.rate);
    NSString *updatedText = [NSString stringWithFormat:formatText,self.daily.rate ];
    [self.openRateTypeBtn setTitle:updatedText forState:UIControlStateNormal];
}


-(void)refreshActiveDaysControl{
    if([self.currentActiveDaysControl isKindOfClass:ItemFlexibleListView.class]){
        [((ItemFlexibleListView *)self.currentActiveDaysControl) refreshTable];
    }
    else if([self.currentActiveDaysControl isKindOfClass:WeeklyActiveDays.class]){
        [self.weeklyActiveDays setActiveDaysOfWeek:
                                [self.daily getActiveDaysForRateType:self.daily.rateType][0]];
    }
}


-(void)setRateTypeActiveDaysControl:(RateType)rateType{
    //TODO: test this for loading saved daily
    rateType = extractBaseRateType(rateType);
    if(rateType == WEEKLY_RATE){
        [self switchActiveDaysControlFor:self.weeklyActiveDays];
        self.currentActiveDaysControl = self.weeklyActiveDays;
        [self.openRateTypeBtn setTitle:@"Triggers Every Week" forState:UIControlStateNormal];
        [self.weeklyActiveDays setActiveDaysOfWeek:[self.daily getActiveDaysForRateType:self.daily.rateType][0]];
    }
    else if(rateType == MONTHLY_RATE){
        [self switchActiveDaysControlFor:self.monthlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
        self.currentActiveDaysControl = self.monthlyActiveDays;
        [self.openRateTypeBtn setTitle:@"Triggers Every Month" forState:UIControlStateNormal];
    }
    else if(rateType == YEARLY_RATE){
        [self switchActiveDaysControlFor:self.yearlyActiveDays];
        [self.resizeResponder scrollByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.resizeResponder scrollVisibleToControl:self];
        self.currentActiveDaysControl = self.yearlyActiveDays;
        [self.openRateTypeBtn setTitle:@"Triggers Every Year" forState:UIControlStateNormal];
        
    }
    else if(rateType == DAILY_RATE){
        [self switchActiveDaysControlFor:[[SHView alloc] initEmpty]];
        self.currentActiveDaysControl = nil;
        [self.openRateTypeBtn setTitle:@"Triggers Every Day" forState:UIControlStateNormal];
    }
}


-(void)switchActiveDaysControlFor:(SHView *)activeDaysControl{
    NSAssert(activeDaysControl,@"activeDaysControl was nil");
    CGFloat h = activeDaysControl.frame.size.height;
    [self fitControlHeightToSubControlHeight:h];
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


-(void)fitControlHeightToSubControlHeight:(CGFloat)h{
    [self resetHeight];
    // max height for the tables? This should be controlled inside the
    //table itself I think
    [self beginUpdate];
    [self resizeHeightByOffset:h];
    [self.activeDaysControlContainer resizeHeightByOffset:h];
    [self endUpdate];
}


-(void)respondToHeightResize:(CGFloat)change{
    [self resizeHeightByOffset:change];
    [self.activeDaysControlContainer resizeHeightByOffset:change];
    [self respondToHeightResize_m:change];
}


-(void)respondToHeightResize_m:(CGFloat)change{
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
    if([self.resizeResponder respondsToSelector:@selector(hideKeyboard)]){
        [self.resizeResponder hideKeyboard];
    }
}


-(IBAction)invertRateTypeBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^(){
        self.daily.rateType = invertRateType(self.daily.rateType);
        NSString *btnText = !isInverseRateType(self.daily.rateType)
                            ?@"Triggers all days except...":@"Triggers only on...";
        [self.invertRateTypeBtn setTitle:btnText forState:UIControlStateNormal];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
