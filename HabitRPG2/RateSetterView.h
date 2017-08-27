//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_RateSetterDelegate.h"
#import "CustomSwitch.h"
#import "SHView.h"
#import "constants.h"

IB_DESIGNABLE
@interface RateSetterView : SHView
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet UILabel *rateLbl;
@property (weak,nonatomic) IBOutlet id<P_RateSetterDelegate> delegate;
@property (assign,nonatomic) RateType rateType;
-(void)updateRateValue:(NSInteger)rate;
@end
