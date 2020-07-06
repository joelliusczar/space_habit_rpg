//
//  SHTestDbFunctions.m
//  SHModelsTests
//
//  Created by Joel Pridgen on 7/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHDaily_struct.h"
#import "SHHabitBase.h"
#import "SHHabit_dbCalls.h"
#import "SHDbSetup.h"
#import "SHDaily_dbCalls.h"
#import <SHUtils_C/SHErrorHandling.h>
#import <stdio.h>
#import <stdlib.h>
#import <sqlite3.h>

@interface SHTestDbFunctions : XCTestCase
@property (assign, nonatomic) sqlite3 *db;
@end

@implementation SHTestDbFunctions

- (void)setUp {
	self.db = NULL;
	NSString *dbPath = [NSString stringWithFormat:@"%@/Documents/sh_db/testDb.sqlite", NSHomeDirectory()];
	SHErrorCode status = SH_openDb(&self->_db, dbPath.UTF8String);
	status = SH_createTables(self.db);
	status = SH_addDbFunctions(self.db, NULL);
}

- (void)tearDown {
	sqlite3_close(self.db);
	NSString *dbPath = [NSString stringWithFormat:@"%@/Documents/sh_db/testDb.sqlite", NSHomeDirectory()];
	NSFileManager *fm = NSFileManager.defaultManager;
	[fm removeItemAtPath:dbPath error:nil];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testSelectSavedUseDate {
	SHErrorCode status = SH_NO_ERROR;
	struct SHHabitBase habit = {
			.name = "testSelectSavedUseDate",
			.lastUpdated = 1593791958,
			.tzOffsetLastUpdateDateTime = -14400,
		};
	int64_t pk = -1;
	status = SH_insertHabit_Daily(self.db, &habit, &pk);
	char *sql = "SELECT "
		"pk, "
		"name, "
		"SH_selectSavedUseDateUTC(lastActivationDateTime, "
			"tzOffsetLastActivationDateTime, "
			"activeFromDateTime, "
			"tzOffsetLastUpdateDateTime,"
			"lastUpdated, "
			"activeFromHasPriority, "
			"lastUpdateHasPriority) AS SavedUseDate "
		"FROM Dailies";
		sqlite3_stmt *stmt = NULL;
		int32_t sqlStatus = 0;
		sqlStatus = sqlite3_prepare_v2(self.db, sql, -1, &stmt, 0);
		sqlStatus = sqlite3_step(stmt);
		int32_t resultPk = sqlite3_column_int(stmt, 0);
		double resultTimestamp = sqlite3_column_double(stmt, 2);
		XCTAssertEqual(resultPk, 1);
		XCTAssertEqual(resultTimestamp, 1593806358);
	struct SHDaily daily = {0};
		status = SH_fetchSingleDaily(self.db, resultPk, &daily);
		XCTAssertEqual(status, SH_NO_ERROR);
		
		sqlite3_reset(stmt);
		
		double lastActivationDateTime = 1578009600;
		daily.lastActivationDateTime = &lastActivationDateTime;
		daily.tzOffsetLastActivationDateTime = -14400;
		status = SH_updateDaily(self.db, &daily);
		sqlStatus = sqlite3_step(stmt);
		resultPk = sqlite3_column_int(stmt, 0);
		resultTimestamp = sqlite3_column_double(stmt, 2);
		XCTAssertEqual(resultPk, 1);
		XCTAssertEqual(resultTimestamp, lastActivationDateTime + 14400);
		
		
		sqlite3_finalize(stmt);
		
}


-(void)testFetchAfterEmpty {
	SHErrorCode status = SH_NO_ERROR;
	struct SHHabitBase habit = {
			.name = "testFetchAfterEmpty",
			.lastUpdated = 1593791958,
			.tzOffsetLastUpdateDateTime = -14400,
		};
	int64_t pk = -1;
	status = SH_insertHabit_Daily(self.db, &habit, &pk);
	char *sql = "SELECT "
		"* "
		"FROM Dailies";
		sqlite3_stmt *stmt = NULL;
		int32_t sqlStatus = 0;
		sqlStatus = sqlite3_prepare_v2(self.db, sql, -1, &stmt, 0);
		sqlStatus = sqlite3_step(stmt);
		const unsigned char *name = sqlite3_column_text(stmt, 1);
		printf("name: %s\n",name);
		XCTAssertEqual(sqlStatus, SQLITE_ROW);
		sqlStatus = sqlite3_step(stmt);;
		XCTAssertEqual(sqlStatus, SQLITE_DONE);
}

@end
