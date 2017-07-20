//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_RateSetterDelegate.h"
#import "P_EditScreenControl.h"
#import "ControlController.h"

@interface RateSetterView : ControlController <P_EditScreenControl>
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet UILabel *rateLbl;
@property (weak,nonatomic) id<P_RateSetterDelegate> delegate;
@end