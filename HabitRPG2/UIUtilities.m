//
//  UIUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/27/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "UIUtilities.h"

@implementation UIUtilities
    
    +(CGFloat)GetYStart: (CGFloat)height{
        return height *.25;
    }

    +(CGFloat)GetYStartUnderLabel: (CGFloat)height{
        return height *.10;
    }
    
    +(BOOL)isSwitchOn:(id<P_CustomSwitch>)switchItem{
        return switchItem.isOn;
    }
    
    +(void)setSwitch:(id<P_CustomSwitch>)switchItem withValue:(BOOL)value{
        switchItem.isOn = value;
    }
    
@end
