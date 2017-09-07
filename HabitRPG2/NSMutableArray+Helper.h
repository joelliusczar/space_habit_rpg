//
//  NSMutableArray+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

typedef BOOL (^bestMatchPredicate)(RateValueItemDict *,RateValueItemDict *);

@interface NSMutableArray (Helper)
-(NSInteger)findPlaceFor:(id)object whereBestFits:(bestMatchPredicate)bestFitBlock;
@end
