//
//  NSManagedObjectContext+SHModelHelper.m
//  SHModels
//
//  Created by Joel Pridgen on 8/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSManagedObjectContext+SHModelHelper.h"
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHData/NSManagedObjectContext+Helper.h>


@interface NSManagedObjectContext (cachedIds)

@end

@implementation NSManagedObjectContext (SHModelHelper)


-(SHConfig*)sh_globalConfig{
  SHConfig *config = nil;
  NSFetchRequest *fetchRequest = SHConfig.fetchRequest;
  NSSortDescriptor *sortBy = [NSSortDescriptor sortDescriptorWithKey:@"createDateTime" ascending:YES];
  fetchRequest.sortDescriptors = @[sortBy];
  NSError *error = nil;
  NSArray *results = [self executeFetchRequest:fetchRequest error:&error];
  if(error){
    @throw [NSException dbException:error];
  }
  if(results.count > 0){
    NSAssert(results.count == 1,@"There should only be one config object");
    config = (SHConfig*)results[0];
  }
  else{
    config = (SHConfig*)[self newEntity:SHConfig.entity];
    [self performBlock:^{
      NSError *error = nil;
      if(![self save:&error]){
        @throw [NSException dbException:error];
      }
    }];
  }
  return config;
}

@end
