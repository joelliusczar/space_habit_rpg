//
//	NSException+SHCommonExceptions.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSException+SHCommonExceptions.h"

@implementation NSException (SHCommonExceptions)


+(NSException*)abstractException{
	return [NSException
		exceptionWithName:@"abstract method exception"
		reason:@"This method needs to be implemented in a subclass"
		userInfo:nil];
}


+(NSException*)oddException{
	return [NSException
		exceptionWithName:@"odd event exception"
		reason:@"Something really weird was about to happen"
		userInfo:nil];
}


+(NSException*)oddException:(NSString*)message {
	return [NSException
	exceptionWithName:@"odd event exception"
	reason:message
	userInfo:nil];
}


+(NSException*)stillUsedException{
	return [NSException
		exceptionWithName:@"Still used exception"
		reason:@"yep, this is still used"
		userInfo:nil];
}


+(NSException*)dbException:(NSError*)error{
	return [NSException
		exceptionWithName:@"CoreData"
		reason:[NSString
			stringWithFormat:@"Error Code: %lu\nDomain:%@\n%@",
			error.code,
			error.domain,
			error.localizedDescription]
		userInfo:error.userInfo];
}


+(NSException*)inproperlySetupObject:(NSString*)message{
		return [NSException
		exceptionWithName:@"inproperlySetupObjectException"
		reason:message
		userInfo:nil];
}


+(NSException*)encounterCError:(SHErrorCode)status {
	return [NSException
	exceptionWithName:[NSString stringWithFormat:@"Encountered error: %d from my of the c functions", status]
	reason:@"Look at the stack trace"
	userInfo:nil];
}



+(NSException*)encounterError {
	return [NSException
	exceptionWithName:@"Encountered a random ass error"
	reason:@"Look at the stack trace"
	userInfo:nil];
}


+(NSException*)encounterNSError:(NSError*)error {
	return [NSException
	exceptionWithName:@"NSError"
	reason:[NSString
		stringWithFormat:@"Error Code: %lu\nDomain:%@\n%@",
		error.code,
		error.domain,
		error.localizedDescription]
	userInfo:error.userInfo];
}

@end
