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
    [instance updateRateType:daily.rateType];
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
    RateTypeSelector *typeSelector = [[RateTypeSelector alloc]
                                      initWithRateType:self.daily.rateType
                                      andDelegate:self];
    [self.resizeResponder pushViewControllerToNearestParent:typeSelector];
}


-(void)updateRateType:(RateType)rateType{
    self.daily.rateType = rateType;
    [self setRateTypeActiveDaysControl:rateType];
}

-(void)setRateTypeActiveDaysControl:(RateType)rateType{
    //TODO: test this for loading saved daily
    if(rateType == WEEKLY_RATE){
        [self switchActiveDaysControlFor:self.weeklyActiveDays];
        self.currentActiveDaysControl = self.weeklyActiveDays;
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
    CGFloat h = activeDaysControl.frame.size.height;
    [self fitControlHeightToSubControlHeight:h];
    [self.activeDaysControlContainer
     replaceSubviewsWith:activeDaysControl];
}


-(void)rateStep_valueChanged_action:(UIStepper *)sender
                           forEvent:(UIEvent *)event{
    [self.delegate rateStep_valueChanged_action:sender forEvent:event];
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
    [self.resizeResponder respondToHeightResize:change];
}


-(void)scrollByOffset:(CGFloat)offset{
    [self.resizeResponder scrollByOffset:offset];
}


-(void)scrollVisibleToControl:(SHView *)control{
    [self.resizeResponder scrollVisibleToControl:self];
}


-(void)pushViewControllerToNearestParent:(UIViewController *)child{
    [self.resizeResponder pushViewControllerToNearestParent:child];
}


-(void)beginUpdate{
    [self.resizeResponder beginUpdate];
}


-(void)endUpdate{
    [self.resizeResponder endUpdate];
}

-(void)changeBackgroundColorTo:(UIColor *)color{
    [super changeBackgroundColorTo:color];
    [self.rateSetter changeBackgroundColorTo:color];
    [self.currentActiveDaysControl changeBackgroundColorTo:color];
}

@end
