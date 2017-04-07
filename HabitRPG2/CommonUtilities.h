//
//  CommonUtilities.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "P_CustomSwitch.h"
@import CoreGraphics;


@interface CommonUtilities : NSObject
    +(nonnull NSDate *)getReferenceDate;
    +(uint32_t)calculateLvl:(uint32_t)lvl OffsetBy:(uint32_t)offset;
    +(uint32_t)randomUInt:(uint32_t)offset;
    +(CGFloat)GetYStart: (CGFloat)height;
    +(CGFloat)GetYStartUnderLabel: (CGFloat)height;
    +(BOOL)isSwitchOn:(nonnull id<P_CustomSwitch>)switchItem;
    +(void)setSwitch:(nonnull id<P_CustomSwitch>)switchItem withValue:(BOOL)value;
@end
