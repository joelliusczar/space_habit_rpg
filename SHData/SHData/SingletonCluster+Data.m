//
//  SingletonCluster+Data.m
//  SHData
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SingletonCluster+Data.h"
#import "SHCoreData.h"
#import "SHCommon/NSMutableDictionary+Helper.h"

static NSObject* dbMutex;
static NSObject* constructorBlockMutex;

@implementation SingletonCluster (Data)

+(void)initialize{
  dbMutex = [NSObject new];
  constructorBlockMutex = [NSObject new];
}


-(void (^)(SHCoreDataOptions*))constructorBlock{
  @synchronized (constructorBlockMutex) {
      return [self.bag getWithKey:@"constructorBlock" OrCreateFromBlock:^id(){
        return ^(SHCoreDataOptions *options){
          options.dbFileName = DEFAULT_DB_NAME;
        };
      }];
  }
}

-(void)setConstructorBlock:(void (^)(SHCoreDataOptions *))constructorBlock{
  @synchronized (constructorBlockMutex) {
    self.bag[@"constructorBlock"] = constructorBlock;
  }
}

-(NSObject<P_CoreData> *)dataController{
  @synchronized (dbMutex) {
    
    id ans = [self.bag getWithKey:@"dc" OrCreateFromBlock:^id(id obj){
        SingletonCluster* sc = (SingletonCluster*)obj;
        return [SHCoreData newWithOptionsBlock:sc.constructorBlock];
    } withObj:self];
    return ans;
  }
}


-(void)setDataController:(NSObject<P_CoreData> *)dataController{
  @synchronized (dbMutex) {
    self.bag[@"dc"] = dataController;
  }
}

@end
