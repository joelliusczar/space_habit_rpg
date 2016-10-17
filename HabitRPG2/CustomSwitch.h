//
//  CustomSwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomSwitch : UIButton
@property (nonatomic,assign) IBInspectable BOOL isOn;
@property (nonatomic,strong) IBInspectable UIImage* onImage;
@property (nonatomic,strong) IBInspectable UIImage* offImage;
@end
