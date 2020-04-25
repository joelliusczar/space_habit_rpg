//
//	NSMutableArray+Helper.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/5/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

-(NSUInteger)findPlaceFor:(id)object whereBestFits:(BOOL (^)(id,id))bestFitBlock{
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

-(NSUInteger)findPlaceFor:(id)object whereBestFitsFP:(BOOL (*)(id,id))bestFitFP{
	return [self findPlaceFor:object whereBestFits:^BOOL(id a,id b){
		return bestFitFP(a,b);
	}];
}


-(void)SH_enqueue:(id)obj {
	[self addObject:obj];
}


-(id)SH_dequeue {
	if(self.count < 1) return nil;
	id head = self[0];
	[self removeObjectAtIndex: 0];
	return head;
}


+(NSMutableArray*)variadicToArray:(id)values, ... {
	NSMutableArray *array = [NSMutableArray array];
	if(nil == values) return array;
	
	va_list args;
	va_start(args, values);
	
	id current = nil;
	while((current = va_arg(args, id))) {
		[array addObject: current];
	}
	
	va_end(args);
	
	return array;
}


-(void)copyRangeFromArray:(NSArray<id<NSCopying>>*)array {
	for (id<NSCopying> item in array) {
    [self addObject:[item copyWithZone:nil]];
	}
}

@end
