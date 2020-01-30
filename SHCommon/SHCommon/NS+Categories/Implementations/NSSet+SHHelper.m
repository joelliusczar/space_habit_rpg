//
//	NSSet+Helper.m
//	SHCommon
//
//	Created by Joel Pridgen on 4/18/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSSet+SHHelper.h"


@implementation NSSet (SHHelper)

-(NSMutableArray*)arrayWithItemsAsDicts{
	return shArrayWithItemsAsDicts((NSArray*)self,shDefaultTransformer,nil);
}


-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
	(shDictEntrytransformer)transformer
	withSet:(NSMutableSet*)cycleTracker
{
	return shArrayWithItemsAsDicts((NSArray*)self,transformer,cycleTracker);
}

@end
