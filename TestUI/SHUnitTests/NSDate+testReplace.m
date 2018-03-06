//
//  NSDate+testReplace.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+testReplace.h"
#import <objc/runtime.h>

NSDate *testTodayReplacement = nil;

@implementation NSDate (testReplace)

+(void)swizzleThatShit{
    Method ogMethod = class_getClassMethod(NSDate.class,@selector(date));
    IMP swizzleImp = (IMP)replacementDate;
    method_setImplementation(ogMethod,swizzleImp);
}

static NSDate* replacementDate(){
    //[NSDate date] is non-null so I should be doing a null check in here,
    //but I was curious so I'm leaving it out.
    return testTodayReplacement;
}
@end
