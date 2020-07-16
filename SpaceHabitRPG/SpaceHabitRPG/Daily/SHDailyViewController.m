//
//	SHDailyViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define dummyFlag 0 && defined(IS_DEV) && IS_DEV



#import "SHDailyEditController.h"
#import "SHDailyCellController.h"
#import "SHIntroViewController.h"

@import SHCommon;
@import SHControls;
@import SHModels;
@import SHUtils_C;


@interface SHDailyViewController ()
@property (strong,nonatomic) SHDaily_Medium *dailyMedium;
@property (assign, nonatomic) struct SHDatetimeProvider dateProvider; //not owner
@end

@implementation SHDailyViewController

@synthesize dateProvider = _dateProvider;
@synthesize tableBackend = _tableBackend;

-(const char*)tableName {
	return "Dailies";
}


-(SHErrorCode (*)(sqlite3 *, struct SHHabitBase const *, int64_t *))insertHabit {
	return SH_insertHabit_Daily;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	self.addHabitBtnLbl.text = @"Add New Daily";
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle:@"Dailies"];
}



static SHErrorCode _fetchTableDailies(void* args, struct SHQueueStore *store) {
	struct SHFetchTableItemsArgs *tableArgs = (struct SHFetchTableItemsArgs *)args;
	struct SHQueueStoreItem *item = (struct SHQueueStoreItem *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_fetchTableDailies(item->db, &tableArgs->saCollection, tableArgs->dateProvider);
	return status;
}


-(void)setupData {
	SHErrorCode status = SH_NO_ERROR;
	struct SHFetchTableItemsArgs *fetchTableArgs = NULL;
	if(!(fetchTableArgs = malloc(sizeof(struct SHFetchTableItemsArgs)))) {
		status = SH_ALLOC_NO_MEM;
		goto fnExit;
	}
	*fetchTableArgs = (struct SHFetchTableItemsArgs){
		.saCollection = self->_tableBackend,
		.dateProvider = &self->_dateProvider,
	};
	if((status = SH_serialQueue_addOp(self.dbQueue, _fetchTableDailies, fetchTableArgs, SH_cleanup)) != SH_NO_ERROR) {}
	fnExit:
		return;
#warning update without coredata
//	SHDaily_Medium *dailyMedium = [SHDaily_Medium newWithContext:self.context];
//	self.habitItemsFetcher = [dailyMedium dailiesDataFetcher];
//	self.habitItemsFetcher.delegate = self;
//	[self fetchUpdates];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	(void)tableView;
	SHErrorCode status = SH_NO_ERROR;
	uint64_t sectionCount = 0;
	if((status = SH_SACollection_subIterableCount(self.tableBackend, &sectionCount)) != SH_NO_ERROR) {}
	#warning update without coredata
	if(sectionCount == 3) {
		if(section == SH_DAILY_INCOMPLETE) {
			return @"Incomplete";
		}
		else if(section == SH_DAILY_COMPLETE) {
			return @"Completed";
		}
		else {
			return @"Not Due Today";
		}
	}
	if(sectionCount == 2) {
		if(section == SH_DAILY_INCOMPLETE) {
			return @"Unfinished";
		}
		else {
			return @"Finished";
		}
	}
//	else if(self.habitItemsFetcher.sections.count == 1) {
//		__block NSString *title = @"";
//		[self.habitItemsFetcher.managedObjectContext performBlockAndWait:^{
//			if(self.habitItemsFetcher.fetchedObjects.count < 1) return;
//			SHDaily *daily = (SHDaily *)self.habitItemsFetcher.fetchedObjects[0];
//			#warning daily table title
//			//title = daily.isCompleted ? @"Finished" : @"Unfinished";
//		}];
//		return title;
//	}
	return @"";
}


-(SHHabitCell *)getTableCell:(UITableView*)tableView {
	return [SHDailyCellController getTaskCell:tableView];
}


-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor {
	return [[SHDailyEditController alloc] init];
}


@end
