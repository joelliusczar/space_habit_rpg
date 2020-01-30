//
//  SHViewControllerAppearanceProxy.m
//  SHControls
//
//  Created by Joel Pridgen on 1/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewControllerAppearanceProxy.h"

@interface SHViewControllerAppearanceProxy ()
@property (strong, nonatomic) SHViewController *reference;
@property (strong, nonatomic) NSMutableArray<NSInvocation*> *invocations;
@end

@implementation SHViewControllerAppearanceProxy

-(instancetype)initWithReference:(SHViewController *)reference {
	if(self = [super init]) {
		_reference = reference;
	}
	return self;
}


-(void)forwardInvocation:(NSInvocation *)anInvocation {
	if([super respondsToSelector:anInvocation.selector]) {
		[super forwardInvocation:anInvocation];
	}
	[self.invocations addObject:anInvocation];
}


-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector {
	NSMethodSignature *signature = [self.reference methodSignatureForSelector:aSelector];
	if(!signature) {
		return [super methodSignatureForSelector:aSelector];
	}
	return signature;
}


-(BOOL)respondsToSelector:(SEL)aSelector {
	BOOL referenceResponds = [self.reference respondsToSelector:aSelector];
	BOOL superResponds = [super respondsToSelector:aSelector];
	return referenceResponds || superResponds;
}


-(void)applyPropertyChangesToTarget:(SHViewController*)target {
	for (NSInvocation *invocation in self.invocations) {
    [invocation invokeWithTarget:target];
	}
}

@end
