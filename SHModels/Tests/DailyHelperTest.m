//
//	DailyHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/4/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHFrequentCase.h"
#import "SHTestDateProvider.h"
@import SHSpecial_C;
@import SHCommon;

@import SHModels;
@import SHTestCommon;

@interface DailyHelperTest : SHFrequentCase
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
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578163600];
				a0++;
			}
			else if(i%9 == 0){
				//on
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578167200];
				a1++;
			}
			else if(i%8 == 0){
				//after
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578170800];
				a2++;
			}
			else if(i%7 == 0){
				//after next actual day
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578239200];
				a3++;
			}
			else if(i%6 == 0){
				//after after
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578260800];
				a4++;
			}
			else if(i%5 == 0){
				//before before
				dailyDate = [NSDate dateWithTimeIntervalSince1970:578088000];
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
//	SHConfig.dayStartTime = 6 * SH_HOUR_IN_SECONDS;
//
//	SHDaily_Medium *dm = [SHDaily_Medium newWithContext:self.testContext];
//	NSFetchedResultsController *results = [dm dailiesDataFetcher];
//	__block NSInteger unfinishedCount;
//	__block NSInteger finishedCount;
//	__block NSError *error = nil;
//	[self.testContext performBlockAndWait:^{
//		error = nil;
//		if(![results performFetch:&error]){
//			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
//
//		}
//		unfinishedCount = results.sections[0].numberOfObjects;
//		finishedCount = results.sections[1].numberOfObjects;
//	}];
//	XCTAssertNil(error);
//	XCTAssertEqual(unfinishedCount,31);
//	XCTAssertEqual(finishedCount,19);
//
//	[self.testContext performBlockAndWait:^{
//		//add save new item
//		SHDaily *d = (SHDaily*)[self.testContext newEntity:SHDaily.entity];
//		d.dailyName = @"addedDaily";
//		[self.testContext insertObject:d];
//		//after insert, before fetch
//		unfinishedCount = results.sections[0].numberOfObjects;
//		finishedCount = results.sections[1].numberOfObjects;
//	}];
//
//	XCTAssertEqual(unfinishedCount,31);
//	XCTAssertEqual(finishedCount,19);
//
//	[self.testContext performBlockAndWait:^{
//		error = nil;
//		if(![results performFetch:&error]){
//			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
//		}
//		//after insert, after fetch, before save
//		unfinishedCount = results.sections[0].numberOfObjects;
//		finishedCount = results.sections[1].numberOfObjects;
//		//saving is unecessary to be included in fetch results
//	}];
//	XCTAssertNil(error);
//	XCTAssertEqual(unfinishedCount,32);
//	XCTAssertEqual(finishedCount,19);
//
//	NSManagedObjectContext *bgContext2 = [self.dc newBackgroundContext];
//// keeping this here to help mark what the test was originally about
////	 [self.dc beginUsingTemporaryContext];
//
//	[bgContext2 performBlockAndWait:^{
//		SHDaily *d2 = (SHDaily*)[bgContext2 newEntity:SHDaily.entity];
//		d2.dailyName = @"addedDaily2";
//		[bgContext2 insertObject:d2];
//		error = nil;
//		[bgContext2 save:&error];
//	}];
//
////	[self.dc endUsingTemporaryContext];
//	[self.testContext performBlockAndWait:^{
//		error = nil;
//		if(![results performFetch:&error]){
//			NSLog(@"Error fetching data: %@", error.localizedFailureReason);
//		}
//		unfinishedCount = results.sections[0].numberOfObjects;
//		finishedCount = results.sections[1].numberOfObjects;
//	}];
//	XCTAssertNil(error);
//	XCTAssertEqual(unfinishedCount,33);
//	XCTAssertEqual(finishedCount,19);
}


-(void)testDaysUntilDue_WEEKLY{
	/*
	#calendar 2020
		FEB
			SU	MO	TU	WE	TH	FR	SA
															01
			02	03	04	05	06	07	08
			09	10	11	12	13	14	15
			16	17	18	19	20	21	22
			23	24	25	26	27	28	29
		MAR
			01	02	03	04	05	06	07
			08	09	10	11	12	13	14
			15	16	17	18	19	20	21
			22	23	24	25	26	27	28
			29	30	31
		APR
			 	 	 				01	02	03	04
			05	06	07	08	09	10	11
			12	13	14	15	16	17	18
			19	20	21	22	23	24	25
			26	27	28	29	30
		MAY
													01	02
			03	04	05	06	07	08	09 *
			10	11	12	13	14	15	16 1
			17	18	19	20	21	22	23 1	2
			24	25	26	27	28	29	30 1		3
			31
		JUN
					01	02	03	04	05	06 1	2
			07	08	09	10	11	12	13 1
			14	15	16	17	18	19	20 1	2 3
			21	22	23	24	25	26	27 1						7
			28	29	30
		JUL
									01	02	03	04 1	2
			05	06	07	08	09	10	11 1		3
			12	13	14	15	16	17	18 1	2
			19	20	21	22	23	24	25 1
			26	27	28	29	30	31		 1	2 3
		AUG
															01 1
			02	03	04	05	06	07	08 1	2	3
			09	10	11	12	13	14	15 1						7
			16	17	18	19	20	21	22 1
			23	24	25	26	27	28	29 1
			30	31
		
	*/
	[self resetDb];
	SHTestDateProvider *dateProvider = [[SHTestDateProvider alloc] init];
	dateProvider.testTzOffset = -18000;
	dateProvider.testDate = [NSDate dateWithTimeIntervalSince1970:1588824000];
	__block NSInteger days1;
	__block NSInteger days2;
	__block NSInteger days3;
	__block SHObjectIDWrapper *objectID = nil;
	NSManagedObjectContext *tc = [self.dc newBackgroundContext];
	tc.retainsRegisteredObjects = YES;
	[tc performBlockAndWait:^{
		SHDaily *d = (SHDaily*)[tc newEntity:SHDaily.entity];
		d.dateProvider = dateProvider;
		d.intervalType = SH_WEEKLY_INTERVAL;
		//if the intervalSize is one, it should always result in being 0 days until Daily is due
		d.activeDaysContainer.weeklyActiveDays.intervalSize = 1;
		d.lastActivationDateTime = [NSDate dateWithTimeIntervalSince1970:1588737600];
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
	NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1589083200];
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
