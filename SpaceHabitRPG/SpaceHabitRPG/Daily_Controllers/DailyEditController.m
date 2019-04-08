//
//  DailyEditController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyEditController.h"
#import <SHCommon/CommonUtilities.h>
#import <SHModels/Daily_Medium.h>
#import <SHControls/P_SHSwitch.h>
#import "EditNavigationController.h"
#import <SHControls/SHSwitch.h>
#import <SHModels/Daily+Helper.h>
#import <SHCommon/Interceptor.h>
#import <SHModels/RateTypeHelper.h>


@interface DailyEditController ()
@property (strong,nonatomic) NSIndexPath *rowInfo;
@property (assign,nonatomic) dailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;
@property (assign,nonatomic) BOOL isStreakReset;
@property (strong,nonatomic) SHControlKeep<SHView *,id> *editControls;
@property (assign,nonatomic) BOOL isEditingExisting;
@property (strong,nonatomic) Daily_Medium *daily_Medium;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@end

NSString* const IS_TOUCHED = @"modelForEditing.isTouched";

@implementation DailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainer = _editorContainer;
@synthesize nameStr = _nameStr;


//used for new Dailies
-(instancetype)initWithParentDailyController:
(UIViewController *)parentDailyController
withDataController:(NSObject<P_CoreData>*)dataController{
    if(self = [self initWithNibName:@"DailyEditView" bundle:nil]){
        _parentDailyController = parentDailyController;
        _isEditingExisting = NO;
        _dataController = dataController;
        _daily_Medium = [Daily_Medium newWithSHData:dataController];
    }
    return self;
}

//used for existing dailies
-(instancetype)initWithParentDailyController:
(UIViewController *)parentDailyController ToEdit:
(Daily *)daily AtIndexPath:(NSIndexPath *)rowInfo
withDataController:(NSObject<P_CoreData>*)dataController{
    
    if(self = [self initWithParentDailyController:parentDailyController withDataController:dataController]){
        _modelForEditing = daily;
        _rowInfo = rowInfo;
        _isEditingExisting = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.controlsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self setupModelForEditing];
    [self setupEditControls];
    [self loadExistingDailyForEditing:self.modelForEditing];
    self.modelForEditing.lastUpdateTime = [NSDate date];
    
    //it is important that this table delegate stuff happens after we check
    //for the existence of the model, otherwise table events will trigger
    //at inconvienient times, and either invalid data or null pointer exceptions
    //will happen
    self.controlsTbl.dataSource = self;
    self.controlsTbl.delegate = self;
    [self addObserver:self forKeyPath:IS_TOUCHED options:NSKeyValueObservingOptionNew context:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.isEditingExisting){
        [self.editorContainer enableDelete];
    } 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupModelForEditing{
    //I don't want modelForEditing lazy loaded because it makes the logic confusing.
    //sometimes it unexpectedly gets initialized and that messes things up.
    //So, I want exact control over when it gets initialized
    if(self.modelForEditing){
        if(![self.dataController.mainThreadContext.registeredObjects containsObject:self.modelForEditing]){
            self.modelForEditing = [self.dataController.mainThreadContext objectWithID:self.modelForEditing.objectID];
        }
    }
    else{
        self.modelForEditing = [self.daily_Medium newDailyWithContext:self.dataController.mainThreadContext];
        [self.modelForEditing setupDefaults];
    }
}


-(void)setupEditControls{
    //I want the editControls stuff to happen here because when it gets
    //lazy loaded, it gets out of hand
    
    self.editControls = [self buildControlKeep:self.modelForEditing];
    [self setResponders:self.editControls];
    self.editorContainer.editControls = self.editControls;
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(nullable id)object
                       change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(nullable void *)context{
    
    if([keyPath isEqualToString:IS_TOUCHED]){
        if(self.editorContainer){
            [self.editorContainer enableSave];
        }
    }
    
}


- (IBAction)nameBox_editingChange_action:(SHTextField *)sender forEvent:(UIEvent *)event {
    [self.modelForEditing name_w:sender.text];
    self.nameStr = sender.text;
}


- (IBAction)showXtra_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
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
}


-(void)pickerSelection_action:(UIPickerView *)picker
           onItemFlexibleList:(ItemFlexibleListView *)itemFlexibleList
                     forEvent:(UIEvent *)event{
    [self.editorContainer enableSave];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.editControls.controlList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    SHView *cellView = self.editControls.controlList[indexPath.row];
    cellView.holderView = cell;
    [cellView changeBackgroundColorTo:self.view.backgroundColor];
    cell.backgroundColor = self.view.backgroundColor;
    [cell.contentView addSubview:cellView];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.editControls.controlList[indexPath.row].mainView.frame.size.height;
}


-(void)streakResetBtn_press_action:(SHEventInfo *)eventInfo {
    [self.modelForEditing streak_w:0];
}

#pragma clang diagnostic pop

-(void)saveEdit{
    [self.modelForEditing preSave];
    NSError *error = nil;
    [self.dataController.mainThreadContext save:&error];
}


-(BOOL)deleteModel{
    if(self.modelForEditing){
      [self.dataController.mainThreadContext deleteObject:self.modelForEditing];
      NSError *error = nil;
      [self.dataController.mainThreadContext save:&error];
      return YES;
    }
    return NO;
}


-(void)loadExistingDailyForEditing:(Daily *)daily{
    self.nameBox.text = daily.dailyName.length>0?daily.dailyName:@"";
    self.nameStr = self.nameBox.text;
}


-(void)textDidChange:(SHEventInfo *)eventInfo{
    UITextView *textView = (UITextView *)eventInfo.senderStack[0];
    [self.modelForEditing noteText_w:textView.text];
    self.nameStr = textView.text;
}
    
    
-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo {
    UIStepper *sender = (UIStepper *)eventInfo.senderStack[0];
    sender.value = [self.modelForEditing rate_w:(int)sender.value];
}
    
    
-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo{
    (void)eventInfo;
    SHSwitch *sender = (SHSwitch *)eventInfo.senderStack[0];
    [self.modelForEditing
            flipDayOfWeek_w:sender.tag
            for:isInverseRateType(self.modelForEditing.rateType)];
}
    
    
-(void)sld_valueChanged_action:(SHEventInfo *)eventInfo{
    UISlider *sender = (UISlider *)eventInfo.senderStack[0];
    ImportanceSliderView *sliderView = (ImportanceSliderView *)eventInfo.senderStack[1];
    int sliderValue = (int)sender.value;
    [sliderView updateImportanceSlider:sliderValue];
    if(sliderView == self.editControls.controlLookup[@"urgencySld"]){
        [self.modelForEditing urgency_w:sliderValue];
    }
    else{
        [self.modelForEditing difficulty_w:sliderValue];
    }
}


-(void)unsaved_closing_action{
    NSManagedObjectContext *context = self.modelForEditing.managedObjectContext;
    [context refreshObject:self.modelForEditing mergeChanges:NO];
}


-(void)dealloc{
    NSLog(@"DailyEditController deallocating");
    @try{
        [self removeObserver:self forKeyPath:IS_TOUCHED context:nil];
    }
    @catch(NSException *ex){}
}


@end
