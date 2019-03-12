//
//  SingletonCluster+Data.m
//  SHData
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SingletonCluster+Data.h"
#import "CoreDataStackController.h"
#import "SHCommon/NSMutableDictionary+Helper.h"

static NSObject* dbMutex;

@implementation SingletonCluster (Data)

+(void)initialize{
  dbMutex = [NSObject new];
}

-(NSString *)dbFileName{
    return [self.bag getWithKey:@"dbName" OrCreateFromBlock:^id(){
        return DEFAULT_DB_NAME;
    }];
}

-(void)setDbFileName:(NSString *)dbFileName{
    self.bag[@"dbName"] = dbFileName;
  
    /*Reset the datacontroller*/
    self.dataController = nil;
}

-(NSObject<P_CoreData> *)dataController{
  @synchronized (dbMutex) {
    id ans = [self.bag getWithKey:@"dc" OrCreateFromBlock:^id(id obj){
        SingletonCluster* sc = (SingletonCluster*)obj;
        return [CoreDataStackController newWithBundle:sc.bundle dBFileName:sc.dbFileName];
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
