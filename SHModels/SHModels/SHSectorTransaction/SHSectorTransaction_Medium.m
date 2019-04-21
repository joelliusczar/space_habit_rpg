//
//  SectorTransaction_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHGlobal/SHConstants.h>
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHSectorTransaction.h"
#import "SHSectorTransaction_Medium.h"


@interface SHSectorTransaction_Medium ()
@property (strong,nonatomic) NSManagedObjectContext* context;

@end

@implementation SHSectorTransaction_Medium


+(instancetype)newWithContext:(NSManagedObjectContext*)context{
  SHSectorTransaction_Medium *instance = [[SHSectorTransaction_Medium alloc] init];
  instance.context = context;
  return instance;
}

-(void)addCreateTransaction:(SHSectorDTO *)z{
  NSMutableDictionary *sectorInfo = z.mapable;

  NSManagedObjectContext* context = self.context;
  [context performBlock:^{
    SHSectorTransaction *zt =(SHSectorTransaction *)[context newEntity:SHSectorTransaction.entity];
    zt.timestamp = [NSDate date];
    sectorInfo[SH_TRANSACTION_TYPE_KEY] = SH_TRANSACTION_TYPE_CREATE;
    zt.misc = [sectorInfo dictToString];
    NSError *error = nil;
    [context save:&error];
  }];
  
}

@end
