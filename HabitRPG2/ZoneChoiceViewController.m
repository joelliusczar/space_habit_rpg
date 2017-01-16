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

@interface ZoneChoiceViewController ()

@property (nonatomic,weak) UIViewController<ChoiceScreenBase> * screenBase;
@property (nonatomic,strong) NSArray<Zone *> *zones;
@property (nonatomic,weak) UITableView *zoneChoiceTable; //TODO: determine weak vs strong
@property (nonatomic,weak) UIButton *nextBtn;
@property (nonatomic,weak) CustomSwitch *skipSwitch;
-(instancetype)initWithBase:(UIViewController<ChoiceScreenBase> *)screenBase;

@end

@implementation ZoneChoiceViewController

@synthesize zoneChoiceTable = _zoneChoiceTable;
-(UITableView *)zoneChoiceTable{
    if(!_zoneChoiceTable){
        _zoneChoiceTable = [self.view viewWithTag:1];
    }
    return _zoneChoiceTable;
}

@synthesize nextBtn = _nextBtn;
-(UIButton *)nextBtn{
    if(!_nextBtn){
        _snextBtn = [self.view viewWithTag:2];
    }
    return _nextBtn;
}

@synthesize skipSwitch = _skipSwitch;
-(CustomSwitch *)skipSwitch{
    if(!_skipSwitch){
        _skipSwitch = [self.view viewWithTag:3];
    }
    return _skipSwitch;
}

-(instancetype)initWithBase:(UIViewController<ChoiceScreenBase> *)screenBase{
    if(self = [self initWithNibName:@"ZoneChoiceView" bundle:nil]){
        self.screenBase = screenBase;
    }
    return self;
}

+(instancetype)constructWithBase:(UIViewController<ChoiceScreenBase> *)screenBase{
    return [[ZoneChoiceViewController alloc] initWithBase:screenBase];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData:(NSArray<Zone *> *)zones{
    self.zones = zones;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
