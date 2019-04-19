//
//  SHInfoDictionary.m
//  SHModels
//
//  Created by Joel Pridgen on 10/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHInfoDictionary.h"
#import <SHCommon/SHSingletonCluster.h>

@implementation SHInfoDictionary


@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        NSBundle *bundle = [NSBundle bundleForClass:self.bundleClass];
        NSObject<SHResourceUtilityProtocol> *ru = self.resourceUtil;
        _treeDict = [ru getPListDict:self.pListKey withBundle:bundle];
    }
    return _treeDict;
}

@synthesize flatDict = _flatDict;
-(NSMutableDictionary *)flatDict{
    if(!_flatDict){
        _flatDict = [NSMutableDictionary dictionary];
    }
    return _flatDict;
}


-(instancetype)initWithPListKey:(NSString*)key AndBundleClass:(Class)bundleClass
AndResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
  if(self = [super init]){
    _pListKey = key;
    _bundleClass = bundleClass;
    _resourceUtil = resourceUtil;
  }
  return self;
}


-(NSDictionary*)searchTreeForKey:(NSString*)key{
  NSEnumerator<NSString*> *enumerator = [self.treeDict keyEnumerator];
  NSString *nextKey;
  while(nextKey = [enumerator nextObject]){
      if(self.treeDict[nextKey][key]){
          return self.treeDict[nextKey][key];
      }
  }
  return nil;
}

-(NSDictionary*)getInfo:(NSString*)key{
  NSDictionary *info;
    if(!(info = [self.flatDict valueForKey:key])){
        info = [self searchTreeForKey:key];
        if(info){
            self.flatDict[key] = info;
        }
    }
    return info;
}


-(NSDictionary*)getInfo:(NSString *)key forGroup:(NSString*)groupKey{
  if(self.treeDict[groupKey][key]){
        NSDictionary *info = self.treeDict[groupKey][key];
        if(!self.flatDict[key]){
            self.flatDict[key] = info;
        }
        return info;
    }
    return nil;
}


-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    NSDictionary *group = self.treeDict[key];
    return group.allKeys;
}

@end
