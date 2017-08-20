//
//  NSException+SHCommonExceptions.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (SHCommonExceptions)
+(NSException *)abstractException;
+(NSException *)oddException;
+(NSException *)stillUsedException;
@end
