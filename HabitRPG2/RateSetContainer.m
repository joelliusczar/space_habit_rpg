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
    }
    return _weeklyActiveDays;
}


-(MonthlyActiveDays *)monthlyActiveDays{
    if(nil==_monthlyActiveDays){
        _monthlyActiveDays = [MonthlyActiveDays
                              newWithDaily:self.daily
                              andBackViewController:self.backViewController];
        _monthlyActiveDays.utilityStore = self.utilityStore;
        _monthlyActiveDays.holderView = self;
    }
    return _monthlyActiveDays;
}


-(YearlyActiveDays *)yearlyActiveDays{
    if(nil == _yearlyActiveDays){
        _yearlyActiveDays = [YearlyActiveDays
                             newWithDaily:self.daily
                             andBackViewController:self.backViewController];
        _yearlyActiveDays.utilityStore = self.utilityStore;
        _yearlyActiveDays.holderView = self;
    }
    return _yearlyActiveDays;
}


+(instancetype)newWithDaily:(Daily * _Nonnull)daily
            andBackViewController:(EditNavigationController * _Nonnull)backViewController{
    NSAssert(daily,@"daily was nil");
    NSAssert(backViewController,@"backViewController was nil");
    
    RateSetContainer *instance = [[RateSetContainer alloc] init];
    instance.daily = daily;
    instance.backViewController = backViewController;
    instance.defaultSize = instance.frame.size;
    [instance updateRateType:daily.rateType];
    return instance;
}

-(IBAction)setRateTypeBtn_click_action:(UIButton *)sender
                              ForEvent:(UIEvent *)event{
    RateTypeSelector *typeSelector = [[RateTypeSelector alloc]
                                      initWithRateType:self.daily.rateType
                                      andDelegate:self];
    [ViewHelper pushViewToFront:typeSelector OfParent:self.backViewController];
}


-(void)updateRateType:(RateType)rateType{
    self.daily.rateType = rateType;
    [self setRateTypeActiveDaysControl:rateType];
}

-(void)setRateTypeActiveDaysControl:(RateType)rateType{
    //TODO: test this for loading saved daily
    if(rateType == WEEKLY_RATE){
        [self switchActiveDaysControlFor:self.weeklyActiveDays];
    }
    else if(rateType == MONTHLY_RATE){
        [self switchActiveDaysControlFor:self.monthlyActiveDays];
    }
    else if(rateType == YEARLY_RATE){
        [self switchActiveDaysControlFor:self.yearlyActiveDays];
    }
    else if(rateType == DAILY_RATE){
        [self switchActiveDaysControlFor:[[SHView alloc] initEmpty]];
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
    if(self.delegate){
        [self.delegate rateStep_valueChanged_action:sender forEvent:event];
    }
}


-(void)resetHeight{
    [self resizeFrame:self.defaultSize];
    [self.activeDaysControlContainer resizeFrame:CGRectZero.size];
}


-(void)fitControlHeightToSubControlHeight:(CGFloat)h{
    [self resetHeight];
    // max height for the tables? This should be controlled inside the
    //table itself I think
    [self.backViewController.editingScreen.controlsTbl beginUpdates];
    [self resizeHeightByOffset:h];
    [self.activeDaysControlContainer resizeHeightByOffset:h];
    [self.backViewController.editingScreen.controlsTbl endUpdates];
}

@end
