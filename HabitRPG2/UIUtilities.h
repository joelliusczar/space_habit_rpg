//
//  UIUtilities.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/27/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CustomSwitch.h"
@import CoreGraphics;

@interface UIUtilities : NSObject
    +(CGFloat)GetYStart: (CGFloat)height;
    +(CGFloat)GetYStartUnderLabel: (CGFloat)height;
    +(BOOL)isSwitchOn:(nonnull id<P_CustomSwitch>)switchItem;
    +(void)setSwitch:(nonnull id<P_CustomSwitch>)switchItem withValue:(BOOL)value;
@end
