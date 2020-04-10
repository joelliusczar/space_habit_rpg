//
//  SHDailyProcessor.m
//  SHModels
//
//  Created by Joel Pridgen on 4/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDailyProcessor.h"
#import "SHDaily.h"
#import "SHConfig.h"
@import SHCommon;

@implementation SHDailyProcessor

-(void)processAllDailies {
	NSDate *todayStart = SHConfig.userTodayStart;
	NSTimeInterval todayStartTS = todayStart.timeIntervalSince1970;
	NSTimeInterval lastProcessTS = SHConfig.lastProcessingDateTime.timeIntervalSince1970;
	if(todayStartTS > lastProcessTS) {
		[self.context performBlock:^{
			NSFetchRequest<SHDaily*> *fetchRequest = SHDaily.fetchRequest;
			
			fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isActive == 1 and activeFromDate < %@"
				" and activeToDate > %@", todayStart, todayStart];
			NSArray<SHDaily*> *results = (NSArray<SHDaily*>*)[self.context getItemsWithRequest: fetchRequest];
			[results enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(SHDaily *daily, NSUInteger idx, BOOL *stop){
				(void)idx; (void)stop;
				
			}];
		}];
	}
}

@end
