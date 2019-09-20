//
//	SHSectorChoiceViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/16/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSectorChoiceViewController.h"
#import "SHSectorChoiceCellController.h"
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHSingletonCluster.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHModels/SHSector_Medium.h>
#import <SHControls/UIView+Helpers.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHData/SHData.h>

@interface SHSectorChoiceViewController ()
@property (nonatomic,strong) NSArray<SHStoryItemObjectID *> *objectIDs;

@end

@implementation SHSectorChoiceViewController


-(SHSectorDescriptionViewController *)descViewController{
	if(!_descViewController){
		_descViewController = [[SHSectorDescriptionViewController alloc] initWithSectorChoiceViewController:self
			withOnSelectionAction:self.onSelectionAction];
	}
	return _descViewController;
}


-(instancetype)initWithSectorIDs:(NSArray<SHStoryItemObjectID*>*)objectIDs
	withOnSelectionAction:(void (^)(SHStoryItemObjectID*))onSelectionAction
{
	if(self = [super init]){
		_onSelectionAction = onSelectionAction;
		_objectIDs = objectIDs;
	}
	return self;
}


- (void)viewDidLoad {
	NSAssert(self.objectIDs, @"SHSectorChoiceViewController is in an invalid state. Sectors hasn't been constructed");
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
	if(self.objectIDs){
		return self.objectIDs.count;
	}
	return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	SHStoryItemObjectID *objectID = self.objectIDs[indexPath.row];
	SHSectorChoiceCellController *cell = [SHSectorChoiceCellController getSectorChoiceCell:tableView
		withParent:self withObjectID:objectID withRow:indexPath];
	return cell;
}



@end
