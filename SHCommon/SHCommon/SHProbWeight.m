//
//  SHProbWeight.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHProbWeight.h"
#import "SHCommonUtils.h"
#import "NSArray+SHHelper.h"

@interface SHFreqItem : NSObject
@property (copy, nonatomic) NSString *key;
@property (assign, nonatomic) int32_t freq;
@property (assign, nonatomic) int32_t upperBound;
@property (assign, nonatomic) int32_t lowerBound;
-(instancetype)initWithKey:(NSString *)key freq:(int32_t)freq
	upperBound:(int32_t)upperBound
	lowerBound:(int32_t)lowerBound;
@end


@implementation SHFreqItem

-(instancetype)initWithKey:(NSString *)key freq:(int32_t)freq
	upperBound:(int32_t)upperBound
	lowerBound:(int32_t)lowerBound
{
	if(self = [super init]) {
		_key = key;
		_freq = freq;
		_upperBound = upperBound;
		_lowerBound = lowerBound;
	}
	return self;
}


-(NSString*)debugDescription {
	NSString *desc = [NSString stringWithFormat:@"%@\nfreq: %d\nupperBound: %d\nlowerBound: %d",
		self.key,
		self.freq,
		self.upperBound,
		self.lowerBound];
	return desc;
}

@end


@interface SHProbWeight()
	@property (nonatomic,strong) NSMutableArray<SHFreqItem *> *weights;
	@property (nonatomic,assign) double sum;
	@property (nonatomic,strong) NSMutableSet<NSString *> *alreadyAdded;
@end


@implementation SHProbWeight
	
@synthesize weights = _weights;
-(NSMutableArray<SHFreqItem *> *)weights{
	if(!_weights){
		_weights = [NSMutableArray array];
	}
	return _weights;
}

@synthesize alreadyAdded = _alreadyAdded;
-(NSMutableSet<NSString *> *)alreadyAdded{
	if(!_alreadyAdded){
		_alreadyAdded = [NSMutableSet set];
	}
	return _alreadyAdded;
}


-(void)add:(NSString *)key with:(int32_t)freq{
	NSAssert(freq > 0, @"freq needs to be greater than 0");
	NSAssert(key.length, @"submitted key is null or empty");
	NSAssert(self.weights.count < INT32_MAX, @"Can't add any more freqs");
	NSAssert(![self.alreadyAdded containsObject:key], @"item is already in distribution");
	[self.alreadyAdded addObject:key];
	int32_t sum = self.weights.count ? [self.weights lastObject].upperBound : 0;
	int32_t prevSum = sum;
	sum += freq;
	self.sum += freq;
	[self.weights addObject:[[SHFreqItem alloc] initWithKey:key freq:freq upperBound:sum lowerBound:prevSum]];
}
	
	
/*
	Use a binary search and then narrow the field down by which percentage of
	the distribution that the random number occupies
 */
-(NSString *)weightedRandomKey{
	NSAssert(self.sum > 0, @"ProbWeight is empty");
	uint32_t r = shRandomUInt(self.sum);
	int64_t start = 0;
	int64_t end = self.weights.count;
	int64_t mid = ((end - start) / 2) + start;
	double rPercent = ((double)r)/self.sum;
	while(start<end){
		double lowPercent = self.weights[mid].lowerBound / self.sum;
		double upPercent = self.weights[mid].upperBound / self.sum;
		if(rPercent < lowPercent){
			end = mid - 1;
		}
		if(rPercent >= upPercent){
			start = mid + 1;
		}
		mid = ((end - start) / 2) + start;
		if(rPercent <= upPercent && rPercent >= lowPercent){
			break;
		}
	}
	
	return self.weights[mid].key;
}

-(NSString *)debugDescription {
	NSMutableString *percents = [NSMutableString string];
	for(SHFreqItem *item in self.weights) {
		[percents appendFormat:@"%@ : (%d / %f) %f\n",item.key, item.freq, self.sum, item.freq / self.sum];
	}
	
	return percents;
}
@end
