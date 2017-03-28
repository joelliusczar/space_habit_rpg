//
//  DailyEditController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyEditController.h"


static NSString* const TRIGGER_LABEL_FORMAT = @"Triggers every %d days";


@interface DailyEditController ()
@property (nonatomic,strong) UITextField *nameBox;
@property (nonatomic,strong) UITextView *descriptionBox;
@property (nonatomic,strong) UISlider *urgencySld;
@property (nonatomic,strong) UISlider *difficultySld;
@property (nonatomic,strong) NSMutableArray *activeDaySwitches;
@property (nonatomic,strong) UILabel *rateLbl;
@property (nonatomic,strong) UIStepper *rateStep;
@property (nonatomic,strong) UIButton *rewardCustomBtn;
@property (nonatomic,strong) UILabel *rewardCustomLbl;
@property (nonatomic,weak)  NSObject<P_CoreData> *dataController;
@property (nonatomic,weak) DailyViewController *parentDailyController;
@property (nonatomic,weak) Daily *modelForEditing;
@property (nonatomic,strong) DailyHelper *dailyHelper;
@property (nonatomic,strong) CommonUtilities *util;
@property (nonatomic,strong) NSIndexPath *rowInfo;
@property (nonatomic,assign) dailyStatus section;
@end

@implementation DailyEditController



@synthesize nameBox = _nameBox;
-(UITextField *)nameBox{
    if(_nameBox == nil){
        _nameBox = [self.view viewWithTag:13];
    }
    return _nameBox;
}

@synthesize descriptionBox = _descriptionBox;
-(UITextView *)descriptionBox{
    if(_descriptionBox == nil){
        _descriptionBox = [self.view viewWithTag:1];
    }
    return _descriptionBox;
}

@synthesize urgencySld = _urgencySld;
-(UISlider *)urgencySld{
    if(_urgencySld == nil){
        _urgencySld = [self.view viewWithTag:2];
        [_urgencySld addTarget:self action:@selector(urgencySlider_move:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _urgencySld;
}

@synthesize difficultySld = _difficultySld;
-(UISlider *)difficultySld{
    if(_difficultySld == nil){
        _difficultySld = [self.view viewWithTag:3];;
        [_difficultySld addTarget:self action:@selector(difficultySlider_move:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _difficultySld;
}

@synthesize activeDaySwitches = _activeDaySwitches;
-(NSMutableArray *)activeDaySwitches{
    if(_activeDaySwitches == nil){
        _activeDaySwitches = [NSMutableArray arrayWithCapacity:DAYS_IN_WEEK];
        NSInteger dayTag = 4;
        for(int i = 0;i< DAYS_IN_WEEK;i++){
            [_activeDaySwitches addObject:[self.view viewWithTag:(dayTag + i)]];
        }
    }
    return _activeDaySwitches;
}

@synthesize rateLbl = _rateLbl;
-(UILabel *)rateLbl{
    if(_rateLbl == nil){
        _rateLbl = [self.view viewWithTag:11];
    }
    return _rateLbl;
}

@synthesize rateStep = _rateStep;
-(UIStepper *)rateStep{
    if(_rateStep == nil){
        _rateStep = [self.view viewWithTag:12];
        [_rateStep addTarget:self action:@selector(rateStep_pressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rateStep;
}

@synthesize rewardCustomBtn = _rewardCustomBtn;
-(UIButton *)rewardCustomBtn{
    if(_rewardCustomBtn == nil){
        _rewardCustomBtn = [self.view viewWithTag:14];
        [_rewardCustomBtn addTarget:self action:@selector(rewardCustomBtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rewardCustomBtn;
}

@synthesize rewardCustomLbl = _rewardCustomLbl;
-(UILabel *)rewardCustomLbl{
    if(_rewardCustomLbl == nil){
        _rewardCustomLbl = [self.view viewWithTag:15];
    }
    return _rewardCustomLbl;
}

@synthesize modelForEditing = _modelForEditing;
-(Daily *)modelForEditing{
    if(_modelForEditing == nil){
        _modelForEditing = (Daily *)[self.dataController constructEmptyEntity:DAILY_ENTITY_NAME];
    }
    return _modelForEditing;
}

@synthesize util = _util;
-(CommonUtilities *)util{
    if(_util == nil){
        _util = [[CommonUtilities alloc] init];
    }
    return _util;
}

@synthesize dailyHelper = _dailyHelper;
-(DailyHelper *)dailyHelper{
    
    if(_dailyHelper){
        _dailyHelper = [[DailyHelper alloc] init];
    }
    return _dailyHelper;
}


-(id)initWithDataController:(NSObject<P_CoreData> *)dataController AndWithParentDailyController:(DailyViewController *)parentDailyController{
    if(self = [self initWithNibName:@"DailyEditView" bundle:nil]){
        self.dataController = dataController;
        self.parentDailyController = parentDailyController;
        
        [self view];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControlsAndEvents];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)cancelEdit{
    [self cleanUp];
}

-(void)saveEdit{
    //todo check for loophole with nextDueTime
    self.modelForEditing.dailyName = self.nameBox.text;
    self.modelForEditing.note = self.descriptionBox.text;
    self.modelForEditing.urgency = self.urgencySld.value;
    self.modelForEditing.difficulty = self.difficultySld.value;
    int32_t rate = (int32_t)self.rateStep.value;
    self.modelForEditing.rate = rate;
    self.modelForEditing.nextDueTime = [self.dailyHelper calculateNextDueTime:[NSDate date] WithRate:rate];
    self.modelForEditing.streakLength = 0;
    self.modelForEditing.activeDaysHash = [self.dailyHelper calculateActiveDaysHash:self.activeDaySwitches];
    //todo add something for custom reward
    [self.dataController save];
    if(self.rowInfo == nil){
        [self.parentDailyController showNewDaily:self.modelForEditing];
    }
    else{
        [self.parentDailyController refreshTableAtRow:self.rowInfo];
    }
    [self cleanUp];
}

-(BOOL)deleteModel{
    
    BOOL success = [self.dataController deleteModelAndSave:self.modelForEditing];
    [self.parentDailyController removeItemFromViewAtRow:self.rowInfo];
    [self cleanUp];
    return success;
}

-(void)cleanUp{
    [self defaultControls];
    self.modelForEditing = nil;
    self.rowInfo = nil;
}

-(void)defaultControls{
    self.nameBox.text = @"";
    self.descriptionBox.text = @"";
    self.urgencySld.value = 3;
    self.difficultySld.value = 3;
    self.rateLbl.text = [NSString stringWithFormat:TRIGGER_LABEL_FORMAT,1];
    self.rateStep.value = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        [self.util setSwitch:[self.activeDaySwitches objectAtIndex:i] withValue:YES];
    }
    self.modelForEditing = nil;

}



-(void)setupControlsAndEvents{
    //trip the lazy loading
    [self urgencySld];
    [self difficultySld];
    [self rateStep];
    [self rewardCustomBtn];
    
}

-(void)loadExistingDailyForEditing:(Daily *)daily WithIndexPath:(NSIndexPath *)rowInfo{
    [self defaultControls];
    self.modelForEditing = daily;
    self.rowInfo = rowInfo;
    self.nameBox.text = self.modelForEditing.dailyName ? self.modelForEditing.dailyName  : @"";
    self.descriptionBox.text = self.modelForEditing.note ? self.modelForEditing.note : @"";
    self.urgencySld.value = self.modelForEditing.urgency;
    self.difficultySld.value = self.modelForEditing.difficulty;
    int32_t hash = self.modelForEditing.activeDaysHash;
    [self.dailyHelper setActiveDaySwitches:self.activeDaySwitches fromHash:hash];
    NSInteger rate = self.modelForEditing.rate;
    self.rateStep.value = rate;
    self.rateLbl.text = [NSString stringWithFormat:TRIGGER_LABEL_FORMAT,(int32_t)rate];
    
    
}

-(void)rateStep_pressed:(UIStepper *)sender{
    double stepperValue = [sender value];
    int32_t rate = (int32_t)stepperValue;
    if(rate > 366){
        rate = 366;
    }
    if(rate < 1){
        rate = 1;
    }
    sender.value = rate;
    self.rateLbl.text = [NSString stringWithFormat: TRIGGER_LABEL_FORMAT,(int32_t)rate];
}

-(void)urgencySlider_move:(UISlider *)sender{
    int32_t sliderValue = (int32_t)sender.value;
    sender.value = sliderValue;
    NSLog(@"%f",sender.value);
}
-(void)difficultySlider_move:(UISlider *)sender{
    int32_t sliderValue = (int32_t)sender.value;
    sender.value = sliderValue;
    NSLog(@"%f",sender.value);
}

-(void)rewardCustomBtn_pressed:(UIButton *)sender{
    NSLog(@"button pressed");
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
