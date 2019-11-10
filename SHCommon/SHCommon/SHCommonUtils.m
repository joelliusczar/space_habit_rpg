//
//	CommonUtilities.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/21/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//


#import <objc/runtime.h>
#import "SHCommonUtils.h"
#import "NSObject+Helper.h"
#import "NSException+SHCommonExceptions.h"



uint (*shRandomUInt)(uint) = &arc4random_uniform;

void shReverse_UINT(NSUInteger * _Nonnull array,NSUInteger len){
	for(NSUInteger i = 0;i < len/2;i++){
		NSUInteger tmp = array[i];
		array[i] = array[len - i -1];
		array[len -i -1] = tmp;
	}
}

CGFloat shCalcFrameHeightOffset(CGRect expectedBigger,CGRect expectedSmaller){
	return CGRectGetHeight(expectedSmaller) < CGRectGetHeight(expectedBigger) ?
		CGRectGetHeight(expectedBigger) - CGRectGetHeight(expectedSmaller) : 0;
}


BOOL shWaitForSema(dispatch_semaphore_t sema,NSInteger timeoutSecs){
	dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * timeoutSecs);
	long result = dispatch_wait(sema,t);
	return result == 0;
}

void shCopyInstanceVar(NSObject* from,NSObject* to,NSString *varName){
	id fromVal = [from valueForKey:varName];
	[to setValue:fromVal forKey:varName];
}


NSArray<NSString*>* shBuildWeekBasedOnWeekStart(NSUInteger weekStart){
	NSArray<NSString*> *days = @[@"SUN",@"MON",@"TUE",@"WED",@"THR",@"FRI",@"SAT"];
	if(weekStart == 0){
		return days;
	}
	NSMutableArray<NSString*> *result = [NSMutableArray arrayWithCapacity:7];
	if(weekStart > 6) return nil;
	for(NSUInteger day = 0; day < 7; day++){
		[result addObject:days[weekStart + day % 7]];
	}
	return result;
}

NSString* shWeekDayKeyToFull(NSString * dayKey){
	if([dayKey isEqualToString:@"SUN"]){
		return @"Sunday";
	}
	if([dayKey isEqualToString:@"MON"]){
		return @"Monday";
	}
	if([dayKey isEqualToString:@"TUE"]){
		return @"Tuesday";
	}
	if([dayKey isEqualToString:@"WED"]){
		return @"Wednesday";
	}
	if([dayKey isEqualToString:@"THR"]){
		return @"Thursday";
	}
	if([dayKey isEqualToString:@"FRI"]){
		return @"Friday";
	}
	if([dayKey isEqualToString:@"SAT"]){
		return @"Saturday";
	}
	return nil;
}
