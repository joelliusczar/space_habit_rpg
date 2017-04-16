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

    +(uint32_t)calculateLvl:(uint32_t)lvl OffsetBy:(uint32_t)range{
        lvl = lvl?lvl:1;
        uint32_t minLvl = 0;
        if(lvl <= range){
            minLvl = 1;
            range += lvl;
        }
        else{
            minLvl = lvl - range;
            range = (2*range)+1;
        }
        
        return [CommonUtilities randomUInt:range] +minLvl;
    }
    
    +(uint32_t)randomUInt:(uint32_t)offset{
        return [[SingletonCluster getSharedInstance].stdLibWrapper randomUInt:offset];
    }
    
    +(CGFloat)GetYStart: (CGFloat)height{
        return height *.25;
    }
    
    +(CGFloat)GetYStartUnderLabel: (CGFloat)height{
        return height *.10;
    }
    

@end
