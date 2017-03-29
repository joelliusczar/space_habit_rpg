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

-(NSDate *)getReferenceDate{
    NSCalendar *cal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 2016;
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    
    return [cal dateFromComponents:dateComponents];
}

-(uint32_t)calculateLvl:(uint32_t)lvl OffsetBy:(uint32_t)offset{
    uint32_t minLvl = lvl;
    if(lvl <= offset){
        minLvl = offset;
    }
    else{
        minLvl = lvl - offset;
    }
    
    return arc4random_uniform(offset) +minLvl;
}

-(BOOL)isSwitchOn:(id)switchItem{
    CustomSwitch *switchBtn = (CustomSwitch *)switchItem;
    return switchBtn.isOn;
}

-(void)setSwitch:(id)switchItem withValue:(BOOL)value{
    CustomSwitch *switchBtn = (CustomSwitch *)switchItem;
    switchBtn.isOn = value;
}

-(NSDictionary*)getPListDict:(NSString*)fileName withClassBundle:(nonnull Class)class{
    NSString *filePath = [[NSBundle bundleForClass:class] pathForResource:fileName ofType:@"plist"];
    NSAssert(filePath,@"file path for plist was null or empty");
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}
@end
