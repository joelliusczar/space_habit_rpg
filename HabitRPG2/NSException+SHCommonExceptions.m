//
//  NSException+SHCommonExceptions.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSException+SHCommonExceptions.h"

@implementation NSException (SHCommonExceptions)


+(NSException *)abstractException{
    return [NSException
            exceptionWithName:@"abstract method exception"
            reason:@"This method needs to be implemented in a subclass"
            userInfo:nil];
}


@end
