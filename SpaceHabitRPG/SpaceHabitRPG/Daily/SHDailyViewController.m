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
@property (assign, nonatomic) const struct SHDatetimeProvider *dateProvider; //not owner
@end

@implementation SHDailyViewController

@synthesize dateProvider = _dateProvider;

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


-(void)setupData {
	[self fetchUpdates:SH_fetchTableDailies];
}


static SHErrorCode _sectionTitles(void* args, struct SHQueueStore *store, struct SHIterableWrapper** result) {
	*result = NULL;
	struct SHModelsQueueStore *item = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	if(!item || !result) return SH_INVALID_STATE;
	SHHabitViewController *cSelf = (__bridge SHHabitViewController*)args;
	struct SHIterableWrapper *tableStorage = SH_modelsQueueStore_selectTableData(item, cSelf.tableName);
	*result = SH_iterable_init(&SH_ARRAY_FN_DEFS, NULL, NULL);
	if(!(*result)) {
		status |= SH_ALLOC_NO_MEM;
		SH_notifyOfError(status, "failed to allocate memory");
		goto fnExit;
	}
	for(uint64_t idx = 0; idx < SH_iterable_count(tableStorage); idx++) {
		struct SHIterableWrapper *sectionData = SH_iterable_getItemAtIdx(tableStorage, idx);
		if(SH_iterable_count(sectionData)) {
			struct SHTableDaily *tableDaily = SH_iterable_getItemAtIdx(sectionData, 0);
			switch(tableDaily->dueStatus) {
				case SH_IS_NOT_DUE:
					SH_iterable_addItem(*result, "Not due today");
					break;
				case SH_IS_COMPLETED:
					SH_iterable_addItem(*result, "Completed");
					break;
				case SH_IS_DUE:
					SH_iterable_addItem(*result, "Due today");
					break;
				default:
					SH_iterable_addItem(*result, "Unexpected section");
			}
		}
	}
	fnExit:
		return status;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	(void)tableView;

	SHErrorCode status = SH_NO_ERROR;
	struct SHIterableWrapper *sectionTitles = NULL;
	NSString *title = nil;
	if((status = SH_serialQueue_addOpAndWaitForResult(self.dbQueue,
		(SHErrorCode (*)(void*, struct SHQueueStore *, void**))_sectionTitles, (__bridge void*)self, NULL,
		(void**)&sectionTitles))
		!= SH_NO_ERROR)
	{
		SH_notifyOfError(status, "Error while getting section titles for daily controller");
		goto fnExit;
	}
	title = [NSString stringWithUTF8String:SH_iterable_getItemAtIdx(sectionTitles, section)];
	SH_iterable_cleanup(sectionTitles);
	return title;
	fnExit:
		return @"";
}


-(SHHabitCell *)getTableCell:(UITableView*)tableView {
	return [SHDailyCellController getTaskCell:tableView];
}


-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor {
	return [[SHDailyEditController alloc] init];
}


@end
