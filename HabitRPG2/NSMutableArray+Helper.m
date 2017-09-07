//
//  NSMutableArray+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

-(NSInteger)findPlaceFor:(id)object whereBestFits:(bestMatchPredicate)bestFitBlock{
    
    if(self.count == 0){
        return 0;
    }
    for(int i = 0;i<self.count;i++){
        if(bestFitBlock(self[i],object)){
            return i;
        }
    }
    return self.count;
}

@end
