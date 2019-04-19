//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHRateSetterDelegateProtocol.h"
#import "SHSwitch.h"
#import "SHView.h"
#import <SHGlobal/SHConstants.h>

IB_DESIGNABLE
@interface SHRateSetterView : SHView
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet id<SHRateSetterDelegateProtocol> delegate;
@end
