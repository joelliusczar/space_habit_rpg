//
//  CommonUtilities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define isTestingInvert NO

#import "CommonUtilities.h"
#import "SingletonCluster.h"
#import <CoreImage/CoreImage.h>
#import "CustomSwitch.h"


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

+(UIColor *)invertColor:(UIColor *)color{
    if(!color) return nil;
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

+(UIImage *)invertImageColors:(UIImage *)img{
    CIImage *cImg = [CIImage imageWithCGImage:img.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:cImg forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result scale:img.scale orientation:img.imageOrientation];
}

+(void)invertColorForPropertyForStateOnView:(UIView *)view withGetSelector:(SEL)getterSEL AndSetSelector:(SEL)setterSEL{
    UIColor *c;
    UIColor *inverted;
    typedef void (*setPropertyColorForState)(id,SEL,UIColor*,NSUInteger);
    typedef UIColor* (*getPropertyColorForState)(id,SEL,NSUInteger);
    getPropertyColorForState methodInvokeGet = (getPropertyColorForState)[view methodForSelector:getterSEL];
    setPropertyColorForState methodInvokeSet = (setPropertyColorForState)[view methodForSelector:setterSEL];
    //invert normal state
    c = methodInvokeGet(view,getterSEL,UIControlStateNormal);
    inverted = [CommonUtilities invertColor:c];
    methodInvokeSet(view,setterSEL,inverted,UIControlStateNormal);
    int UIControlStateMaxShift = 4;
    for(int i = 0;i<UIControlStateMaxShift;i++){
        NSUInteger controlState = 1 << i;
        c = methodInvokeGet(view,getterSEL,controlState);
        inverted = [CommonUtilities invertColor:c];
        methodInvokeSet(view,setterSEL,inverted,controlState);
    }
}

+(void)invertTitleColorForAllStates:(UIView *)view{
    SEL getterSEL = @selector(titleColorForState:);
    SEL setterSEL = @selector(setTitleColor:forState:);
    [CommonUtilities invertColorForPropertyForStateOnView:view withGetSelector:getterSEL AndSetSelector:setterSEL];
}

+(void)invertTitleShadowColorForAllStates:(UIView *)view{
    SEL getterSEL = @selector(titleShadowColorForState:);
    SEL setterSEL = @selector(setTitleShadowColor:forState:);
    [CommonUtilities invertColorForPropertyForStateOnView:view withGetSelector:getterSEL AndSetSelector:setterSEL];
}

+(void)invertViewColors:(UIView *)view{
    UIColor *c;
    if([view respondsToSelector:@selector(setTextColor:)]
       &&[view respondsToSelector:@selector(textColor)]){
        c = (UIColor *)[view valueForKey:@"textColor"];
        [view setValue:[CommonUtilities invertColor:c] forKey:@"textColor"];
    }
    if([view respondsToSelector:@selector(setTitleColor:forState:)]
       &&[view respondsToSelector:@selector(titleColorForState:)]){
        [CommonUtilities invertTitleColorForAllStates:view];
    }
    if([view respondsToSelector:@selector(setTitleShadowColor:forState:)]
       &&[view respondsToSelector:@selector(titleShadowColorForState:)]){
        [CommonUtilities invertTitleShadowColorForAllStates:view];
    }
    if([view respondsToSelector:@selector(setAreColorsInverted:)]
       &&[view respondsToSelector:@selector(areColorsInverted)]){
        BOOL areInverted = ((NSNumber *)[view valueForKey:@"areColorsInverted"]).boolValue;
        [view setValue:[NSNumber numberWithBool:!areInverted] forKey:@"areColorsInverted"];
    }
    c = view.backgroundColor;
    view.backgroundColor = [CommonUtilities invertColor:c];
}

+(void)applyVisualChangeToAllSubviews:(UIView *)view{
    if(UIAccessibilityIsInvertColorsEnabled()||isTestingInvert){
        [CommonUtilities invertViewColors:view];
    }
    if(!view.subviews.count){
        return;
    }
    
    for(UIView *subView in view.subviews){
        [CommonUtilities applyVisualChangeToAllSubviews:subView];
    }
}

+(void)checkForAndApplyVisualChanges:(UIView *)view{
    if(UIAccessibilityIsInvertColorsEnabled()||isTestingInvert){
        [CommonUtilities applyVisualChangeToAllSubviews:view];
    }
}

+(NSString *_Nonnull)dictToString:(NSDictionary *_Nonnull)dict{
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:dict
                        options:NSJSONWritingPrettyPrinted error:&err];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
