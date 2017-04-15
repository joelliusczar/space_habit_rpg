//
//  ZoneChoiceViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneChoiceViewController.h"
#import "ZoneChoiceCellController.h"
#import "CustomSwitch.h"
#import "constants.h"
#import "ViewHelper.h"

@interface ZoneChoiceViewController ()
    @property (nonatomic,strong) NSArray<Zone *> *zones;
    @property (nonatomic,strong) UITableView *zoneChoiceTable; //TODO: determine weak vs strong
    @property (nonatomic,weak) UIButton *nextBtn;
    @property (nonatomic,weak) CustomSwitch *skipSwitch;
    @property (nonatomic,weak) NSObject<P_CoreData> *dataController;
    -(instancetype)initWithCentral:(UIViewController<CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;

@end

@implementation ZoneChoiceViewController

    @synthesize zoneChoiceTable = _zoneChoiceTable;
    -(UITableView *)zoneChoiceTable{
        if(!_zoneChoiceTable){
            UIView *v = [self getContentSubview];
            _zoneChoiceTable = [v viewWithTag:2];
        }
        return _zoneChoiceTable;
    }

    @synthesize nextBtn = _nextBtn;
    -(UIButton *)nextBtn{
        if(!_nextBtn){
            UIView *v = [self getContentSubview];
            _nextBtn = [v viewWithTag:3];
        }
        return _nextBtn;
    }

    @synthesize skipSwitch = _skipSwitch;
    -(CustomSwitch *)skipSwitch{
        if(!_skipSwitch){
            UIView *v = [self getContentSubview];
            _skipSwitch = [v viewWithTag:4];
        }
        return _skipSwitch;
    }

    @synthesize descViewController = _descViewController;
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
        [super viewDidLoad];
        NSAssert(self.zones, @"ZoneChoiceViewController is in an invalid state. Zones hasn't been constructed");
    }
        
    -(void)viewDidLayoutSubviews{
        [super viewDidLayoutSubviews];
        self.zoneChoiceTable.dataSource = self;
        self.zoneChoiceTable.rowHeight = ZONE_CHOICE_ROW_HEIGHT;
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
    -(UIView *)getContentSubview{
        return [self.view viewWithTag:1];;
    }


    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if(self.zones){
            return self.zones.count;
        }
        return 0;
    }

    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        Zone *z = self.zones[indexPath.row];
        ZoneChoiceCellController *cell = [ZoneChoiceCellController getZoneChoiceCell:tableView WithOwner:self AndModel:z AndRow:indexPath];
        return cell; 
    }

    -(void)saveZoneChoice:(Zone *)zoneChoice{
        NSObject<P_CoreData> *dataController = self.dataController;
        for(int32_t i = 0;i<self.zones.count;i++){
            if(self.zones[i] != zoneChoice){
                [dataController softDeleteModel:self.zones[i]];
            }
        }
        [dataController save:zoneChoice];
    }


    /*
    #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

@end
