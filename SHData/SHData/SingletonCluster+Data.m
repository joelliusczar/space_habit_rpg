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

@implementation SingletonCluster (Data)

-(NSString *)dbFileName{
    return [self.bag getWithKey:@"dbName" OrCreateFromBlock:^id(){
        return @"Model.sqlite";
    }];
}

-(void)setDbFileName:(NSString *)dbFileName{
    self.bag[@"dbName"] = dbFileName;
}

-(NSObject<P_CoreData> *)dataController{
    return [self.bag getWithKey:@"dc" OrCreateFromBlock:^id(){
        return [CoreDataStackController newWithBundle:self.bundle dBFileName:self.dbFileName];
    }];
}


-(void)setDataController:(NSObject<P_CoreData> *)dataController{
    self.bag[@"dc"] = dataController;
}

@end
