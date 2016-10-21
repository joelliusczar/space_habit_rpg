//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CommonUtilities.h"
#import "CustomSwitch.h"
#import "stdlib.h"

@implementation CommonUtilities

+(NSInteger)calculateLvl:(NSUInteger)lvl OffsetBy:(NSUInteger)offset{
    NSUInteger minLvl = lvl;
    if(lvl <= offset){
        minLvl = offset;
    }
    else{
        minLvl = lvl - offset;
    }
    
    return arc4random_uniform(offset) +minLvl;
}

+(BOOL)isSwitchOn:(id)switchItem{
    CustomSwitch *switchBtn = (CustomSwitch *)switchItem;
    return switchBtn.isOn;
}

+(void)setSwitch:(id)switchItem withValue:(BOOL)value{
    CustomSwitch *switchBtn = (CustomSwitch *)switchItem;
    switchBtn.isOn = value;
}
@end
