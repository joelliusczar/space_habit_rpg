//
//  SHDailyActivator.m
//  SHModels
//
//  Created by Joel Pridgen on 8/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActivator.h"
#import "NSManagedObjectContext+SHModelHelper.h"
#import <SHCommon/NSException+SHCommonExceptions.h>

@implementation SHDailyActivator


-(instancetype)initWithContext:(NSManagedObjectContext *)context
  withObjectId:(SHObjectIDWrapper *)objectID
{
  if(self = [super init]){
    _context = context;
    _objectID = objectID;
  }
  return self;
}


-(void)activate{
  NSAssert(self.objectID,@"Gotta have that object id");
  NSAssert(self.context,@"Gotta have that context");
  NSManagedObjectID *objectId = self.objectID.objectID;
  [self.context performBlock:^{
    NSError *err = nil;
    SHDaily *daily = (SHDaily *)[self.context existingObjectWithID:objectId error:&err];
    if(err) {
      @throw [NSException dbException:err];
    }
    SHConfig *config = self.context.sh_globalConfig;
    
    NSDate *dayStart = [daily.lastActivationDateTime.dayStart
      timeAfterHours:config.dayStartHour minutes:0 seconds:0];
    NSDate *current = NSDate.date;
    if(dayStart.timeIntervalSince1970 < current.dayStart.timeIntervalSince1970) {
      daily.rollbackActivationDateTime = daily.lastActivationDateTime;
      daily.lastActivationDateTime = current;
      if(self.activationAction) self.activationAction(YES,self.objectID);
    }
    else {
      daily.lastActivationDateTime = daily.rollbackActivationDateTime;
      if(self.activationAction) self.activationAction(NO,self.objectID);
    }
    [self.context performBlock:^{
      NSError *saveErr = nil;
      [self.context save:&saveErr];
      if(saveErr) {
        @throw [NSException dbException:saveErr];
      }
    }];
  }];
}


@end
