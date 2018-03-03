//
//  RateTypeSelector.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateTypeSelector.h"
#import <SHCommon/Interceptor.h>
#import <SHCommon/ViewHelper.h>
#import <SHCommon/UIView+Helpers.h>
#import "SHEventInfo.h"

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


-(void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(background_tap_action:)];
    [self.backgroundView addGestureRecognizer:tapGestureBG];
    [self formatView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)formatView{
    [self setupBorder:self.everyXBtn];
    [self setupBorder:self.weeklyBtn];
    [self setupBorder:self.monthlyBtn];
    [self setupBorder:self.yearlyBtn];
    [self setupBorder:self.view];
    [self setCheckmark:self.rateType];
}


-(void)setupBorder:(UIView *)view{
    NSAssert(view,@"button was nil");
    [view setupBorder:UIRectEdgeTop|UIRectEdgeBottom
        withThickness:1.0f
             andColor:[UIColor lightGrayColor]];
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
            popVCFromFront(self);
        }
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(IBAction)rateType_click_action:(UIView *)sender forEvent:(UIEvent *)event{
    RateType rateType = self.rateType;
    if(self.delegate){
        if(sender == self.yearlyBtn){
            rateType = YEARLY_RATE;
        }
        else if(sender == self.monthlyBtn){
            rateType = MONTHLY_RATE;
        }
        else if(sender == self.weeklyBtn){
            rateType = WEEKLY_RATE;
        }
        else{
            rateType = DAILY_RATE;
        }
        SHEventInfo *e = eventInfoCopy;
        [self.delegate updateRateType: rateType with:e];
    }
    [self setCheckmark:rateType];
    //I want to display some sort of visible change in response to
    //the user action before the view goes away
    long arbitraryDispatchTime = 100000;
    dispatch_after(dispatch_walltime(nil,arbitraryDispatchTime),dispatch_get_main_queue(),^(){
        popVCFromFront(self);
    });
}




@end
