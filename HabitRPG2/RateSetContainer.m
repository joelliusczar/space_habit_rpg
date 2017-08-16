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

@end

@implementation RateSetContainer


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}


-(MonthlyActiveDays *)monthlyActiveDays{
    if(nil==_monthlyActiveDays){
        _monthlyActiveDays = [MonthlyActiveDays
                              newWithDaily:self.daily
                              andBackViewController:self.backViewController];
        _monthlyActiveDays.utilityStore = self.utilityStore;
    }
    return _monthlyActiveDays;
}

+(instancetype)newWithDaily:(Daily * _Nonnull)daily
            andBackViewController:(EditNavigationController * _Nonnull)backViewController{
    NSAssert(daily,@"daily was nil");
    NSAssert(backViewController,@"backViewController was nil");
    
    RateSetContainer *instance = [[RateSetContainer alloc] init];
    instance.daily = daily;
    instance.backViewController = backViewController;
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
    if(rateType == MONTHLY_RATE){
        [self.activeDaysControlContainer
         replaceSubviewsWith:self.monthlyActiveDays];
    }
}


-(void)rateStep_valueChanged_action:(UIStepper *)sender
                           forEvent:(UIEvent *)event{
    if(self.delegate){
        [self.delegate rateStep_valueChanged_action:sender forEvent:event];
    }
}

@end
