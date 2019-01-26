//
//  MonsterTransaction_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHGlobal/Constants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import "MonsterTransaction_Medium.h"

@interface MonsterTransaction_Medium ()
@property (weak,nonatomic) NSObject<P_CoreData>* dataController;
@end


@implementation MonsterTransaction_Medium

@synthesize dataController = _dataController;

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController{
  MonsterTransaction_Medium *instance = [[MonsterTransaction_Medium alloc] init];
  instance.dataController = dataController;
  return instance;
}
-(void)addCreateTransaction:(Monster *)m{
  MonsterTransaction *mt = (MonsterTransaction *)[self.dataController
    constructEmptyEntity:MonsterTransaction.entity];
  NSMutableDictionary *monsterInfo = m.mapable;
  mt.timestamp = [NSDate date];
  monsterInfo[TRANSACTION_TYPE_KEY] = TRANSACTION_TYPE_CREATE;
  mt.misc = [NSMutableDictionary dictToString:monsterInfo];
}

@end
