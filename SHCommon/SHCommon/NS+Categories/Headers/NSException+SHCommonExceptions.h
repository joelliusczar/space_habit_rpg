//
//	NSException+SHCommonExceptions.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import SHUtils_C;
//#import <SHUtils_C/SHErrorHandling.h>

@interface NSException (SHCommonExceptions)
+(NSException*)abstractException;
+(NSException*)oddException;
+(NSException*)oddException:(NSString*)message;
+(NSException*)stillUsedException;
+(NSException*)dbException:(NSError *)error;
+(NSException*)inproperlySetupObject:(NSString*)message;
+(NSException*)encounterError;
+(NSException*)encounterSHError:(SHError*)error;
+(NSException*)encounterNSError:(NSError*)error;
@end
