//
//  SHCoreData+CleanUp.m
//  TestCommon
//
//  Created by Joel Pridgen on 3/30/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHCoreData+CleanUp.h"

@implementation SHCoreData (CleanUp)

-(void)resetCoreData{
  [self.mainThreadContext reset];
  NSPersistentStore *ps = self.coordinator.persistentStores[0];
  NSError *err;
  [self.coordinator removePersistentStore:ps error:&err];
  [self forceInitialize:YES];
}

@end
