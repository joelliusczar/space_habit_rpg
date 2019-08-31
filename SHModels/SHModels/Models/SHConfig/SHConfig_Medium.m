//
//  SHConfig_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 8/31/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHConfig_Medium.h"
#import <SHCommon/NSException+SHCommonExceptions.h>

@implementation SHConfig_Medium


-(SHConfig*)globalConfig{
	NSAssert(self.context,@"We need the config class context to be there");
	SHConfig *config = nil;
	NSFetchRequest *fetchRequest = SHConfig.fetchRequest;
	NSSortDescriptor *sortBy = [NSSortDescriptor sortDescriptorWithKey:@"createDateTime" ascending:YES];
	fetchRequest.sortDescriptors = @[sortBy];
	NSError *error = nil;
	NSArray *results = [self.context executeFetchRequest:fetchRequest error:&error];
	if(error){
		@throw [NSException dbException:error];
	}
	if(results.count > 0){
		NSAssert(results.count == 1,@"There should only be one config object");
		config = (SHConfig*)results[0];
	}
	else{
		config = (SHConfig*)[self.context newEntity:SHConfig.entity];
		[self.context performBlock:^{
			NSError *error = nil;
			if(![self.context save:&error]){
				@throw [NSException dbException:error];
			}
		}];
	}
	return config;
}


@end
