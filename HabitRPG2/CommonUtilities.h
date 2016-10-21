//
//  CommonUtilities.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtilities : NSObject
+(BOOL)isSwitchOn:(id)switchItem;
+(void)setSwitch:(id)switchItem withValue:(BOOL)value;
+(NSInteger)calculateLvl:(NSUInteger)lvl OffsetBy:(NSUInteger)offset;
@end
