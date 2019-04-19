//
//  NSDictionary+Helper.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/18/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCollectionUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (SHHelper)
-(NSString *)dictToString;
+(NSMutableDictionary *)jsonStringToDict:(NSString *)jsonStr;
+(NSMutableDictionary*)objectToDictionary:(NSObject*)object;


+(NSMutableDictionary*)objectToDictionary:
  (NSObject*)object
  withTransformer:(dictEntrytransformer)transformBlock
  withSet:(NSMutableSet*)cycleTracker;

-(NSMutableDictionary*)mapEntiresToDicts;

-(NSMutableDictionary*)mapEntiresToDictsWithTransformer:
  (dictEntrytransformer)transformer
  withSet:(NSMutableSet*)cycleTracker;

@end

NS_ASSUME_NONNULL_END
