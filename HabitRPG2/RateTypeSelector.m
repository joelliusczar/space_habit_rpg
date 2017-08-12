//
//  RateTypeSelector.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateTypeSelector.h"
#import "Interceptor.h"
#import "ViewHelper.h"

@interface RateTypeSelector ()

@end

@implementation RateTypeSelector

-(instancetype)initWithRateType:(RateType)rateType
                    andDelegate:(id<P_RateTypeSelectorDelegate>)delegate{
    if(self = [super initWithNibName:NSStringFromClass(self.class)
                              bundle:[NSBundle bundleForClass:self.class]]){
        _rateType = rateType;
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(background_tap_action:)];
    [self.backgroundView addGestureRecognizer:tapGestureBG];
    [self formatButton:self.everyXBtn];
    [self formatButton:self.weeklyBtn];
    [self formatButton:self.monthlyBtn];
    [self formatButton:self.yearlyBtn];
    [self setCheckmark:self.rateType];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)formatButton:(UIButton *)button{
    NSAssert(button,@"button was nil");
    CALayer *btnLayer = button.layer;
    btnLayer.borderWidth = 2.0f;
    btnLayer.borderColor = [UIColor darkGrayColor].CGColor;
    btnLayer.masksToBounds = YES;
    btnLayer.cornerRadius = .5f;
}


-(void)setCheckmark:(RateType)rateType{
    self.everyXCheckLbl.hidden = rateType!=DAILY_RATE;
    self.weeklyCheckLbl.hidden = rateType!=WEEKLY_RATE;
    self.monthlyCheckLbl.hidden = rateType!=MONTHLY_RATE;
    self.yearlyCheckLbl.hidden = rateType!=YEARLY_RATE;
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
        RateType rateType = self.rateType;
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
    [ViewHelper popViewFromFront:self];
}




@end
