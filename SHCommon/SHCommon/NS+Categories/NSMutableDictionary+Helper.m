//
//  NSMutableDictionary+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"

@implementation NSMutableDictionary (Helper)

-(NSMutableSet *)getOrCreateMutableSetAtKeyedSubscript:(id)key{
    NSMutableSet *set=self[key]?self[key]:[NSMutableSet set];
    self[key]=set;
    return set;
}

-(id)getWithKey:(id)key OrCreateFromBlock:(id (^)(void))creator{
    id value=self[key];
    if(value){
        return value;
    }
    value=creator();
    self[key]=value;
    return value;
}

@end
