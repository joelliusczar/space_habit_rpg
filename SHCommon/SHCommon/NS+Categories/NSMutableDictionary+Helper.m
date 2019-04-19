//
//  NSMutableDictionary+Helper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Helper)


-(id)getWithKey:(id)key OrCreateFromBlock:(id (^)(void))creator{
  id value=self[key];
  if(value){
    return value;
  }
  value=creator();
  self[key]=value;
  return value;
}

-(id)getWithKey:(id)key OrCreateFromBlock:(id (^)(id))creator withObj:(id)obj{
  id value=self[key];
  if(value){
    return value;
  }
  value=creator(obj);
  self[key]=value;
  return value;
}


@end
