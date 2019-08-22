//
//  SHEventInfo.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHEventInfo.h"

@implementation SHEventInfo

-(instancetype)init{
	if(self = [self init:nil withSenders:nil]){}
	return self;
}


-(instancetype)init:(UIEvent *)event withSenders:(id)senders, ...{
	va_list args;
	va_start(args,senders);
	if(self = [self init:event withParameters:args andParamStart:senders]){}
	va_end(args);
	return self;
}


-(instancetype)init:(UIEvent *)event withParameters:(va_list)args andParamStart:(id)paramStart{
	if(self = [super init]){
		_timestamp = [NSDate date].timeIntervalSince1970;
		_wrappedEvent = event;
		_senderStack = [NSMutableOrderedSet orderedSet];
		for(id arg = paramStart;arg;arg = va_arg(args,id)){
			[_senderStack addObject:arg];
		}
	
	}
	return self;
}



@end
