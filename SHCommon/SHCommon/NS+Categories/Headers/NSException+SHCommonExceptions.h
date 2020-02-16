//
//	NSException+SHCommonExceptions.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface NSException (SHCommonExceptions)
+(NSException*)abstractException;
+(NSException*)oddException;
+(NSException*)stillUsedException;
+(NSException*)dbException:(NSError *)error;
+(NSException*)inproperlySetupObject:(NSString*)message;
@end