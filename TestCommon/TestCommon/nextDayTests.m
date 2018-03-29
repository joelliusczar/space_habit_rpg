//
//  nextDayTests.m
//  TestCommon
//
//  Created by Joel Pridgen on 3/7/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "nextDayTests.h"

unsigned char days[2191] = {};

@implementation nextDayTests

-(void)setUp{
    [super setUp];
}

-(void)calcRange:(NSUInteger *)week scaler:(int)scaler{
    if(self.isDaysSet){
        return;
    }
    self.isDaysSet = YES;
    int span = (scaler*7) -1;
    int nonActiveSpan = 0;
    if(span > 6){
        nonActiveSpan = span -7;
        for(int i = 0; i<=nonActiveSpan;i++){
            days[i] = 0;
        }
        nonActiveSpan++;
    }
    int dayIdx = 0;
    
    for(NSUInteger i = nonActiveSpan;i<=span;i++){
        dayIdx = i % 7;
        days[i] = week[dayIdx];
    }
    span++;
    for(NSUInteger i = span;i<2191;i++){
        days[i] = i % span >= (span - 7)? week[i % 7]:0;
    }
}

NSUInteger findNextDueDateOffset(NSInteger startOffset){
    NSUInteger i = 0;
    for(NSUInteger i = startOffset;i<2191;i++){
        if(days[i] == 1){
            return i;
        }
    }
    return i;
}

void log_w(NSUInteger weekNum,NSUInteger lastDayIdx,int scaler,NSUInteger dayIdx){
    NSLog(@"Week Num: %lu lastDayIdx: %lu scaler: %d dayIdx:%lu",weekNum,lastDayIdx,scaler,dayIdx);
}


void error_w(NSUInteger weekNum,NSUInteger lastDayIdx,int scaler,NSUInteger dayIdx){
    @throw [NSException exceptionWithName:@"Test Failed" reason:nil userInfo:nil];
}

@end
