//
//  RateTypeSelector.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateTypeSelector.h"
#import "constants.h"
#import "Interceptor.h"
#import "ViewHelper.h"

@interface RateTypeSelector ()

@end

@implementation RateTypeSelector

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(background_tap_action:)];
    [self.backgroundView addGestureRecognizer:tapGestureBG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender{
    wrapReturnVoid wrappedCall = ^void(){
        if(sender.view == self.backgroundView){
            [ViewHelper popViewFromFront:self];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(IBAction)rateType_click_action:(UIView *)sender forEvent:(UIEvent *)event{
    if(self.delegate){
        int rateType = DAILY_RATE;
        if(sender == self.yearlyBtn){
            rateType = YEARLY_RATE;
        }
        else if(sender == self.monthlyBtn){
            rateType = MONTHLY_RATE;
        }
        else if(sender == self.weeklyBtn){
            rateType = WEEKLY_RATE;
        }
        [self.delegate updateRateType: rateType];
    }
}




@end
