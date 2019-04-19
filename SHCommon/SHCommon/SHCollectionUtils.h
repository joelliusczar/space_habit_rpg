//
//  CollectionUtils.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/18/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//



#ifndef SHCollectionUtils_h
#define SHCollectionUtils_h

#import <Foundation/Foundation.h>

typedef id (^dictEntrytransformer)(id,NSMutableSet*);

extern const dictEntrytransformer defaultTransformer;

NSMutableArray *shArrayWithItemsAsDicts(NSArray *array,
  dictEntrytransformer transformer,
  NSMutableSet *cycleTracker);

#endif
