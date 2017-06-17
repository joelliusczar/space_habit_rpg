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
#import "Daily+DailyHelper.h"
#import "Interceptor.h"


static NSString* const TRIGGER_LABEL_FORMAT = @"Triggers every %d days";


@interface DailyEditController ()

@property (weak,nonatomic) IBOutlet UIView *advancedOptsView;
@property (weak,nonatomic) IBOutlet UITextField *nameBox;
@property (weak,nonatomic) IBOutlet UITextView *notesBox;
@property (weak,nonatomic) IBOutlet UISlider *urgencySld;
@property (weak, nonatomic) IBOutlet UILabel *urgencyLbl;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLbl;
@property (weak,nonatomic) IBOutlet UISlider *difficultySld;
@property (weak,nonatomic) IBOutlet UIButton *showXtraOptsBtn;
@property (nonatomic,strong) NSMutableArray<UIButton<P_CustomSwitch> *> *activeDaySwitches;
@property (weak,nonatomic) IBOutlet UIStepper *rateStep;
@property (weak,nonatomic) IBOutlet UILabel *rateLbl;
@property (weak,nonatomic) IBOutlet UILabel *rewardsList;
@property (weak, nonatomic) IBOutlet UILabel *streakCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *streakResetBtn;
@property (weak,nonatomic) DailyViewController *parentDailyController;
@property (strong,nonatomic) Daily *modelForEditing;
@property (strong,nonatomic) NSIndexPath *rowInfo;
@property (assign,nonatomic) dailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;
@property (assign,nonatomic) BOOL isStreakReset;

@end

NSString* const IS_DIRTY = @"isDirty";

@implementation DailyEditController

@synthesize isDirty = _isDirty;
@synthesize delegate = _delegate;
@synthesize nameStr = _nameStr;

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


-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController{
    if(self = [self initWithNibName:@"DailyEditView" bundle:nil]){
        _parentDailyController = parentDailyController;
    }
    return self;
}

-(instancetype)initWithParentDailyController:(DailyViewController *)parentDailyController ToEdit:(Daily *)daily AtIndexPath:(NSIndexPath *)rowInfow{
    if(self = [self initWithParentDailyController:parentDailyController]){
        _modelForEditing = daily;
        [self loadExistingDailyForEditing:daily WithIndexPath:rowInfow];
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

-(void)viewDidAppear:(BOOL)animated{
    if(self.modelForEditing){
        [self.delegate enableDelete];
    }
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
    Daily *savingModel = nil;
    int rate = (int)self.rateStep.value;
    if(nil==self.modelForEditing){
        savingModel = [Daily constructDaily];
        [SHData insertIntoContext:savingModel];
        //initialize the next time this daily activates
    }
    else{
        savingModel = [SHData.writeContext objectWithID:self.modelForEditing.objectID];
        //if the rate has changed then we need to adjust the next time this activates
    }
    savingModel.dailyName = self.nameBox.text;
    savingModel.note = self.notesBox.text;
    savingModel.urgency = self.urgencySld.value;
    savingModel.difficulty = self.difficultySld.value;
    savingModel.rate = rate;
    savingModel.activeDaysHash = [Daily calculateActiveDaysHash:self.activeDaySwitches];
    if(self.isStreakReset){
        savingModel.streakLength = 0;
    }
    //TODO add something for custom reward
    [SHData save];
}

-(BOOL)deleteModel{
    if(self.modelForEditing){
        Daily *toBeDeleted = [SHData.writeContext objectWithID:self.modelForEditing.objectID];
        [SHData softDeleteModel:toBeDeleted];
        [SHData save];
        return YES;
    }
    return NO;
}

-(void)loadExistingDailyForEditing:(Daily *)daily WithIndexPath:(NSIndexPath *)rowInfo{
    self.rowInfo = rowInfo;
    self.nameBox.text = self.modelForEditing.dailyName ? self.modelForEditing.dailyName  : @"";
    self.nameStr = self.nameBox.text;
    self.notesBox.text = self.modelForEditing.note ? self.modelForEditing.note : @"";
    self.urgencySld.value = self.modelForEditing.urgency;
    self.urgencyLbl.text = [NSString stringWithFormat:@"Urgency: %d",self.modelForEditing.urgency];
    self.difficultySld.value = self.modelForEditing.difficulty;
    self.difficultyLbl.text = [NSString stringWithFormat:@"Difficulty: %d",self.modelForEditing.difficulty];
    int hash = self.modelForEditing.activeDaysHash;
    [Daily setActiveDaySwitches:self.activeDaySwitches fromHash:hash];
    NSInteger rate = self.modelForEditing.rate;
    self.rateStep.value = rate;
    self.rateLbl.text = [NSString stringWithFormat:TRIGGER_LABEL_FORMAT,(int)rate];
    self.streakCountLbl.hidden = NO;
    self.streakResetBtn.hidden = NO;
    self.streakCountLbl.text = [NSString stringWithFormat:@"Streak: %d",daily.streakLength];
    [self.delegate enableDelete];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    self.isDirty = YES;
}
- (IBAction)nameBox_editingChanged_action:(UITextField *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        self.nameStr = self.nameBox.text;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@nameBox_editingChanged_action",self.description]];
}

- (IBAction)showXtra_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
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
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@showXtra_push_action",self.description]];
}

-(IBAction)urgencySld_valueChange_action:(UISlider *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        int sliderValue = (int)sender.value;
        self.urgencyLbl.text = [NSString stringWithFormat:@"Urgency: %d",sliderValue];
        sender.value = sliderValue;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@urgencySld_valueChange_action",self.description]];
}

- (IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        int sliderValue = (int)sender.value;
        self.difficultyLbl.text = [NSString stringWithFormat:@"Difficulty: %d",sliderValue];
        sender.value = sliderValue;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@difficultySld_valueChanged_action",self.description]];
}

- (IBAction)rateStep_valueChange_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
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
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@rateStep_valueChange_action",self.description]];
}
- (IBAction)daySwitch_push_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@daySwitch_push_action~%ld",self.description,sender.tag]];
}

- (IBAction)addRewardBtn_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@addRewardBtn_push_action",self.description]];
}

- (IBAction)streakResetBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        if(self.modelForEditing){
            self.isStreakReset = YES;
            self.isDirty = YES;
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@streakResetBtn_press_action",self.description]];
}

-(void)dealloc{
    @try{
        [self removeObserver:self forKeyPath:IS_DIRTY context:nil];
    }
    @catch(NSException *ex){}
}


@end
