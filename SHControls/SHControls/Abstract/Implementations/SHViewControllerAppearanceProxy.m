//
//  SHViewControllerAppearanceProxy.m
//  SHControls
//
//  Created by Joel Pridgen on 1/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewControllerAppearanceProxy.h"
#import "SHInvocationsBucketSet.h"
#import "SHProxyTypeJunction.h"
#import "SHViewController+SHAppearance.h"

@interface SHViewControllerAppearanceProxy ()
@property (strong, nonatomic) SHViewController *reference;
@property (strong, nonatomic) SHInvocationDict *invocations;
@end

@implementation SHViewControllerAppearanceProxy


-(NSMutableDictionary<NSString *,NSInvocation*>*)invocations {
	if(nil == _invocations) {
		_invocations = [NSMutableDictionary dictionary];
	}
	return _invocations;
}


-(UIColor*)viewBackgroundColor {
	return nil;
}


-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
	NSMethodSignature *signature = [self.reference methodSignatureForSelector:@selector(setViewBackgroundColor:)];
	
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setSelector:@selector(setViewBackgroundColor:)];
	[invocation setArgument:&viewBackgroundColor atIndex:2];
	[invocation retainArguments];
	self.invocations[@"setViewBackgroundColor"] = invocation;
}


-(instancetype)initWithReference:(SHViewController *)reference {
	if(self = [super init]) {
		_reference = reference;
	}
	return self;
}


-(instancetype)initWithReference:(SHViewController *)reference
	withClassList:(SHAppearanceHierarchy *)classList
	withTraitCollection:(UITraitCollection *)traitCollection
{
	if(self = [super init]) {
		_reference = reference;
		_classList = classList;
		_traits = traitCollection;
	}
	return self;
}


-(instancetype)initWithReference:(SHViewController *)reference
	withClassList:(SHAppearanceHierarchy *)classList
{
	if(self = [super init]) {
		_reference = reference;
		_classList = classList;
	}
	return self;
}


-(instancetype)initWithReference:(SHViewController *)reference
	withTraitCollection:(UITraitCollection *)traitCollection
{
	if(self = [super init]) {
		_reference = reference;
		_traits = traitCollection;
	}
	return self;
}


-(void)forwardInvocation:(NSInvocation *)anInvocation {
	if([super respondsToSelector:anInvocation.selector]) {
		[super forwardInvocation:anInvocation];
	}
	[anInvocation retainArguments];
	NSString *selName = NSStringFromSelector(anInvocation.selector);
	self.invocations[selName] = anInvocation;
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


-(SHInvocationsBucketSet*)loadInvocationsFromJunction:(SHProxyTypeJunction*)junction {
	SHInvocationsBucketSet *invocationsBucketSet = [[SHInvocationsBucketSet alloc] init];
	if(self.classList && self.traits) {
		SHHierarchyDict *classListDict = junction.classListTraitDict[self.traits];
		if(classListDict) {
			SHViewControllerAppearanceProxy *proxy = classListDict[self.classList];
			invocationsBucketSet.classListTrait = proxy.invocations;
		}
	}
	if(self.classList) {
		SHViewControllerAppearanceProxy *proxy = junction.classListDict[self.classList];
		invocationsBucketSet.classList = proxy.invocations;
	}
	if(self.traits) {
		SHViewControllerAppearanceProxy *proxy = junction.traitDict[self.traits];
		invocationsBucketSet.trait = proxy.invocations;
	}
	invocationsBucketSet.single = junction.singleProxy.invocations;
	return invocationsBucketSet;
}


-(void)applyPropertyChangesToTarget:(SHViewController*)target {
	SHInvocationsBucketSet *collectedInvocations = [[SHInvocationsBucketSet alloc] init];
	[SHViewController.tree runAction:^(SHInheritanceTreeNode<Class,SHProxyTypeJunction *> *node){
		SHProxyTypeJunction *junction = node.storedObject;
		SHInvocationsBucketSet *nodeInvocations = [self loadInvocationsFromJunction:junction];
		[collectedInvocations mergeIn:nodeInvocations];
		
	} matchingKey:self.reference.class];
	SHInvocationDict *invocations = [collectedInvocations selectOperationSet];
	for (NSInvocation *invocation in invocations.allValues) {
    [invocation invokeWithTarget:target];
	}
}


@end


