//
//  nextDayTests.h
//  TestCommon
//
//  Created by Joel Pridgen on 3/7/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <TestCommon/TestCommon.h>

extern unsigned char days[2191];

#define calcRange(x0,x1)

@interface nextDayTests : FrequentCase
@property (assign,nonatomic) BOOL isDaysSet;
NSUInteger findNextDueDateOffset(NSInteger startOffset);
void log_w(NSUInteger weekNum,NSUInteger lastDayIdx,int scaler,NSUInteger dayIdx);
void error_w(NSUInteger weekNum,NSUInteger lastDayIdx,int scaler,NSUInteger dayIdx);
-(void)calcRange:(NSUInteger *)week scaler:(int)scaler;
@end
