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
			testDaily.isEnabled = YES;
			SHDailyEvent *testEvent = (SHDailyEvent*)[self.testContext newEntity:SHDailyEvent.entity];
			testEvent.eventDatetime = dailyDate;
			testEvent.tzOffset = 0;
			testEvent.event_daily =  testDaily;
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
	#warning fix this test
	SHConfig.dayStartTime = 6 * SH_HOUR_IN_SECONDS;
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
	//remember: checkin date is not the same as activation date
	//may 5th is not an active day unless intervalSize is 1
	//because the last week was active
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




@end
