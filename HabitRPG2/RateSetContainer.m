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

@interface RateSetContainer ()

@end

@implementation RateSetContainer

+(instancetype)newWithDaily:(Daily * _Nonnull)daily
            andBackViewController:(EditNavigationController * _Nonnull)backViewController
                     andTimeStore:(id<P_TimeUtilityStore> _Nonnull)timeStore{
    NSAssert(daily,@"daily was nil");
    NSAssert(backViewController,@"backViewController was nil");
    NSAssert(timeStore,@"timeStore was nil");
    
    RateSetContainer *instance = [[RateSetContainer alloc] init];
    instance.timeStore = timeStore;
    instance.daily = daily;
    instance.backViewController = backViewController;
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
}

@end
