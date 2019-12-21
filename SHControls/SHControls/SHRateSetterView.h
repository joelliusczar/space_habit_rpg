//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetterDelegateProtocol.h"
#import "SHSwitch.h"
#import "SHView.h"
#import "SHNestedControlProtocol.h"
#import "SHViewController.h"
@import UIKit;


typedef void(^rateStepAction)(UIStepper*,UIEvent *);

IB_DESIGNABLE
@interface SHRateSetterView : SHView
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet UILabel *intervalLabel;
@property (copy,nonatomic) rateStepAction rateStepEvent;
@property (strong,nonatomic) IBInspectable UIColor *controlBackground;
@property (strong,nonatomic) IBInspectable NSString *labelPluralFormatString;
@property (strong,nonatomic) IBInspectable NSString *labelSingularFormatString;
@property (assign,nonatomic) IBInspectable NSInteger intervalSize;
-(void)setSubControlColorsTo:(UIColor *)color;
@end
