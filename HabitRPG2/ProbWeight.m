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
    @property (nonatomic,assign) int32_t sum;
@end

NSString *freq = @"freq";
NSString *freqSum = @"cummFreq";
NSString *storedKey = @"key";

@implementation ProbWeight
    
    @synthesize weights = _weights;
    -(NSMutableArray<NSDictionary *> *)weights{
        if(!_weights){
            _weights = [NSMutableArray array];
        }
        return _weights;
    }
    
    -(void)add:(NSString *)key With:(int32_t)freq{
        uint32_t sum = ((NSNumber *)[self.weights lastObject][freqSum]).intValue;
        sum += freq;
        self.sum += freq;
        [self.weights addObject:[self buildFreqPair:key Freq:[NSNumber numberWithInt:freq] Sum:[NSNumber numberWithInt:sum]]];
    }
    
    -(NSDictionary *)buildFreqPair:(NSString *)key Freq:(NSNumber *)frq Sum:(NSNumber *)sum{
        return [NSDictionary dictionaryWithObjectsAndKeys:key,storedKey,frq,freq,sum,freqSum, nil];
    }
    
    -(NSString *)weightedRandomKey{
        uint32_t r = [CommonUtilities randomUInt:self.sum];
        int64_t start = 0;
        int64_t end = self.weights.count;
        while(start <= end){
            int64_t mid = ((end-start)/2) + start;
            int64_t midValue = ((NSNumber *)self.weights[mid][freqSum]).intValue;
            if(r < midValue){
                end = mid;
                continue;
            }
            if(r > midValue){
                start = mid;
                continue;
            }
            return self.weights[mid][storedKey];
        }
        
        return nil;
    }
@end
