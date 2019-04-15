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

+(NSString *_Nonnull)dictToString:(NSDictionary *_Nonnull)dict{
  NSError *err = nil;
  NSData *jsonData = [NSJSONSerialization
    dataWithJSONObject:dict
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


+(NSMutableDictionary*)objectToDictionary:(NSObject*)object{
  uint32_t outCount = 0;
  objc_property_t *props = class_copyPropertyList(object.class,&outCount);
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:outCount];
  for(uint32_t i = 0; i < outCount; i++){
    const char *propName = property_getName(props[i]);
    NSString *nsPropName = [NSString stringWithUTF8String:propName];
    id objectVal = [object valueForKey:nsPropName];
    [dict setObject:objectVal forKey:nsPropName];
    free((void*)propName);
  }
  free(props);
  return dict;
}

@end
