//
//  CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_SHSwitch.h"
#import "SHButton.h"
#import <SHCommon/P_ColorInversionHint.h>

IB_DESIGNABLE
@interface SHSwitch : SHButton<P_SHSwitch,P_ColorInversionHint>
@property (assign,nonatomic) IBInspectable BOOL isOn;
@property (strong,nonatomic) IBInspectable UIImage *onImage;
@property (strong,nonatomic) IBInspectable UIImage *offImage;
@property (strong,nonatomic) UIImage *onImageColorInverted;
@property (strong,nonatomic) UIImage *offImageColorInverted;
@property (readonly,nonatomic) UIImage *currentOnImage;
@property (readonly,nonatomic) UIImage *currentOffImage;
-(void)refreshImage;
@end
