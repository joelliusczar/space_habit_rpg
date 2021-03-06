//
//	TestHelpers.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 5/27/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestHelpers.h"

@implementation TestHelpers


+(void*)getPrivateValue:(id<NSObject>)obj ivarName:(NSString *)ivarName{
	Ivar ivar = class_getInstanceVariable(obj.class,[ivarName UTF8String]);
	return (__bridge void *)(object_getIvar(obj,ivar));
}


+(void)setPrivateVar:(id<NSObject>)obj ivarName:(NSString *)ivarName
newVal:(id)newVal{
	Ivar ivar = class_getInstanceVariable(obj.class,[ivarName UTF8String]);
	object_setIvar(obj, ivar, newVal);
}


+(void)forceRelease:(id)obj{
	msg_send fRelease = (msg_send)objc_msgSend;
	SEL rel = NSSelectorFromString(@"release");
	fRelease(obj,rel);
}


+(NSArray<NSString*>*)getMethodList:(id)obj{
	return [TestHelpers getMethodListOfClass:[obj class]];
}


+(NSArray<NSString*>*)getMethodListOfClass:(Class)cls{
	if(nil == cls) return [NSArray array];
	uint32_t outCount = 0;
	Method* m = class_copyMethodList(cls,&outCount);
	NSMutableArray* results = [NSMutableArray array];
	for(uint32_t i = 0; i < outCount;i++){
		 [results addObject: NSStringFromSelector(method_getName(*m))];
		 m++;
	}
	return [NSArray arrayWithArray:results];
}


+(NSArray<NSString*>*)getIvarListOfClass:(Class)cls{
	if(nil == cls) return [NSArray array];
	uint32_t outCount = 0;
	Ivar* ivars = class_copyIvarList(cls, &outCount);
	NSMutableArray* results = [NSMutableArray array];
	for(uint32_t i = 0; i < outCount;i++){
		NSString* ivarName = [NSString stringWithUTF8String:ivar_getName(*ivars)];
		 [results addObject: ivarName];
		 ivars++;
	}
	return [NSArray arrayWithArray:results];
}


@end
