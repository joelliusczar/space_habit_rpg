//
//  SHMonsterTransaction_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHGlobal/SHConstants.h>
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHMonsterTransaction_Medium.h"
#import "SHMonsterTransaction+CoreDataClass.h"

@interface SHMonsterTransaction_Medium ()
@property (weak,nonatomic) NSManagedObjectContext *context;
@end


@implementation SHMonsterTransaction_Medium


+(instancetype)newWithContext:(NSManagedObjectContext*)context{
  SHMonsterTransaction_Medium *instance = [[SHMonsterTransaction_Medium alloc] init];
  instance.context = context;
  return instance;
}
-(void)addCreateTransaction:(SHMonsterDTO *)m{
  NSMutableDictionary *monsterInfo = m.mapable;
  NSManagedObjectContext *context = self.context;
  [context performBlock:^{
    @autoreleasepool {
      SHMonsterTransaction *mt = (SHMonsterTransaction*)[context newEntity:SHMonsterTransaction.entity];
      mt.timestamp = [NSDate date];
      monsterInfo[SH_TRANSACTION_TYPE_KEY] = SH_TRANSACTION_TYPE_CREATE;
      mt.misc = [monsterInfo dictToString];
      NSError *error = nil;
      [context save:&error];
    }
  }];
  
}

@end
