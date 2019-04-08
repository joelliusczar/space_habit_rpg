//
//  MonsterTransaction_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHGlobal/Constants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "MonsterTransaction_Medium.h"

@interface MonsterTransaction_Medium ()
@property (weak,nonatomic) NSManagedObjectContext *context;
@end


@implementation MonsterTransaction_Medium


+(instancetype)newWithContext:(NSManagedObjectContext*)context{
  MonsterTransaction_Medium *instance = [[MonsterTransaction_Medium alloc] init];
  instance.context = context;
  return instance;
}
-(void)addCreateTransaction:(Monster *)m{
  NSMutableDictionary *monsterInfo = m.mapable;
  NSManagedObjectContext *context = self.context;
  [context performBlock:^{
    @autoreleasepool {
      MonsterTransaction *mt = (MonsterTransaction*)[context newEntity:MonsterTransaction.entity];
      mt.timestamp = [NSDate date];
      monsterInfo[TRANSACTION_TYPE_KEY] = TRANSACTION_TYPE_CREATE;
      mt.misc = [NSMutableDictionary dictToString:monsterInfo];
      NSError *error = nil;
      [context save:&error];
    }
  }];
  
}

@end
