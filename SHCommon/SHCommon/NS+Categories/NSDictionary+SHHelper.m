//
//  NSDictionary+Helper.m
//  SHCommon
//
//  Created by Joel Pridgen on 4/18/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSDictionary+SHHelper.h"
#import "NSArray+SHHelper.h"
#import <objc/runtime.h>


@implementation NSDictionary (SHHelper)


static NSMutableDictionary* _mapEntriesToDict(NSDictionary *dict,
  dictEntrytransformer transformer,
  NSMutableSet* cycleTracker)
  {
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:dict.count];
  [dict enumerateKeysAndObjectsUsingBlock:^(id key,id object,BOOL *shouldStop){
    (void)shouldStop;
    id subDict = [NSMutableDictionary objectToDictionary:object
      withTransformer:transformer
      withSet:cycleTracker];
    [result setObject:subDict forKey:key];
  }];
  return result;
}


-(NSMutableDictionary*)mapEntiresToDicts{
  return _mapEntriesToDict(self, defaultTransformer,nil);
}


-(NSMutableDictionary*)mapEntiresToDictsWithTransformer:
  (dictEntrytransformer)transformer
  withSet:(NSMutableSet*)cycleTracker{
  return _mapEntriesToDict(self, transformer,cycleTracker);
}


-(NSString *_Nonnull)dictToString{
  NSError *err = nil;
  NSData *jsonData = [NSJSONSerialization
    dataWithJSONObject:self
    options:NSJSONWritingPrettyPrinted error:&err];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(NSMutableDictionary *_Nonnull)jsonStringToDict:(NSString *_Nonnull)jsonStr{
  NSError *err = nil;
  NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
  NSMutableDictionary *jsonDict = [NSJSONSerialization
    JSONObjectWithData:jsonData
    options:NSJSONReadingMutableContainers
    error:&err];
  return jsonDict;
}


static NSMutableDictionary* objectToDict(NSObject *object,
  dictEntrytransformer transformer,
  NSMutableSet* cycleTracker){
  
  if(nil == cycleTracker){
    cycleTracker = [NSMutableSet set];
  }
  
  if([cycleTracker containsObject:object]){
    return nil;
  }
  [cycleTracker addObject:object];
  
  if([object respondsToSelector:@selector(mapEntiresToDictsWithTransformer:withSet:)]){
    NSDictionary *dict = (NSDictionary*)object;
    return [dict mapEntiresToDictsWithTransformer:transformer
      withSet:cycleTracker];
  }
  uint32_t outCount = 0;
  objc_property_t *props = class_copyPropertyList(object.class,&outCount);
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:outCount];
  for(uint32_t i = 0; i < outCount; i++){
    const char *propName = property_getName(props[i]);
    NSString *nsPropName = [NSString stringWithUTF8String:propName];
    id objectVal = [object valueForKey:nsPropName];
    if(transformer){
      objectVal = transformer(objectVal,cycleTracker);
    }
    if(objectVal){
      [dict setObject:objectVal forKey:nsPropName];
    }
    free((void*)propName);
  }
  free(props);
  return dict;
}

+(NSMutableDictionary*)objectToDictionary:
  (NSObject*)object
  withTransformer:(dictEntrytransformer)transformBlock
  withSet:(NSMutableSet*)cycleTracker
{
  return objectToDict(object, transformBlock,cycleTracker);
}


+(NSMutableDictionary*)objectToDictionary:(NSObject*)object{
  return objectToDict(object, defaultTransformer,nil);
}


@end
