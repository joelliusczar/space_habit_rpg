//
//	CollectionUtils.m
//	SHCommon
//
//	Created by Joel Pridgen on 4/18/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHCollectionUtils.h"
#import "NSDictionary+SHHelper.h"
#import "NSArray+SHHelper.h"
#import "SHCommonUtils.h"


const shDictEntrytransformer shDefaultTransformer = ^id(id object,
	NSMutableSet *cycleTracker)
{
	if(nil == object){
		return [NSNull null];
	}
	if([object isMemberOfClass:NSDate.class]){
		NSDate *date = (NSDate*)object;
		return [NSNumber numberWithDouble:date.timeIntervalSince1970];
	}
	BOOL isNumber = [object isKindOfClass:NSNumber.class];
	BOOL isString = [object isKindOfClass:NSString.class];
	BOOL isNSValue = [object isKindOfClass:NSValue.class];
	if(isNumber || isString || isNSValue) {
		return object;
	}
	if([object respondsToSelector:@selector(enumerateObjectsUsingBlock:)]){
		NSArray *array = (NSArray*)object;
		return [array arrayWithItemsAsDictsWithTransformer:
			shDefaultTransformer
			withSet:cycleTracker];
	}
	return [NSDictionary objectToDictionary:object
		withTransformer:shDefaultTransformer
		withSet:cycleTracker];
};

NSMutableArray *shArrayWithItemsAsDicts(NSArray *array,
	shDictEntrytransformer transformer,
	NSMutableSet *cycleTracker)
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
	[array enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *shouldStop){
		(void)idx;
		(void)shouldStop;
		id subDict = [NSMutableDictionary objectToDictionary:obj
			withTransformer:transformer
			withSet:cycleTracker];
		[result addObject:subDict];
	}];
	return result;
}
