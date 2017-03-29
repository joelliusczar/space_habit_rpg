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
-(nonnull NSDate *)getReferenceDate;
-(BOOL)isSwitchOn:(nonnull id)switchItem;
-(void)setSwitch:(nonnull id)switchItem withValue:(BOOL)value;
-(uint32_t)calculateLvl:(uint32_t)lvl OffsetBy:(uint32_t)offset;
-(nonnull NSDictionary*)getPListDict:(nonnull NSString*)fileName withClassBundle:(nonnull Class)class;
@end
