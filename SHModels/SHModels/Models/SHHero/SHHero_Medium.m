//
//  SHHero_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 8/31/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHero_Medium.h"
@import SHCommon;

@implementation SHHero_Medium


-(SHHero*)hero{
	NSAssert(self.context,@"hero_medium needs a context");
	__block SHHero *hero = nil;
	[self.context performBlockAndWait:^{
		NSFetchRequest *heroRequest = SHHero.fetchRequest;
		NSSortDescriptor *sortBy = [NSSortDescriptor
			sortDescriptorWithKey:@"lvl"
			ascending:YES];
		heroRequest.sortDescriptors = @[sortBy];
		NSError *error = nil;
		NSArray *results = [self.context executeFetchRequest:heroRequest error:&error];
		if(error){
			@throw [NSException dbException:error];
		}
		if(results.count == 1){
			hero = (SHHero*)results[0];
		}
		else if(results.count == 0) {
			hero = (SHHero*)[self.context newEntity:SHHero.entity];
			NSError *saveError = nil;
			[self.context save:&saveError];
			if(saveError){
				@throw [NSException dbException:error];
			}
		}
		else {
			@throw [NSException oddException];
		}
	}];
	return hero;
}

@end
