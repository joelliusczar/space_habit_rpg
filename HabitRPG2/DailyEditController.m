//
//  DailyEditController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyEditController.h"
#import "CoreDataStackController.h"
#import "Daily.h"
#import "constants.h"
#import "DailyHelper.h"

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
@property (nonatomic,weak)  CoreDataStackController *dataController;
@property (nonatomic,weak) DailyViewController *parentDailyController;
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
        _activeDaySwitches = [NSMutableArray arrayWithCapacity:7];
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


-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParentDailyController:(DailyViewController *)parentDailyController{
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelEdit{
    [self defaultControls];
}

-(void)saveEdit{
    Daily *d = (Daily *)[self.dataController constructEmptyEntity:DAILY_ENTITY_NAME];
    d.dailyName = self.nameBox.text;
    d.note = self.descriptionBox.text;
    d.urgency = [NSNumber numberWithFloat:self.urgencySld.value];
    d.difficulty = [NSNumber numberWithFloat:self.difficultySld.value];
    int rate =   lround(self.rateStep.value);
    d.rate = [NSNumber numberWithInt:rate];
    d.nextDueTime = [DailyHelper calculateNextDueTime:[[NSDate alloc]init] WithRate:rate];
    d.streakLength = 0;
    d.activeDaysHash = [NSNumber numberWithInt:[self calculateActiveDaysHash:self.activeDaySwitches]];
    //todo add something for custom reward
    [self.dataController Save];
    [self.parentDailyController showNewDaily:d];
    [self defaultControls];
}

-(void)defaultControls{
    self.nameBox.text = @"";
    self.descriptionBox.text = @"";
    self.urgencySld.value = 3;
    self.difficultySld.value = 3;
    self.rateLbl.text = @"Triggers every 1 days";
    self.rateStep.value = 1;
    UISwitch *day = nil;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        day = (UISwitch *)[self.activeDaySwitches objectAtIndex:i];
        day.on = YES;
    }

}

-(int)calculateActiveDaysHash:(NSMutableArray *)activeDays{
    int daysHash = 0;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        UISwitch *daySwitch = (UISwitch *)[activeDays objectAtIndex:i];
        if(daySwitch.isOn){
            int dayBit = 0;
            dayBit = dayBit << i;
            daysHash |= dayBit;
        }
    }
    return daysHash;
}

-(void)setupControlsAndEvents{
    //trip the lazy loading
    [self urgencySld];
    [self difficultySld];
    [self rateStep];
    [self rewardCustomBtn];
    
}

-(void)rateStep_pressed:(UIStepper *)sender{
    double stepperValue = [sender value];
    int rate = lround(stepperValue);
    if(rate > 366){
        rate = 366;
    }
    if(rate < 0){
        rate = 0;
    }
    sender.value = rate;
    self.rateLbl.text = [NSString stringWithFormat: @"Triggers every %d days",rate];
}

-(void)urgencySlider_move:(UISlider *)sender{
    int sliderValue = lroundf(sender.value);
    sender.value = sliderValue;
    NSLog(@"%f",sender.value);
}
-(void)difficultySlider_move:(UISlider *)sender{
    int sliderValue = lroundf(sender.value);
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
