//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateSetterView.h"
#import "SHEventInfo.h"

@interface RateSetterView ()

@end

@implementation RateSetterView


-(void)setRateType:(RateType)rateType{
    _rateType = rateType;
    [self updateRateValue:1];
}


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    
    SHEventInfo *e = eventInfoCopy;
    [self.delegate rateStep_valueChanged_action:e];
    NSInteger rate = (NSInteger)sender.value;
    self.rateLbl.text = [NSString stringWithFormat:[RateSetterView
                                                    getFormatString:self.rateType withRate:rate],rate];
}


+(NSString *)getFormatString:(RateType)rateType withRate:(NSInteger)rate{
    switch(rateType){
        case DAILY_RATE:
            return rate==1?@"Triggers every day":@"Triggers every %d days";
        case WEEKLY_RATE:
            return rate==1?@"Triggers every week":@"Triggers every %d weeks";
        case MONTHLY_RATE:
            return rate==1?@"Triggers every month":@"Triggers every %d months";
        case YEARLY_RATE:
            return rate==1?@"Triggers every year":@"Triggers every %d years";
        case WEEKLY_RATE_INVERSE:
            return rate==1?@"Skips checked days every week":@"Skips checked days every %d weeks";
        case MONTHLY_RATE_INVERSE:
            return rate==1?@"Skips every month":@"Skips every %d months";
        case YEARLY_RATE_INVERSE:
            return rate==1?@"Skips every year":@"Skips every %d years";
    }
}


-(void)updateRateValue:(NSInteger)rate{
    self.rateStep.value = rate;
    self.rateLbl.text = [NSString stringWithFormat:[RateSetterView
                                                    getFormatString:self.rateType withRate:rate],rate];
}


@end
