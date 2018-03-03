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


+(NSException *)oddException{
    return [NSException
            exceptionWithName:@"odd event exception"
            reason:@"Something really weird was about to happen"
            userInfo:nil];
}


+(NSException *)stillUsedException{
    return [NSException
            exceptionWithName:@"Still used exception"
            reason:@"yep, this is still used"
            userInfo:nil];
}

@end
