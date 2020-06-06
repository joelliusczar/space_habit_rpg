//
//  rateSetterViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
@import UIKit;


typedef void(^rateStepAction)(UIStepper*,UIEvent *);

IB_DESIGNABLE
@interface SHRateSetterView : SHViewController
@property (weak, nonatomic) IBOutlet UIStepper *rateStep;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (copy, nonatomic) rateStepAction rateStepEvent;
@property (strong, nonatomic) IBInspectable UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (copy, nonatomic) NSString* (^buildDescription)(int32_t, void *);
@property (assign, nonatomic) void* descriptionArgs;
@property (assign, nonatomic) void (*descriptionArgsCleanup)(void*);
@property (assign, nonatomic) IBInspectable NSInteger intervalSize;
-(void)redrawButtons;
@end
