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

typedef id (^shDictEntrytransformer)(id,NSMutableSet*);

extern const shDictEntrytransformer shDefaultTransformer;

NSMutableArray *shArrayWithItemsAsDicts(NSArray *array,
  shDictEntrytransformer transformer,
  NSMutableSet *cycleTracker);

#endif
