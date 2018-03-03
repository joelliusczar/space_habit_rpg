//
//  CommonUtilities.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import CoreGraphics;

/* 
Hash combining method from 
http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
*/
#define NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define NSUINT_Rotate(val,howmuch) \
 ( ((NSUInteger)val) << howmuch | ((NSUInteger)val) >> (NSUINT_BIT - howmuch) )


@interface CommonUtilities : NSObject
NSDate* _Nonnull getReferenceDate(void);
uint calculateLvl(uint lvl,uint range);
uint randomUInt(uint bound);
CGFloat GetYStart(CGFloat height);
CGFloat GetYStartUnderLabel(CGFloat height);
void reverse_UINT(NSUInteger * _Nonnull array,NSUInteger len);
+(UIColor *_Nonnull)invertColor:(UIColor *_Nonnull)color;
+(void)invertViewColors:(UIView *_Nonnull)view;
+(void)applyVisualChangeToAllSubviews:(UIView *_Nonnull)view;
+(void)invertTitleColorForAllStates:(UIView *_Nonnull)view;
+(void)invertTitleShadowColorForAllStates:(UIView *_Nonnull)view;
+(UIImage *_Nonnull)invertImageColors:(UIImage *_Nonnull)img;
+(void)checkForAndApplyVisualChanges:(UIView *_Nonnull)view;
+(NSString *_Nonnull)dictToString:(NSDictionary *_Nonnull)dict;
+(NSMutableDictionary *_Nonnull)jsonStringToDict:(NSString *_Nonnull)jsonStr;
@end
