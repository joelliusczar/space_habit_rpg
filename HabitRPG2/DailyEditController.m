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
#import "WeeklyActiveDays.h"
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
    }
    else{
        self.modelForEditing = [Daily constructDaily];
        [SHData insertIntoContext:self.modelForEditing];
        [self initializeModel:self.modelForEditing];
    }
    //I want the editControls stuff to happen here because when it gets
    //lazy loaded, it gets out of hand
    self.editControls = [[DailyEditControlKeep alloc]
                         initWithDailyEditController:self];
    [self loadExistingDailyForEditing:self.modelForEditing];
    self.modelForEditing.lastUpdateTime = [NSDate date];
    
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


//This method is not really necessary but using it will help my flow in
//viewDidLoad so that I didn't have a weird flag in there denoting that the
//model already existed. Besides, this makes things sorta more explicit
-(void)initializeModel:(Daily *)daily{
    daily.activeDays = ALL_DAYS_JSON;
    daily.rateType = WEEKLY_RATE;
    daily.dailyName = @"";
    daily.difficulty = 3;
    daily.urgency = 3;
    daily.note = @"";
    daily.rate = 1;
    daily.streakLength = 0;
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


-(void)loadExistingDailyForEditing:(Daily *)daily{
    self.nameBox.text = daily.dailyName.length>0?daily.dailyName:@"";
    self.nameStr = self.nameBox.text;
    self.editControls.noteView.noteBox.text = daily.note.length>0?daily.note:@"";
    
    self.editControls.urgencySlider.importanceSld.value = daily.urgency;
    
    self.editControls.urgencySlider.importanceLbl.text = [NSString stringWithFormat:
                                                           @"Urgency: %d"
                                                           ,daily.urgency];
    self.editControls.difficultySlider.importanceSld.value = daily.difficulty;
    
    self.editControls.difficultySlider.importanceLbl.text = [NSString
                                                              stringWithFormat:
                                                              @"Difficulty: %d"
                                                              ,daily.difficulty];
    
    //TODOself.editControls.WeeklyActiveDays.activeDaysHash = daily.activeDaysHash;
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
        self.modelForEditing.note = self.editControls.noteView.noteBox.text;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

//I don't think this is used anywhere
-(void)textViewDidChange:(UITextView *)textView{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        @throw [NSException exceptionWithName:@"is in use" reason:nil userInfo:nil];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


- (IBAction)nameBox_editingChanged_action:(UITextField *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        self.modelForEditing.dailyName = sender.text;
        self.nameStr = sender.text;
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


-(void)importanceSld_valueChanged_action:(ImportanceSliderView *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        int sliderValue = (int)sender.importanceSld.value;
        if(sender == self.editControls.urgencySlider){
            self.modelForEditing.urgency = sliderValue;
            sender.importanceLbl.text = [NSString stringWithFormat:@"Urgency: %d",sliderValue];
        }
        else{
            self.modelForEditing.difficulty = sliderValue;
            sender.importanceLbl.text = [NSString stringWithFormat:@"Difficulty: %d",sliderValue];
        }
        sender.importanceSld.value = sliderValue;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
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
        self.editControls.rateSetterView.rateLbl.text = [NSString
                                                         stringWithFormat: TRIGGER_LABEL_FORMAT,(int)rate];
        self.modelForEditing.rate = rate;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)countAllDaysSwitch_checked_action:(CustomSwitch *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        self.isDirty = YES;
        if(sender.isOn){
            //I'm okay with casting the long to int because I only need the
            //first seven bits anyway
            //TODO: self.modelForEditing.activeDaysHash |= (int)sender.tag;
        }
        else{
            //TODO: self.modelForEditing.activeDaysHash &= ~(int)sender.tag;
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
            self.isDirty = YES;
            self.modelForEditing.streakLength = 0;
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
    SHView *cellView = self.editControls.allControls[indexPath.row];
    cellView.holderView = cell;
    //[cellView changeBackgroundColorTo:self.view.backgroundColor];
    cell.backgroundColor = [UIColor orangeColor];//self.view.backgroundColor;
    [cell.contentView addSubview:cellView];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.editControls.allControls[indexPath.row].mainView.frame.size.height;
}


-(void)unsaved_closing_action{
    NSManagedObjectContext *context = self.modelForEditing.managedObjectContext;
    [context refreshObject:self.modelForEditing mergeChanges:NO];
}


-(void)dealloc{
    @try{
        [self removeObserver:self forKeyPath:IS_DIRTY context:nil];
    }
    @catch(NSException *ex){}
}


@end
