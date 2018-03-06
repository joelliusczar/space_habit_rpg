//
//  NSDate+testReplace.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NSDate* (*getNow)();
extern NSDate *testTodayReplacement;

@interface NSDate (testReplace)
+(void)swizzleThatShit;
@end
