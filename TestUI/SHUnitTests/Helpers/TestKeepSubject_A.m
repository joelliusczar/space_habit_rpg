//
//  TestKeepObject_A.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestKeepSubject_A.h"
#import <objc/runtime.h>
@import SHCommon;

@interface TestKeepSubject_A()
@end

@implementation TestKeepSubject_A{
	int retainHitCount;
	int releaseHitCount;
	int autoreleaseHitCount;
}



void swizzleIt(Method method,SEL ourSel,Class cls){
	Method ourMethod = class_getInstanceMethod(cls,ourSel);
	
	class_addMethod(cls,
					method_getName(method),
					method_getImplementation(ourMethod),
					method_getTypeEncoding(ourMethod));
	class_replaceMethod(cls,
						ourSel,
						method_getImplementation(method),
						method_getTypeEncoding(method));
}

+(void)load{
//	static dispatch_once_t token;
//	dispatch_once(&token,^{
//	   unsigned int outCount;
//	   Method *mList = class_copyMethodList(NSObject.class,&outCount);
//	   
//	   for(int i = 0;i < outCount;i++){
//		   Method method = mList[i];
//		   
//		   NSString *name = NSStringFromSelector(method_getName(method));
//		   if([name isEqualToString:@"retain"]){
//			   swizzleIt(method,@selector(swz_release),self.class);
//		   }
//		   if([name isEqualToString:@"release"]){
//			   swizzleIt(method,@selector(swz_release),self.class);
//		   }
//		   if([name isEqualToString:@"autorelease"]){
//			   swizzleIt(method,@selector(swz_autorelease),self.class);
//		   }
//	   }
//		
//		
//	});
}

-(instancetype)swz_retain{
	NSLog(@"retain hits: %d",++retainHitCount);
	return [self swz_retain];
}


-(oneway void)swz_release{
	NSLog(@"release hits: %d",++releaseHitCount);
	return [self swz_release];
}


-(instancetype)swz_autorelease{
	NSLog(@"autorelease hits: %d",++autoreleaseHitCount);
	return [self swz_autorelease];
}

-(void)setDelegateA:(id<TestKeepProtocol_A>)delegateA{
	_delegateA = delegateA;
}


-(void)setDelegateB:(id<TestKeepProtocol_B>)delegateB{
	_delegateB = delegateB;
}


-(void)setDelegateC:(id<TestKeepProtocol_C>)delegateC{
	_delegateC = delegateC;
}


-(NSInteger)callGetA{
	return [self.delegateA get52] +self.changer;
}


-(NSInteger)callGetB{
	return [self.delegateB get65] +self.changer;
}


-(NSInteger)callGetC{
	return [self.delegateC get19] +self.changer;
}


-(void)dealloc{
	NSLog(@"%@",@"dealloc");
}



@end
