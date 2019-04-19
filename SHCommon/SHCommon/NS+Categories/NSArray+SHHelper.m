//
//  NSArray+Helper.m
//  SHCommon
//
//  Created by Joel Pridgen on 4/18/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSArray+SHHelper.h"

@implementation NSArray (SHHelper)


-(NSMutableArray*)arrayWithItemsAsDicts{
  return shArrayWithItemsAsDicts(self, shDefaultTransformer,nil);
}


-(NSMutableArray*)arrayWithItemsAsDictsWithTransformer:
  (shDictEntrytransformer)transformer
  withSet:(NSMutableSet*)cycleTracker
{
  return shArrayWithItemsAsDicts(self, transformer,cycleTracker);
}

@end
