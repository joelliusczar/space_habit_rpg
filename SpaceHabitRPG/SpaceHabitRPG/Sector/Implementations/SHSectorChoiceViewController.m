//
//	SHSectorChoiceViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/16/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceViewController.h"
#import "SHSectorChoiceCellController.h"
@import SHCommon;
@import SHControls;

@import SHModels;

@interface SHSectorChoiceViewController ()
@property (nonatomic,strong) NSArray<SHSector *> *sectors;

@end

@implementation SHSectorChoiceViewController


-(SHSectorDescriptionViewController *)descViewController{
	if(!_descViewController){
		_descViewController = [[SHSectorDescriptionViewController alloc] initWithOnSelectionAction:self.onSelectionAction];
	}
	return _descViewController;
}


-(instancetype)initWithSectors:(NSArray<SHSector*>*)sectors
	withOnSelectionAction:(void (^)(SHSector*))onSelectionAction
{
	if(self = [super init]){
		_onSelectionAction = onSelectionAction;
		_sectors = sectors;
	}
	return self;
}


- (void)viewDidLoad {
	NSAssert(self.sectors, @"SHSectorChoiceViewController is in an invalid state. Sectors hasn't been constructed");
	[super viewDidLoad];
	self.sectorChoiceTable.tableFooterView = nil;
	self.sectorChoiceTable.dataSource = self;
	self.sectorChoiceTable.rowHeight = SH_SECTOR_CHOICE_ROW_HEIGHT;
	[self.view checkForAndApplyVisualChanges];
}


-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	(void)tableView; (void)section;
	if(self.sectors){
		return self.sectors.count;
	}
	return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	SHSector *sector = self.sectors[indexPath.row];
	SHSectorChoiceCellController *cell = [SHSectorChoiceCellController getSectorChoiceCell:tableView
		withParent:self withSector:sector withRow:indexPath];
	return cell;
}



@end
