//
//  CommonUtilitiesMock.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CommonUtilitiesMock.h"

@implementation CommonUtilitiesMock

+(BOOL)isSwitchOn:(id)switchItem{
    NSMutableString *boolish = (NSMutableString *)switchItem;
    
    bool result = [boolish isEqual:@"YES"];
    return result;
}

+(void)setSwitch:(id)switchItem withValue:(BOOL)value{
    NSMutableString *boolish = (NSMutableString *)switchItem;
    [boolish setString:[NSString stringWithFormat:@"%s",value?"YES":"NO"]];
}

@end
