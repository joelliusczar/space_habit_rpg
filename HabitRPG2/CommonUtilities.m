//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CommonUtilities.h"

@implementation CommonUtilities
-(BOOL)isSwitchOn:(id)switchItem{
    UISwitch *switchBtn = (UISwitch *)switchItem;
    return switchBtn.isOn;
}

-(void)setSwitch:(id)switchItem withValue:(BOOL)value{
    UISwitch *switchBtn = (UISwitch *)switchItem;
    switchBtn.on = value;
}
@end
