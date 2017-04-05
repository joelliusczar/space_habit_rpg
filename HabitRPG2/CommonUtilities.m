//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CommonUtilities.h"
#import "SingletonCluster.h"


@implementation CommonUtilities

    +(NSDate *)getReferenceDate{
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

    +(uint32_t)calculateLvl:(uint32_t)lvl OffsetBy:(uint32_t)offset{
        uint32_t minLvl = lvl;
        if(lvl <= offset){
            minLvl = offset;
        }
        else{
            minLvl = lvl - offset;
        }
        
        return [[SingletonCluster getSharedInstance].stdLibWrapper randomUInt:offset] +minLvl;
    }

@end
