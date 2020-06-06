//
//  CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSwitchProtocol.h"
#import "SHViewController.h"
@import UIKit;
@import SHCommon;

IB_DESIGNABLE
@interface SHSwitch : SHViewController<SHSwitchProtocol, SHColorInversionHintProtocol>
@property (assign,nonatomic) IBInspectable BOOL isOn;
@property (strong,nonatomic) IBInspectable UIImage *onImage UI_APPEARANCE_SELECTOR;
@property (strong,nonatomic) IBInspectable UIImage *offImage UI_APPEARANCE_SELECTOR;
@property (class, readonly, nonatomic) UIImage *defaultOnImage;
@property (class, readonly, nonatomic) UIImage *defaultOffImage;
@property (class, strong, nonatomic) UIColor *defaultBackgroundColor;
@property (strong,nonatomic) UIImage *onImageColorInverted;
@property (strong,nonatomic) UIImage *offImageColorInverted;
@property (weak,nonatomic) IBOutlet UIImageView *currentImageHolder;
@property (readonly,nonatomic) UIImage *currentOnImage;
@property (readonly,nonatomic) UIImage *currentOffImage;
@property (copy, nonatomic) void (^onChange)(BOOL newVal, SHSwitch *sender);
-(void)refreshImage;
@end
