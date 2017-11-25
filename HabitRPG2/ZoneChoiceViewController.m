//
//  ZoneChoiceViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceViewController.h"
#import "ZoneChoiceCellController.h"
#import "constants.h"
#import "ViewHelper.h"
#import "SingletonCluster.h"
#import "CommonUtilities.h"
#import "ZoneHelper.h"

@interface ZoneChoiceViewController ()
@property (nonatomic,strong) NSArray<Zone *> *zones;
@property (nonatomic,weak) NSObject<P_CoreData> *dataController;
-(instancetype)initWithCentral:(UIViewController<CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;

@end

@implementation ZoneChoiceViewController


-(ZoneDescriptionViewController *)descViewController{
    if(!_descViewController){
        _descViewController = [[ZoneDescriptionViewController alloc] init:self];
    }
    return _descViewController;
}

-(instancetype)initWithCentral:(UIViewController<CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices{
    if(self = [self initWithNibName:@"ZoneChoicePicker" bundle:nil]){
        _central = central;
        _dataController = central.dataController;
        _zones = zoneChoices;
        
    }
    return self;
}


+(instancetype)constructWithCentral:(UIViewController<CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices{
    return [[ZoneChoiceViewController alloc] initWithCentral:central AndZoneChoices:zoneChoices];
}

- (void)viewDidLoad {
    NSAssert(self.zones, @"ZoneChoiceViewController is in an invalid state. Zones hasn't been constructed");
    [super viewDidLoad];
    self.zoneChoiceTable.tableFooterView = nil;
    self.zoneChoiceTable.dataSource = self;
    self.zoneChoiceTable.rowHeight = ZONE_CHOICE_ROW_HEIGHT;
    [CommonUtilities checkForAndApplyVisualChanges:self.view];
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


-(void)nextBtn_pressed_action:(UIButton *)sender{
    BOOL show = self.skipSwitch.isOn;
    [self.central setToShowStory:show];
    [ViewHelper popViewFromFront:self];
    [self.central afterZonePick:nil];
}

#pragma clang diagnostic pop


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Zone *z = self.zones[indexPath.row];
    ZoneChoiceCellController *cell = [ZoneChoiceCellController getZoneChoiceCell:tableView WithParent:self AndModel:z AndRow:indexPath];
    return cell; 
}



@end
