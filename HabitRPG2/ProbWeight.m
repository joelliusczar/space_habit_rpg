//
//  ProbWeight.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ProbWeight.h"
#import "CommonUtilities.h"

@interface ProbWeight()
    @property (nonatomic,strong) NSMutableArray<NSDictionary *> *weights;
    @property (nonatomic,assign) int sum;
    @property (nonatomic,strong) NSMutableSet<NSString *> *alreadyAdded;
@end

NSString *freq = @"freq";
NSString *freqSum = @"cummFreq";
NSString *storedKey = @"key";
NSString *freqSumLow = @"cummFreqLow";

@implementation ProbWeight
    
    @synthesize weights = _weights;
    -(NSMutableArray<NSDictionary *> *)weights{
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
    
    -(void)add:(NSString *)key With:(int)freq{
        NSAssert(freq>0,@"freq needs to be greater than 0");
        NSAssert(key.length,@"submitted key is null or empty");
        NSAssert(self.weights.count<INT32_MAX, @"Can't add any more freqs");
        NSAssert(![self.alreadyAdded containsObject:key], @"item is already in distribution");
        [self.alreadyAdded addObject:key];
        int sum = self.weights.count?((NSNumber *)[self.weights lastObject][freqSum]).intValue:0;
        int prevSum = sum;
        sum += freq;
        self.sum += freq;
        [self.weights addObject:[self buildFreqItem:key Freq:[NSNumber numberWithInt:freq] Upbound:[NSNumber numberWithInt:sum] LowBound:[NSNumber numberWithInt:prevSum]]];
    }
    
    -(NSDictionary *)buildFreqItem:(NSString *)key Freq:(NSNumber *)frq Upbound:(NSNumber *)up LowBound:(NSNumber *)low{
        return [NSDictionary dictionaryWithObjectsAndKeys:key,storedKey,frq,freq,up,freqSum,low,freqSumLow, nil];
    }
    
    /*
        Use a binary search and then narrow the field down by which percentage of
        the distribution that the random number occupies
     */
    -(NSString *)weightedRandomKey{
        NSAssert(self.sum > 0,@"ProbWeight is empty");
        uint32_t r = [CommonUtilities randomUInt:self.sum];
        int64_t start = 0;
        int64_t end = self.weights.count;
        int64_t mid = ((end-start)/2) + start;
        double rPercent = ((double)r)/self.sum;
        while(start < end){
            mid = ((end-start)/2) + start;
            double midPercent = ((NSNumber *)self.weights[mid][freqSumLow]).doubleValue/self.sum;
            if(rPercent < midPercent){
                end = mid-1;
                continue;
            }
            if(rPercent > midPercent){
                start = mid+1;
                continue;
            }
            break;
        }
        if(start == end&&end<self.weights.count-1){
            mid = ((end-start)/2) + start;
        }
        
        return self.weights[mid][storedKey];
    }
@end
