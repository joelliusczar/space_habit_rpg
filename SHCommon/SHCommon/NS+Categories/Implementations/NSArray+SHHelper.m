//
//	NSArray+Helper.m
//	SHCommon
//
//	Created by Joel Pridgen on 4/18/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSArray+SHHelper.h"

@implementation NSArray (SHHelper)


-(NSMutableArray*)arrayWithItemsAsDicts{
	return shArrayWithItemsAsDicts(self, shDefaultTransformer,nil);
}


-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
	(shDictEntrytransformer)transformer
	withSet:(NSMutableSet*)cycleTracker
{
	return shArrayWithItemsAsDicts(self, transformer,cycleTracker);
}


-(NSUInteger)findPlaceFor:(id)object whereFirstFits:(BOOL (^)(id,id))bestFitBlock{
	if(self.count == 0){
		return 0;
	}
	for(NSUInteger i = 0;i<self.count;i++){
		if(bestFitBlock(self[i],object)){
			return i;
		}
	}
	return self.count;
}


-(NSUInteger)findPlaceFor:(id)object whereFirstFitsFP:(BOOL (*)(id,id))bestFitFP{
	return [self findPlaceFor:object whereFirstFits:^BOOL(id a,id b){
		return bestFitFP(a,b);
	}];
}


-(NSMutableArray*)mapItemsTo:(id (^)(id,NSUInteger))mapper{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	NSUInteger idx = 0;
	for (id obj in self) {
		[result addObject:mapper(obj,idx)];
		idx++;
	}
	return result;
}


-(NSMutableArray*)mapItemsTo_f:(id	_Nonnull (*)(id _Nonnull, NSUInteger))mapper{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.count];
	NSUInteger idx = 0;
	for (id obj in self) {
		[result addObject:mapper(obj,idx)];
		idx++;
	}
	return result;
}

-(id)silentGet:(NSUInteger)index {
	if(index < self.count) return self[index];
	return nil;
}


-(NSMutableArray *)SH_subtractArray:(NSArray *)arr {
	NSSet *takeAwaySet = [NSSet setWithArray:arr];
	NSMutableArray *results = [NSMutableArray array];
	for (id element in self) {
  	if(![takeAwaySet containsObject:element]) {
  		[results addObject:element];
		}
	}
	return results;
}

@end
