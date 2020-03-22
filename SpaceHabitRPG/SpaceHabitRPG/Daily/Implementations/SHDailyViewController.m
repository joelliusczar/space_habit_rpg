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


@interface SHDailyViewController ()
@property (strong,nonatomic) SHDaily_Medium *dailyMedium;
@end

@implementation SHDailyViewController


-(NSEntityDescription*)entityType {
	return SHDaily.entity;
}


-(NSString*)entityName {
	return @"Daily";
}


-(void)viewDidLoad {
	[super viewDidLoad];
	self.addHabitBtnLbl.text = @"Add New Daily";
	UITabBarItem *tbi = [self tabBarItem];
	[tbi setTitle:@"Dailies"];
}


-(void)setupData{
	SHDaily_Medium *dailyMedium = [SHDaily_Medium newWithContext:self.context];
	self.habitItemsFetcher = [dailyMedium dailiesDataFetcher];
	self.habitItemsFetcher.delegate = self;
	[self fetchUpdates];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	(void)tableView;
	if(self.habitItemsFetcher.sections.count == 2) {
		if(section == SH_INCOMPLETE) {
			return @"Unfinished";
		}
		else {
			return @"Finished";
		}
	}
	else if(self.habitItemsFetcher.sections.count == 1) {
		__block NSString *title = @"";
		[self.habitItemsFetcher.managedObjectContext performBlockAndWait:^{
			if(self.habitItemsFetcher.fetchedObjects.count < 1) return;
			SHDaily *daily = (SHDaily *)self.habitItemsFetcher.fetchedObjects[0];
			title = daily.isCompleted ? @"Finished" : @"Unfinished";
		}];
		return title;
	}
	return @"";
}


-(SHHabitCell *)getTableCell:(UITableView*)tableView {
	return [SHDailyCellController getTaskCell:tableView];
}


-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor {
	return [[SHDailyEditController alloc] init];
}


@end
