//
//  ZoneTransaction_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHGlobal/Constants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import "ZoneTransaction+CoreDataClass.h"
#import "ZoneTransaction_Medium.h"


@interface ZoneTransaction_Medium ()
@property (weak,nonatomic) NSObject<P_CoreData>* dataController;

@end

@implementation ZoneTransaction_Medium

@synthesize dataController = _dataController;

+(instancetype)newWithDataController:(NSObject<P_CoreData> *)dataController{
  ZoneTransaction_Medium *instance = [[ZoneTransaction_Medium alloc] init];
  instance.dataController = dataController;
  return instance;
}

-(void)addCreateTransaction:(Zone *)z{
  NSMutableDictionary *zoneInfo = z.mapable;
  ZoneTransaction *zt =(ZoneTransaction *)[self.dataController constructEmptyEntity:ZoneTransaction.entity];
  
  zt.timestamp = [NSDate date];
  zoneInfo[TRANSACTION_TYPE_KEY] = TRANSACTION_TYPE_CREATE;
  zt.misc = [NSMutableDictionary dictToString:zoneInfo];
}

@end
