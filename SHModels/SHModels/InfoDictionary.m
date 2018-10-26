//
//  InfoDictionary.m
//  SHModels
//
//  Created by Joel Pridgen on 10/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "InfoDictionary.h"
#import <SHCommon/SingletonCluster.h>

@implementation InfoDictionary


@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        NSBundle *bundle = [NSBundle bundleForClass:self.bundleClass];
        NSObject<P_ResourceUtility> *ru = [SingletonCluster getSharedInstance].resourceUtility;
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


-(instancetype)initWithPListKey:(NSString*)key{
  if(self = [super init]){
    _pListKey = key;
  }
  return self;
}

@end
