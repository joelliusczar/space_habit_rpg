//
//  DailyEditController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyEditController.h"
#import "CommonUtilities.h"
#import "SingletonCluster.h"
#import "P_CustomSwitch.h"
#import "EditNavigationController.h"
#import "CustomSwitch.h"


static NSString* const TRIGGER_LABEL_FORMAT = @"Triggers every %d days";


@interface DailyEditController ()

@property (weak,nonatomic) IBOutlet UIView *advancedOptsView;
@property (weak,nonatomic) IBOutlet UITextField *nameBox;
@property (weak,nonatomic) IBOutlet UITextView *notesBox;
@property (weak,nonatomic) IBOutlet UISlider *urgencySld;
@property (weak,nonatomic) IBOutlet UISlider *difficultySld;
@property (weak,nonatomic) IBOutlet UIButton *showXtraOptsBtn;
@property (nonatomic,strong) NSMutableArray<UIButton<P_CustomSwitch> *> *activeDaySwitches;
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet UILabel *rateLbl;
@property (weak,nonatomic) IBOutlet UILabel *rewardsList;
@property (weak,nonatomic) DailyViewController *parentDailyController;
@property (weak,nonatomic) Daily *modelForEditing;
@property (strong,nonatomic) DailyHelper *dailyHelper;
@property (strong,nonatomic) NSIndexPath *rowInfo;
@property (assign,nonatomic) dailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;

@end

NSString* const IS_DIRTY = @"isDirty";

@implementation DailyEditController

@synthesize isDirty = _isDirty;
@synthesize delegate = _delegate;

@synthesize activeDaySwitches = _activeDaySwitches;
-(NSMutableArray<UIButton<P_CustomSwitch> *> *)activeDaySwitches{
    if(_activeDaySwitches == nil){
        _activeDaySwitches = [NSMutableArray arrayWithCapacity:DAYS_IN_WEEK];
        NSInteger dayTag = 4;
        for(int i = 0;i< DAYS_IN_WEEK;i++){
            [_activeDaySwitches addObject:[self.view viewWithTag:(dayTag + i)]];
        }
    }
    return _activeDaySwitches;
}

@synthesize modelForEditing = _modelForEditing;
-(Daily *)modelForEditing{
    if(_modelForEditing == nil){
        _modelForEditing = (Daily *)[SHData constructEmptyEntity:DAILY_ENTITY_NAME];
    }
    return _modelForEditing;
}

@synthesize dailyHelper = _dailyHelper;
-(DailyHelper *)dailyHelper{
    
    if(_dailyHelper){
        _dailyHelper = [[DailyHelper alloc] init];
    }
    return _dailyHelper;
}


-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController{
    if(self = [self initWithNibName:@"DailyEditView" bundle:nil]){
        self.parentDailyController = parentDailyController;
        [self view];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.notesBox.delegate = self;
    @try{
        [self removeObserver:self forKeyPath:IS_DIRTY context:nil];
    }
    @catch(NSException *ex){}
    [self addObserver:self forKeyPath:IS_DIRTY options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(nullable id)object
                       change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(nullable void *)context{
    if([keyPath isEqualToString:IS_DIRTY]){
        if(self.delegate){
            [self.delegate enableSave];
        }
    }
    
}

-(void)saveEdit{
    //todo check for loophole with nextDueTime
    self.modelForEditing.dailyName = self.nameBox.text;
    self.modelForEditing.note = self.notesBox.text;
    self.modelForEditing.urgency = self.urgencySld.value;
    self.modelForEditing.difficulty = self.difficultySld.value;
    int32_t rate = (int32_t)self.rateStep.value;
    self.modelForEditing.rate = rate;
    self.modelForEditing.nextDueTime = [self.dailyHelper calculateNextDueTime:[NSDate date] WithRate:rate];
    self.modelForEditing.streakLength = 0;
    self.modelForEditing.activeDaysHash = [self.dailyHelper calculateActiveDaysHash:self.activeDaySwitches];
    //todo add something for custom reward
    [SHData save]; //TODO: this is probably all sorts of fucked up at the moment
    if(self.rowInfo == nil){
        [self.parentDailyController showNewDaily:self.modelForEditing];
    }
    else{
        [self.parentDailyController refreshTableAtRow:self.rowInfo];
    }
    [self cleanUp];
}

-(BOOL)deleteModel{
    
    [SHData softDeleteModel:self.modelForEditing]; //TODO decided if save happens here. I think
    //it does, but we're not here yet.
    [self.parentDailyController removeItemFromViewAtRow:self.rowInfo];
    [self cleanUp];
    return YES; //TODO: refactor so return type is void
}

-(void)cleanUp{
    [self defaultControls];
    self.modelForEditing = nil;
    self.rowInfo = nil;
}

-(void)defaultControls{
    self.nameBox.text = @"";
    self.notesBox.text = @"";
    self.urgencySld.value = 3;
    self.difficultySld.value = 3;
    self.rateLbl.text = [NSString stringWithFormat:TRIGGER_LABEL_FORMAT,1];
    self.rateStep.value = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        self.activeDaySwitches[i].isOn = YES;
    }
    self.modelForEditing = nil;

}

-(void)loadExistingDailyForEditing:(Daily *)daily WithIndexPath:(NSIndexPath *)rowInfo{
    [self defaultControls];
    self.modelForEditing = daily;
    self.rowInfo = rowInfo;
    self.nameBox.text = self.modelForEditing.dailyName ? self.modelForEditing.dailyName  : @"";
    self.notesBox.text = self.modelForEditing.note ? self.modelForEditing.note : @"";
    self.urgencySld.value = self.modelForEditing.urgency;
    self.difficultySld.value = self.modelForEditing.difficulty;
    int32_t hash = self.modelForEditing.activeDaysHash;
    [self.dailyHelper setActiveDaySwitches:self.activeDaySwitches fromHash:hash];
    NSInteger rate = self.modelForEditing.rate;
    self.rateStep.value = rate;
    self.rateLbl.text = [NSString stringWithFormat:TRIGGER_LABEL_FORMAT,(int32_t)rate];
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",@"text change");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)nameBox_endEdit_action:(UITextField *)sender forEvent:(UIEvent *)event {
    
}

- (IBAction)showXtra_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
    if(self.areXtraOptsOpen){
        self.advancedOptsView.hidden = YES;
        self.areXtraOptsOpen = NO;
        return;
    }
    self.advancedOptsView.hidden = NO;
    self.areXtraOptsOpen = YES;
    if(self.delegate){
        [self.delegate resizeScrollView:self.advancedOptsView.hidden];
    }
}

-(IBAction)urgencySld_valueChange_action:(UISlider *)sender forEvent:(UIEvent *)event {
    int sliderValue = (int)sender.value;
    sender.value = sliderValue;
    NSLog(@"%f",sender.value);
}

- (IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    int sliderValue = (int)sender.value;
    sender.value = sliderValue;
    NSLog(@"%f",sender.value);
}

- (IBAction)rateStep_valueChange_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    double stepperValue = [sender value];
    int rate = (int)stepperValue;
    if(rate > 366){
        rate = 366;
    }
    if(rate < 1){
        rate = 1;
    }
    sender.value = rate;
    self.rateLbl.text = [NSString stringWithFormat: TRIGGER_LABEL_FORMAT,(int)rate];
}
- (IBAction)daySwitch_push_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    NSLog(@"%@",@"day switch");
}

- (IBAction)addRewardBtn_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
}

-(void)dealloc{
    @try{
        [self removeObserver:self forKeyPath:IS_DIRTY context:nil];
    }
    @catch(NSException *ex){}
}


@end
