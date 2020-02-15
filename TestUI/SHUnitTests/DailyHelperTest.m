//
//	DailyHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/4/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+testReplace.h"
#import <SHSpecial_C/SHDaily_C.h>
#import <SHSpecial_C/SHRateValueItem.h>
@import SHCommon;

@import SHModels;
@import SHTestCommon;

@interface DailyHelperTest : FrequentCase
@property (strong,nonatomic) NSManagedObjectContext *testContext;
@end



@implementation DailyHelperTest


-(void)addTestDailies{
	__block NSError *error = nil;
	[self.testContext performBlockAndWait:^{
		int a0=0,a1=0,a2=0,a3=0,a4=0,a5=0;
		for(int i = 0;i<50;i++){
			SHDaily *testDaily = (SHDaily*)[self.testContext newEntity:SHDaily.entity];
			testDaily.dailyName = [NSString stringWithFormat:@"daily %d",i];
			[self.testContext insertObject:testDaily];
			NSDate *dailyDate = nil;
			if(i%10 == 0){
				//before
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:5 minute:0 second:0];
				a0++;
			}
			else if(i%9 == 0){
				//on
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:6 minute:0 second:0];
				a1++;
			}
			else if(i%8 == 0){
				//after
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:7 minute:0 second:0];
				a2++;
			}
			else if(i%7 == 0){
				//after next actual day
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:2 minute:0 second:0];
				a3++;
			}
			else if(i%6 == 0){
				//after after
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:8 minute:0 second:0];
				a4++;
			}
			else if(i%5 == 0){
				//before before
				dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:26 hour:8 minute:0 second:0];
				a5++;
			}
			testDaily.lastActivationDateTime = dailyDate;
			testDaily.isActive = YES;
		}
		error = nil;
		[self.testContext save:&error];
		
		
		//sanity check
		XCTAssertEqual((a0+a1+a2+a3+a4+a5), 27);
	}];
	XCTAssertNil(error);
}

-(void)setUp {
	[super setUp];
	self.testContext = [self.dc newBackgroundContext];
	[self addTestDailies];
}

-(void)tearDown {
	[super tearDown];
}

-(void)testGetAnything{
	NSManagedObjectContext *context = self.testContext;
	__block NSError *error = nil;
	__block NSUInteger recordCount;
	[self.testContext performBlockAndWait:^{
		NSFetchRequest<SHDaily*> *request = SHDaily.fetchRequest;
		request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"urgency" ascending:NO]];
		NSFetchedResultsController* resultsController = [context getItemFetcher:request];
		if(![resultsController performFetch:&error]){
			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
		}
		recordCount = resultsController.fetchedObjects.count;
	}];
	XCTAssertNil(error);
	XCTAssertEqual(recordCount,50);
}

-(void)testRetrieveUnfinishedDailies{
	[self.testContext performBlockAndWait:^{

		SHConfig *config = [[SHConfig alloc] init];
		config.dayStartTime = 6 * SH_HOUR_IN_SECONDS;
		[self.testContext save:nil];
	}];
	testTodayReplacement = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:6 minute:0 second:0];
	[NSDate swizzleThatShit];
	SHDaily_Medium *dm = [SHDaily_Medium newWithContext:self.testContext];
	NSFetchedResultsController *results = [dm dailiesDataFetcher];
	__block NSInteger unfinishedCount;
	__block NSInteger finishedCount;
	__block NSError *error = nil;
	[self.testContext performBlockAndWait:^{
		error = nil;
		if(![results performFetch:&error]){
			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
			
		}
		unfinishedCount = results.sections[0].numberOfObjects;
		finishedCount = results.sections[1].numberOfObjects;
	}];
	XCTAssertNil(error);
	XCTAssertEqual(unfinishedCount,31);
	XCTAssertEqual(finishedCount,19);
	
	[self.testContext performBlockAndWait:^{
		//add save new item
		SHDaily *d = (SHDaily*)[self.testContext newEntity:SHDaily.entity];
		d.dailyName = @"addedDaily";
		[self.testContext insertObject:d];
		//after insert, before fetch
		unfinishedCount = results.sections[0].numberOfObjects;
		finishedCount = results.sections[1].numberOfObjects;
	}];
	
	XCTAssertEqual(unfinishedCount,31);
	XCTAssertEqual(finishedCount,19);
	
	[self.testContext performBlockAndWait:^{
		error = nil;
		if(![results performFetch:&error]){
			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
		}
		//after insert, after fetch, before save
		unfinishedCount = results.sections[0].numberOfObjects;
		finishedCount = results.sections[1].numberOfObjects;
		//saving is unecessary to be included in fetch results
	}];
	XCTAssertNil(error);
	XCTAssertEqual(unfinishedCount,32);
	XCTAssertEqual(finishedCount,19);
	
	NSManagedObjectContext *bgContext2 = [self.dc newBackgroundContext];
// keeping this here to help mark what the test was originally about
//	 [self.dc beginUsingTemporaryContext];
	
	[bgContext2 performBlockAndWait:^{
		SHDaily *d2 = (SHDaily*)[bgContext2 newEntity:SHDaily.entity];
		d2.dailyName = @"addedDaily2";
		[bgContext2 insertObject:d2];
		error = nil;
		[bgContext2 save:&error];
	}];
	
//	[self.dc endUsingTemporaryContext];
	[self.testContext performBlockAndWait:^{
		error = nil;
		if(![results performFetch:&error]){
			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
		}
		unfinishedCount = results.sections[0].numberOfObjects;
		finishedCount = results.sections[1].numberOfObjects;
	}];
	XCTAssertNil(error);
	XCTAssertEqual(unfinishedCount,33);
	XCTAssertEqual(finishedCount,19);
}

#warning maybe put back
//-(void)testCalculateNextDueTime{
//	NSDate *checkinDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:11 minute:15 second:30 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
//	//is due next day at 12AM
//	NSDate *nextDueTime = [Daily calculateNextDueTime:checkinDate withRate:1 andDayStart:0];
//	XCTAssertEqual(nextDueTime.timeIntervalSince1970,578203200);
//	//is due next day at 6AM
//	nextDueTime = [Daily calculateNextDueTime:checkinDate withRate:1 andDayStart:6];
//	XCTAssertEqual(nextDueTime.timeIntervalSince1970,578224800);
//	//2 days later at 2PM
//	nextDueTime = [Daily calculateNextDueTime:checkinDate withRate:2 andDayStart:14];
//	XCTAssertEqual(nextDueTime.timeIntervalSince1970,578340000);
//}

-(void)testDaysUntilDue_WEEKLY{
	[self resetDb];
	SHTestDateProvider *dateProvider = [[SHTestDateProvider alloc] init];
	dateProvider.testDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:9 minute:24 second:11
		timeZone: [NSTimeZone timeZoneForSecondsFromGMT: -18000]];
	__block NSInteger days1;
	__block NSInteger days2;
	__block NSInteger days3;
	__block SHObjectIDWrapper *objectID = nil;
	NSManagedObjectContext *tc = [self.dc newBackgroundContext];
	tc.retainsRegisteredObjects = YES;
	[tc performBlockAndWait:^{
		SHDaily *d = (SHDaily*)[tc newEntity:SHDaily.entity];
		d.dateProvider = dateProvider;
		d.rateType = SH_WEEKLY_RATE;
		//if the rate is one, it should always result in being 0 days until Daily is due
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 1;
		d.lastActivationDateTime = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:24 second:11
			timeZone: [NSTimeZone timeZoneForSecondsFromGMT:-18000]];
		days1 = d.daysUntilDue;
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 2;
		days2 = d.daysUntilDue;
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 7;
		days3 = d.daysUntilDue;
		[tc save:nil];
		objectID = [[SHObjectIDWrapper alloc] initWithManagedObject:d];
	}];
	
	XCTAssertEqual(days1,0);
	XCTAssertEqual(days2,0);
	XCTAssertEqual(days3,0);
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:9 minute:24 second:11
	timeZone: [NSTimeZone timeZoneForSecondsFromGMT: -18000]];
	dateProvider.testDate = testDate;
	[tc performBlockAndWait:^{
		NSError *error;
		SHDaily *d = (SHDaily*)[tc getEntityOrNil:objectID withError:&error];
		d.dateProvider = dateProvider;
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 1;
		days1 = d.daysUntilDue;
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 2;
		days2 = d.daysUntilDue;
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 7;
		days3 = d.daysUntilDue;
	}];
	XCTAssertEqual(days1,0);
	XCTAssertEqual(days2,7);
	XCTAssertEqual(days3,42);
}


-(void)testBuildWeek{
	BOOL testSet[] = {1,0,0,0,0,0,0};//sunday
	
	SHRateValueItem results[7];
	memset(results,0,sizeof(SHRateValueItem) * 7);
	
	shBuildWeek(testSet,1,results);
	//sunday
	XCTAssertEqual(results[0].isDayActive,YES);
	XCTAssertEqual(results[0].forrange,7);
	XCTAssertEqual(results[0].backrange,7);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,NO);
	XCTAssertEqual(results[1].forrange,6);
	XCTAssertEqual(results[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,NO);
	XCTAssertEqual(results[2].forrange,5);
	XCTAssertEqual(results[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,NO);
	XCTAssertEqual(results[3].forrange,4);
	XCTAssertEqual(results[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,NO);
	XCTAssertEqual(results[4].forrange,3);
	XCTAssertEqual(results[4].backrange,4);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,NO);
	XCTAssertEqual(results[5].forrange,2);
	XCTAssertEqual(results[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,NO);
	XCTAssertEqual(results[6].forrange,1);
	XCTAssertEqual(results[6].backrange,6);
	
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,4,results);
	//sunday
	XCTAssertEqual(results[0].isDayActive,YES);
	XCTAssertEqual(results[0].forrange,28);
	XCTAssertEqual(results[0].backrange,28);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,NO);
	XCTAssertEqual(results[1].forrange,27);
	XCTAssertEqual(results[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,NO);
	XCTAssertEqual(results[2].forrange,26);
	XCTAssertEqual(results[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,NO);
	XCTAssertEqual(results[3].forrange,25);
	XCTAssertEqual(results[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,NO);
	XCTAssertEqual(results[4].forrange,24);
	XCTAssertEqual(results[4].backrange,4);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,NO);
	XCTAssertEqual(results[5].forrange,23);
	XCTAssertEqual(results[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,NO);
	XCTAssertEqual(results[6].forrange,22);
	XCTAssertEqual(results[6].backrange,6);
	
	testSet[0] = NO;
	testSet[1] = YES; //monday
	testSet[3] = YES; //wednesday
	
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,1,results);
	
	//sunday
	XCTAssertEqual(results[0].isDayActive,NO);
	XCTAssertEqual(results[0].forrange,1);
	XCTAssertEqual(results[0].backrange,4);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,YES);
	XCTAssertEqual(results[1].forrange,2);
	XCTAssertEqual(results[1].backrange,5);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,NO);
	XCTAssertEqual(results[2].forrange,1);
	XCTAssertEqual(results[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,YES);
	XCTAssertEqual(results[3].forrange,5);
	XCTAssertEqual(results[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,NO);
	XCTAssertEqual(results[4].forrange,4);
	XCTAssertEqual(results[4].backrange,1);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,NO);
	XCTAssertEqual(results[5].forrange,3);
	XCTAssertEqual(results[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,NO);
	XCTAssertEqual(results[6].forrange,2);
	XCTAssertEqual(results[6].backrange,3);
	
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,7,results);
	
	//sunday
	XCTAssertEqual(results[0].isDayActive,NO);
	XCTAssertEqual(results[0].forrange,1);
	XCTAssertEqual(results[0].backrange,46);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,YES);
	XCTAssertEqual(results[1].forrange,2);
	XCTAssertEqual(results[1].backrange,47);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,NO);
	XCTAssertEqual(results[2].forrange,1);
	XCTAssertEqual(results[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,YES);
	XCTAssertEqual(results[3].forrange,47);
	XCTAssertEqual(results[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,NO);
	XCTAssertEqual(results[4].forrange,46);
	XCTAssertEqual(results[4].backrange,1);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,NO);
	XCTAssertEqual(results[5].forrange,45);
	XCTAssertEqual(results[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,NO);
	XCTAssertEqual(results[6].forrange,44);
	XCTAssertEqual(results[6].backrange,3);
	
	for(int32_t i = 0;i<SH_DAYS_IN_WEEK;i++){
		testSet[i] = YES;
	}
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,1,results);
	//sunday
	XCTAssertEqual(results[0].isDayActive,YES);
	XCTAssertEqual(results[0].forrange,1);
	XCTAssertEqual(results[0].backrange,1);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,YES);
	XCTAssertEqual(results[1].forrange,1);
	XCTAssertEqual(results[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,YES);
	XCTAssertEqual(results[2].forrange,1);
	XCTAssertEqual(results[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,YES);
	XCTAssertEqual(results[3].forrange,1);
	XCTAssertEqual(results[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,YES);
	XCTAssertEqual(results[4].forrange,1);
	XCTAssertEqual(results[4].backrange,1);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,YES);
	XCTAssertEqual(results[5].forrange,1);
	XCTAssertEqual(results[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,YES);
	XCTAssertEqual(results[6].forrange,1);
	XCTAssertEqual(results[6].backrange,1);
	
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,3,results);
	//sunday
	XCTAssertEqual(results[0].isDayActive,YES);
	XCTAssertEqual(results[0].forrange,1);
	XCTAssertEqual(results[0].backrange,15);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,YES);
	XCTAssertEqual(results[1].forrange,1);
	XCTAssertEqual(results[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,YES);
	XCTAssertEqual(results[2].forrange,1);
	XCTAssertEqual(results[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,YES);
	XCTAssertEqual(results[3].forrange,1);
	XCTAssertEqual(results[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,YES);
	XCTAssertEqual(results[4].forrange,1);
	XCTAssertEqual(results[4].backrange,1);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,YES);
	XCTAssertEqual(results[5].forrange,1);
	XCTAssertEqual(results[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,YES);
	XCTAssertEqual(results[6].forrange,15);
	XCTAssertEqual(results[6].backrange,1);
	
	testSet[4] = NO;
	memset(results,0,sizeof(SHRateValueItem) * 7);
	shBuildWeek(testSet,3,results);
	//sunday
	XCTAssertEqual(results[0].isDayActive,YES);
	XCTAssertEqual(results[0].forrange,1);
	XCTAssertEqual(results[0].backrange,15);
	
	//monday
	XCTAssertEqual(results[1].isDayActive,YES);
	XCTAssertEqual(results[1].forrange,1);
	XCTAssertEqual(results[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results[2].isDayActive,YES);
	XCTAssertEqual(results[2].forrange,1);
	XCTAssertEqual(results[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results[3].isDayActive,YES);
	XCTAssertEqual(results[3].forrange,2);
	XCTAssertEqual(results[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results[4].isDayActive,NO);
	XCTAssertEqual(results[4].forrange,1);
	XCTAssertEqual(results[4].backrange,1);
	
	//friday
	XCTAssertEqual(results[5].isDayActive,YES);
	XCTAssertEqual(results[5].forrange,1);
	XCTAssertEqual(results[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results[6].isDayActive,YES);
	XCTAssertEqual(results[6].forrange,15);
	XCTAssertEqual(results[6].backrange,1);
}

#warning TODO: test hourly difference and think about the case where the user changes their start up time
//I don't think the scaler stuff comes into play yet
#warning TODO: there's some test I want to do to test against going out of range past 'Base'
-(void)testPreviousDate{
	int64_t btw;
	SHRateValueItem week[7];
	BOOL testSet[] = {0,1,0,1,0,0,0};//monday, wednesday
	int weekScaler = 3;
	int32_t dayStartHour = 0;
	shBuildWeek(testSet, weekScaler, week);
	SHDatetime base = newSHDatetime_datetime2(2018,1,7,0,0,0,0);
	SHDatetime lastDueDate;
	SHDatetime checkinDate;
	SHDatetime expectedDate;
	SHDatetime result;
	SHError err;
	shPrepareSHError(&err);
	shTryAddDaysToDt(&base,1,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler,dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,66,0,&expectedDate,&err);

	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,65,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler,dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expectedDate,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,66,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,64,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,45,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,72,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,66,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,5,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,3,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,2,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,1,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,24,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,22,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,22,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,3,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,50,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,45,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet,weekScaler,week);
	base.year = 2018;
	base.month = 1;
	base.day = 7;
	
	shTryAddDaysToDt(&base,1,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,80,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,65,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expectedDate,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,66,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,64,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,59,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,72,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,5,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,3,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,2,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,1,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,24,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,22,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,22,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,17,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	bool testSet2[] = {0,0,0,0,0,1,0};
	weekScaler = 3;
	shBuildWeek(testSet2,weekScaler,week);
	
	shTryAddDaysToDt(&base,5,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,68,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,6,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,5,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet2,weekScaler,week);
	
	shTryAddDaysToDt(&base,5,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,75,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,6,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,5,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	bool testSet3[] = {1,0,0,0,0,0,0};
	weekScaler = 3;
	shBuildWeek(testSet3,weekScaler,week);
	
	lastDueDate = base;
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,63,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,62,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,42,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,1,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,0,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet3,weekScaler,week);
	
	lastDueDate = base;
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,77,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,62,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,56,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,1,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,0,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,0,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	bool testSet4[] = {0,0,0,0,0,0,1};
	weekScaler = 3;
	shBuildWeek(testSet4,weekScaler,week);
	
	shTryAddDaysToDt(&base,6,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,69,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,13,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,20,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,26,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,34,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,27,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,68,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,48,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet4,weekScaler,week);
	
	shTryAddDaysToDt(&base,6,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,76,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,13,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,20,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,13,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,26,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,20,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,34,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,27,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,68,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,62,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	bool testSet5[] = {1,1,1,1,1,1,1};
	weekScaler = 3;
	shBuildWeek(testSet5,weekScaler,week);
	
	shTryAddDaysToDt(&base,6,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,69,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,13,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,20,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,34,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,27,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,68,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,67,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,6,0,&checkinDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 2;
	shTryAddDaysToDt(&base,3,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,4,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,3,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet5,weekScaler,week);
	
	shTryAddDaysToDt(&base,6,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,80,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,13,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,12,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,20,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,19,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,6,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,34,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,33,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	shTryAddDaysToDt(&base,68,0,&checkinDate,&err);
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,67,0,&expectedDate,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	
	
	bool testSet6[] = {1,1,0,0,0,0,0};
	weekScaler = 3;
	shBuildWeek(testSet6,weekScaler,week);
	
	shTryAddDaysToDt(&base,1,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err); //march 29
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,1,0,&expectedDate,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expectedDate,&err));
	
	weekScaler = 2;
	bool testSet7[] = {1,1,1,1,1,1,1};
	shBuildWeek(testSet7,weekScaler,week);
	lastDueDate.year = 1988;
	lastDueDate.month = 4;
	lastDueDate.day = 27;
	lastDueDate.hour = 0;
	lastDueDate.minute = 0;
	lastDueDate.second = 0;
	
	checkinDate.year = 1988;
	checkinDate.month = 4;
	checkinDate.day = 28;
	checkinDate.hour = 0;
	checkinDate.minute = 0;
	checkinDate.second = 0;
	memset(&result,0,sizeof(SHDatetime));
	shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	XCTAssertTrue(err.code == SH_NO_ERROR);
	
	
	lastDueDate.year = 1988;
	lastDueDate.month = 4;
	lastDueDate.day = 27;
	lastDueDate.hour = 18;
	lastDueDate.minute = 24;
	lastDueDate.second = 11;
	
	checkinDate.year = 1988;
	checkinDate.month = 4;
	checkinDate.day = 28;
	checkinDate.hour = 14;
	checkinDate.minute = 24;
	checkinDate.second = 11;
	memset(&result,0,sizeof(SHDatetime));
	shPreviousDueDateWithPreparedInputs_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler,
		dayStartHour,&result,&err);
	XCTAssertTrue(err.code == SH_NO_ERROR);
	
}

-(void)testDueDates2{
	SHRateValueItem week[7];
	BOOL testSet[] = {0,1,0,0,0,0,0};
	int weekScaler = 1;
	int32_t dayStartHour = 0;
	shBuildWeek(testSet, weekScaler, week);
	SHDatetime base = newSHDatetime_datetime2(1978,1,1,0,0,0,0);
	SHDatetime lastDueDate;
	SHDatetime checkinDate;
	SHDatetime expected;
	SHDatetime result;
	SHError err;
	shPrepareSHError(&err);
	shTryAddDaysToDt(&base,0,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,1,0,&checkinDate,&err);
	shTryAddDaysToDt(&base,0,0,&expected,&err);
	bool isSuccess = shPreviousDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	XCTAssertEqual(isSuccess,false);
	BOOL testSet2[] = {1,0,0,0,0,0,0};
	base.year = 2006;
	shBuildWeek(testSet2, weekScaler, week);
	shTryAddDaysToDt(&base,7,0,&checkinDate,&err);
	shTryAddDaysToDt(&base,0,0,&lastDueDate,&err);
	isSuccess = shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	XCTAssertEqual(isSuccess,true);
	
	shBuildWeek(testSet2, 2, week);
	shTryAddDaysToDt(&base,0,0,&checkinDate,&err);
	shTryAddDaysToDt(&base,0,0,&lastDueDate,&err);
	isSuccess = shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	XCTAssertEqual(isSuccess,true);
}

-(void)testNextDueDateWeekly{
	int64_t btw;
	SHRateValueItem week[7];
	BOOL testSet0[] = {0,1,0,1,0,0,0};
	int weekScaler = 3;
	int32_t dayStartHour = 0;
	shBuildWeek(testSet0, weekScaler, week);
	SHDatetime base = newDatetime_date(2018,1,7);
	SHDatetime lastDueDate;
	SHDatetime checkinDate;
	SHDatetime expected;
	SHDatetime result;
	SHError err;
	shPrepareSHError(&err);
	shTryAddDaysToDt(&base,1,0,&lastDueDate,&err);
	shTryAddDaysToDt(&base,81,0,&checkinDate,&err); //march 29
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,85,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,65,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,66,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,63,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,62,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,50,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,46,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,66,0,&checkinDate,&err);
	bool isSuccess = shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	(void)isSuccess;
	shTryAddDaysToDt(&base,66,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,64,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	btw = shDateDiffDays(&result,&base,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	weekScaler = 1;
	shBuildWeek(testSet0, weekScaler, week);
	
	shTryAddDaysToDt(&base,62,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,63,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,64,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,64,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,65,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,66,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,66,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,66,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,67,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,68,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,69,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,70,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,71,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,71,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,72,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,73,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,73,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,73,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	shTryAddDaysToDt(&base,74,0,&checkinDate,&err);
	shNextDueDate_WEEKLY(&lastDueDate,&checkinDate,week,weekScaler, dayStartHour,&result,&err);
	shTryAddDaysToDt(&base,78,0,&expected,&err);
	XCTAssertEqual(shDtToTimestamp(&result,&err),shDtToTimestamp(&expected,&err));
	
	BOOL testSet1[] = {1,0,0,0,0,0,0};
	weekScaler = 3;
	shBuildWeek(testSet1, weekScaler, week);
	
	
}



@end
