//
//  ZoneChoiceViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceViewController.h"
#import "ZoneChoiceCellController.h"
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHSingletonCluster.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHModels/SHSector_Medium.h>
#import <SHControls/UIView+Helpers.h>
#import <SHControls/UIViewController+Helper.h>

@interface ZoneChoiceViewController ()
@property (nonatomic,strong) NSArray<SHSectorDTO *> *zones;
@property (nonatomic,weak) NSObject<P_CoreData> *dataController;

@end

@implementation ZoneChoiceViewController


-(ZoneDescriptionViewController *)descViewController{
    if(!_descViewController){
        _descViewController = [[ZoneDescriptionViewController alloc] init:self];
    }
    return _descViewController;
}


+(instancetype)newWithCentral:(CentralViewController *)central
  AndZoneChoices:(NSArray<SHSectorDTO *> *)zoneChoices{
  
  ZoneChoiceViewController *instance = [[ZoneChoiceViewController alloc]
    initWithNibName:@"ZoneChoicePicker" bundle:nil];
  instance.central = central;
  instance.zones = zoneChoices;
  return instance;
}

- (void)viewDidLoad {
    NSAssert(self.zones, @"ZoneChoiceViewController is in an invalid state. Zones hasn't been constructed");
    [super viewDidLoad];
    self.zoneChoiceTable.tableFooterView = nil;
    self.zoneChoiceTable.dataSource = self;
    self.zoneChoiceTable.rowHeight = SH_SECTOR_CHOICE_ROW_HEIGHT;
    [self.view checkForAndApplyVisualChanges];
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if(self.zones){
      return self.zones.count;
  }
  return 0;
}


-(IBAction)skipBtn_pressed_action:(UIButton *)sender{
  [self.central setToShowStory:NO];
  [self popVCFromFront];
  [self.central afterZonePick:nil withContext:nil];
}


#pragma clang diagnostic pop


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  SHSectorDTO *z = self.zones[indexPath.row];
  ZoneChoiceCellController *cell = [ZoneChoiceCellController getZoneChoiceCell:tableView
    WithParent:self AndModel:z AndRow:indexPath];
  return cell;
}



@end
