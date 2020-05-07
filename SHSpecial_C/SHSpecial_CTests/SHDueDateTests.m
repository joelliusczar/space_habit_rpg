//
//  SHDueDateTests.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <stdbool.h>
@import SHSpecial_C;

@interface SHDueDateTests : XCTestCase

@end

@implementation SHDueDateTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testBuildWeek{
	
	struct SHWeekIntervalPointList results;
	memset(&results, 0, sizeof(struct SHWeekIntervalPointList));
	results.days[0].isDayActive = true;
	
	SH_refreshWeek(&results,1);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,7);
	XCTAssertEqual(results.days[0].backrange,7);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,false);
	XCTAssertEqual(results.days[1].forrange,6);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,5);
	XCTAssertEqual(results.days[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,false);
	XCTAssertEqual(results.days[3].forrange,4);
	XCTAssertEqual(results.days[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,3);
	XCTAssertEqual(results.days[4].backrange,4);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,2);
	XCTAssertEqual(results.days[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,1);
	XCTAssertEqual(results.days[6].backrange,6);
	
	
	SH_refreshWeek(&results,4);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,28);
	XCTAssertEqual(results.days[0].backrange,28);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,false);
	XCTAssertEqual(results.days[1].forrange,27);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,26);
	XCTAssertEqual(results.days[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,false);
	XCTAssertEqual(results.days[3].forrange,25);
	XCTAssertEqual(results.days[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,24);
	XCTAssertEqual(results.days[4].backrange,4);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,23);
	XCTAssertEqual(results.days[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,22);
	XCTAssertEqual(results.days[6].backrange,6);
	
	memset(&results, 0, sizeof(struct SHWeekIntervalPointList));
	results.days[1].isDayActive = true; //monday
	results.days[3].isDayActive = true; //wednesday
	

	SH_refreshWeek(&results,1);
	
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,false);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,4);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,2);
	XCTAssertEqual(results.days[1].backrange,5);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,5);
	XCTAssertEqual(results.days[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,4);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,3);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,2);
	XCTAssertEqual(results.days[6].backrange,3);
	
	SH_refreshWeek(&results,7);
	
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,false);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,46);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,2);
	XCTAssertEqual(results.days[1].backrange,47);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,47);
	XCTAssertEqual(results.days[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,46);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,45);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,44);
	XCTAssertEqual(results.days[6].backrange,3);
	
	
	for(int32_t i = 0;i<SH_DAYS_IN_WEEK;i++){
		results.days[i].isDayActive = true;
	}
	SH_refreshWeek(&results,1);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,1);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,1);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,true);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,1);
	XCTAssertEqual(results.days[6].backrange,1);
	
	SH_refreshWeek(&results,3);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,15);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,1);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,true);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,15);
	XCTAssertEqual(results.days[6].backrange,1);
	
	
	results.days[4].isDayActive = false;
	
	SH_refreshWeek(&results,3);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,15);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,2);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,15);
	XCTAssertEqual(results.days[6].backrange,1);
}

@end
