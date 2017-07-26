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
#import "NoteView.h"
#import "ImportanceSliderView.h"
#import "ActiveDaysPicker.h"
#import "SubtasksTableView.h"
#import "RateSetterView.h"
#import "DailyEditControlKeep.h"
#import "WeekdayEnum.h"

static NSString* const TRIGGER_LABEL_FORMAT = @"Triggers every %d days";


@interface DailyEditController ()
@property (strong,nonatomic) NSIndexPath *rowInfo;
@property (assign,nonatomic) dailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;
@property (assign,nonatomic) BOOL isStreakReset;
@property (strong,nonatomic) DailyEditControlKeep *editControls;
@property (assign,nonatomic) BOOL isEditingExisting;
@end

NSString* const IS_DIRTY = @"isDirty";

@implementation DailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainer = _editorContainer;
@synthesize isDirty = _isDirty;
@synthesize nameStr = _nameStr;

-(Daily *)tempModel{
    if(nil==_tempModel){
        _tempModel = (Daily *)[SHData constructEmptyEntity:Daily.entity InContext:nil];
    }
    return _tempModel;
}

-(instancetype)initWithParentDailyController:
(DailyViewController *)parentDailyController{
    if(self = [self initWithNibName:@"DailyEditView" bundle:nil]){
        _parentDailyController = parentDailyController;
        _isEditingExisting = NO;
    }
    return self;
}


-(instancetype)initWithParentDailyController:
(DailyViewController *)parentDailyController ToEdit:
(Daily *)daily AtIndexPath:(NSIndexPath *)rowInfo{
    
    if(self = [self initWithParentDailyController:parentDailyController]){
        _modelForEditing = daily;
        _rowInfo = rowInfo;
        _isEditingExisting = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.controlsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //I don't want modelForEditing lazy loaded because it makes the logic confusing.
    //sometimes it unexpectedly gets initialized and that messes things up.
    //So, I want exact control over when it gets initialized
    if(self.modelForEditing){
        if(![SHData.writeContext.registeredObjects containsObject:self.modelForEditing]){
            self.modelForEditing = [SHData.writeContext objectWithID:self.modelForEditing.objectID];
        }
        [self.modelForEditing copyInto:self.tempModel];
        [self.editorContainer enableDelete];
    }
    else{
        self.modelForEditing = [Daily constructDaily];
        [SHData insertIntoContext:self.modelForEditing];
    }
    [self loadExistingDailyForEditing:self.tempModel];
    //I want the editControls stuff to happen here because when it gets
    //lazy loaded, it gets out of hand
    self.editControls = [[DailyEditControlKeep alloc]
                         initWithDailyEditController:self];
    [self.editControls setupDelegates];
    //it is important that this table delegate stuff happens after we check
    //for the existence of the model, otherwise table events will trigger
    //at inconvienient times, and either invalid data or null pointer exceptions
    //will happen
    self.controlsTbl.dataSource = self;
    self.controlsTbl.delegate = self;
    [self addObserver:self forKeyPath:IS_DIRTY options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    if(self.isEditingExisting){
        [self.editorContainer enableDelete];
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
        if(self.editorContainer){
            [self.editorContainer enableSave];
        }
    }
    
}


-(void)saveEdit{
    [self.tempModel copyInto:self.modelForEditing];
    //TODO add something for custom reward
    [SHData save];
}

-(BOOL)deleteModel{
    if(self.modelForEditing){
        Daily *toBeDeleted =
        [SHData.writeContext
         objectWithID:self.modelForEditing.objectID];
        
        [SHData softDeleteModel:toBeDeleted];
        [SHData save];
        return YES;
    }
    return NO;
}

-(void)initializeTempModel{
    self.tempModel.activeDaysHash = ALLDAYS;
    self.tempModel.dailyName = @"";
    self.tempModel.difficulty = 3;
    self.tempModel.urgency = 3;
    self.tempModel.note = @"";
    self.tempModel.rate = 1;
    self.tempModel.streakLength = 0;
}

-(void)loadExistingDailyForEditing:(Daily *)daily{
    self.nameBox.text = daily.dailyName.length>0?daily.dailyName:@"";
    self.nameStr = self.nameBox.text;
    self.editControls.noteView.noteBox.text = daily.note.length>0?daily.note:@"";
    
    self.editControls.importanceSliders.urgencySld.value = daily.urgency;
    
    self.editControls.importanceSliders.urgencyLbl.text = [NSString stringWithFormat:
                                                           @"Urgency: %d"
                                                           ,daily.urgency];
    self.editControls.importanceSliders.difficultySld.value = daily.difficulty;
    
    self.editControls.importanceSliders.difficultyLbl.text = [NSString
                                                              stringWithFormat:
                                                              @"Difficulty: %d"
                                                              ,daily.difficulty];
    
    self.editControls.activeDaysPicker.activeDaysHash = daily.activeDaysHash;
    NSInteger rate = daily.rate;
    self.editControls.rateSetterView.rateStep.value = rate;
    self.editControls.rateSetterView.rateLbl.text = [NSString
                                                     stringWithFormat:
                                                     TRIGGER_LABEL_FORMAT
                                                     ,(int)rate];
    self.editControls.streakResetterView.streakCountLbl.hidden = NO;
    self.editControls.streakResetterView.streakResetBtn.hidden = NO;
    self.editControls.streakResetterView.streakCountLbl.text = [NSString
                                                                stringWithFormat:
                                                                @"Streak: %d"
                                                                ,daily.streakLength];
}

//noteBox
-(void)textDidChange:(UITextView *)textView{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        self.tempModel.note = textView.text;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)textViewDidChange:(UITextView *)textView{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        self.tempModel.note = textView.text;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


- (IBAction)nameBox_editingChanged_action:(UITextField *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        self.nameStr = sender.text;
        self.tempModel.dailyName = sender.text;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


- (IBAction)showXtra_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        if(self.areXtraOptsOpen){
            self.controlsTbl.hidden = YES;
            self.areXtraOptsOpen = NO;
            return;
        }
        self.controlsTbl.hidden = NO;
        self.areXtraOptsOpen = YES;
        if(self.editorContainer){
            [self.editorContainer resizeScrollView:self.controlsTbl.hidden];
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(IBAction)urgencySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        int sliderValue = (int)sender.value;
        self.editControls.importanceSliders.urgencyLbl.text = [NSString
                                                               stringWithFormat:
                                                               @"Urgency: %d"
                                                               ,sliderValue];
        sender.value = sliderValue;
        self.tempModel.urgency = sliderValue;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        int sliderValue = (int)sender.value;
        self.editControls.importanceSliders.difficultyLbl.text = [NSString
                                                                  stringWithFormat:
                                                                  @"Difficulty: %d"
                                                                  ,sliderValue];
        sender.value = sliderValue;
        self.tempModel.difficulty = sliderValue;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
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
        self.editControls.rateSetterView.rateLbl.text =
        [NSString stringWithFormat: TRIGGER_LABEL_FORMAT,(int)rate];
        self.tempModel.rate = rate;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        if(sender.isOn){
            self.tempModel.activeDaysHash |= (int)sender.tag;
        }
        else{
            self.tempModel.activeDaysHash &= ~(int)sender.tag;
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)addRewardBtn_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)streakResetBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        if(self.modelForEditing){
            self.tempModel.streakLength = 0;
            self.isDirty = YES;
            
        }
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.editControls.allControls.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //self.editControls.allControls
    UIView *cellView = self.editControls.allControls[indexPath.row].view;
    [self.editControls.allControls[indexPath.row]
     setBackgroundColor:self.view.backgroundColor];
    cell.backgroundColor = self.view.backgroundColor;
    cell.autoresizesSubviews = NO;
    [cell addSubview:cellView];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.editControls.allControls[indexPath.row].view.frame.size.height;
}


-(void)dealloc{
    @try{
        [self removeObserver:self forKeyPath:IS_DIRTY context:nil];
    }
    @catch(NSException *ex){}
}


@end
