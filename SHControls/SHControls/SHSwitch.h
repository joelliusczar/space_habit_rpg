//
//  CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSwitchProtocol.h"
#import "SHView.h"
@import UIKit;
@import SHCommon;

IB_DESIGNABLE
@interface SHSwitch : SHView<SHSwitchProtocol,SHColorInversionHintProtocol>
@property (assign,nonatomic) IBInspectable BOOL isOn;
@property (strong,nonatomic) IBInspectable UIImage *onImage;
@property (strong,nonatomic) IBInspectable UIImage *offImage;
@property (strong,nonatomic) UIImage *onImageColorInverted;
@property (strong,nonatomic) UIImage *offImageColorInverted;
@property (strong,nonatomic) IBOutlet UIImageView *currentImageHolder;
@property (readonly,nonatomic) UIImage *currentOnImage;
@property (readonly,nonatomic) UIImage *currentOffImage;
-(void)refreshImage;
@end
