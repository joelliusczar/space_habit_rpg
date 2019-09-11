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
@property (nonatomic,strong) NSArray<SHObjectIDWrapper *> *objectIDs;

@end

@implementation SHSectorChoiceViewController


-(SHSectorDescriptionViewController *)descViewController{
	if(!_descViewController){
		_descViewController = [[SHSectorDescriptionViewController alloc] init:self];
	}
	return _descViewController;
}


-(instancetype)initWithSkipAction:(void (^)(void))skipAction withOnSelectionAction:(void (^)(void))onSelectionAction{
	if(self = [super init]){
		_skipAction = skipAction;
		_onSelectionAction = onSelectionAction;
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


-(IBAction)skipBtn_pressed_action:(UIButton *)sender{
	(void)sender;
	self.skipAction(); //[self.central setToShowStory:NO]; //[self.central afterSectorPick:nil];
	[self popVCFromFront];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	SHObjectIDWrapper *objectID = self.objectIDs[indexPath.row];
	SHSectorChoiceCellController *cell = [SHSectorChoiceCellController getSectorChoiceCell:tableView
		withParent:self withObjectID:objectID withRow:indexPath];
	return cell;
}



@end
