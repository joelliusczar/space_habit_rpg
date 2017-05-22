//
//  CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_CustomSwitch.h"

IB_DESIGNABLE
@interface CustomSwitch : UIButton<P_CustomSwitch>
@property (nonatomic,assign) IBInspectable BOOL isOn;
@property (nonatomic,strong) IBInspectable UIImage *onImage;
@property (nonatomic,strong) IBInspectable UIImage *offImage;
@property (nonatomic,strong) UIImage *onImageColorInverted;
@property (nonatomic,strong) UIImage *offImageColorInverted;
@property (nonatomic,readonly) UIImage *currentOnImage;
@property (nonatomic,readonly) UIImage *currentOffImage;
@property (nonatomic,assign) BOOL areColorsInverted;
-(void)refreshImage;
@end
