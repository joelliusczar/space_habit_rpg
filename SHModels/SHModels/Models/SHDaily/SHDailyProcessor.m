//
//  SHDailyProcessor.m
//  SHModels
//
//  Created by Joel Pridgen on 4/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

//#import "SHDailyProcessor.h"
//#import "SHDaily.h"
//#import "SHConfig.h"
//#import "SHDailyNextDueDateCalculator.h"
//@import SHCommon;
//@import SHUtils_C;
//
//@implementation SHDailyProcessor
//
//-(void)processAllDailies {
//	struct SHDatetime *todayStart = SHDaily.dateProvider.userTodayStart;
//	struct SHDatetime *lastProcess = SHConfig.lastProcessingDateTime;
//	SH_dtSetToTimeOfDay(lastProcess, SHConfig.dayStartTime);
//	
//	double todayTimestamp = 0;
//	SH_dtToTimestamp(todayStart, &todayTimestamp);
//	NSDate *todayNSDate = [NSDate dateWithTimeIntervalSince1970:todayTimestamp];
//	bool isGT = false;
//	SHErrorCode status = SH_NO_ERROR;
//	if((status = SH_isDateXAfterDateY(todayStart, lastProcess, &isGT)) != SH_NO_ERROR) {
//		SH_notifyOfError(status, "Process failed to check any of the dailies.");
//		goto fnExit;
//	}
//	if(isGT) {
//		[self.context performBlockAndWait:^{
//			__block NSUInteger penalty = 0;
//			dispatch_queue_t penaltyQueue = dispatch_queue_create("com.SpaceHabit.SHDailyProcessor", DISPATCH_QUEUE_SERIAL);
//			NSFetchRequest<SHDaily*> *fetchRequest = SHDaily.fetchRequest;
//			
//			fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isEnabled == 1 and  activeFromDate < %@"
//				" and activeToDate > %@", todayNSDate, todayNSDate];
//			NSArray<SHDaily*> *results = (NSArray<SHDaily*>*)[self.context getItemsWithRequest: fetchRequest];
//			[results enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(SHDaily *daily, NSUInteger idx, BOOL *stop){
//				(void)idx; (void)stop;
//				SHDailyNextDueDateCalculator *calculator = daily.calculator;
//
//				[daily updateDailyStatus];
//				
//				dispatch_sync(penaltyQueue, ^{
//					penalty += [calculator missedDays];
//				});
//			}];
//		}];
//	}
//	fnExit:
//		SH_freeSHDatetime(todayStart, 1);
//		SH_freeSHDatetime(lastProcess, 1);
//}
//
//@end
