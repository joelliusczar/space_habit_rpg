//
//	UIColor+Helper.h
//	SHCommon
//
//	Created by Joel Pridgen on 3/5/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//
#import <TargetConditionals.h>

#warning anything?

#ifndef DYNAMIC_TARGETS_ENABLED
#warning DYNAMIC_TARGETS_ENABLED
#endif

#if defined(__APPLE_CC__)
#warning defined(__APPLE_CC__)
#endif

#if defined(__GNUC__)
#warning defined(__GNUC__)
#endif

#if TARGET_OS_IOS
#warning TARGET_OS_IOS
#endif


#if TARGET_OS_MACCATALYST
#warning TARGET_OS_MACCATALYST
#endif

#if TARGET_OS_MACCATALYST || TARGET_OS_IOS

@import UIKit;

@interface UIColor (Helper)
-(UIColor *)invertColor;
@end

#endif
