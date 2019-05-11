//
//  SHDailyEditController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyEditController.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHModels/SHDaily_Medium.h>
#import <SHControls/SHSwitchProtocol.h>
#import "SHEditNavigationController.h"
#import <SHControls/SHSwitch.h>
#import <SHCommon/SHInterceptor.h>
#import <SHModels/SHRateTypeHelper.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHData/NSManagedObjectContext+Helper.h>


@interface SHDailyEditController ()
@property (strong,nonatomic) NSIndexPath *rowInfo;
@property (assign,nonatomic) shDailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;
@property (assign,nonatomic) BOOL isStreakReset;
@property (strong,nonatomic) SHControlKeep<SHView *,id> *editControls;
@property (assign,nonatomic) BOOL isEditingExisting;
@property (strong,nonatomic) SHDaily_Medium *daily_Medium;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@end

NSString* const IS_TOUCHED = @"modelForEditing.isTouched";

@implementation SHDailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainer = _editorContainer;
@synthesize nameStr = _nameStr;


//used for new Dailies
-(instancetype)initWithParentDailyController:
(SHDailyViewController *)parentDailyController{
    if(self = [self initWithNibName:@"SHDailyEditView" bundle:nil]){
        _parentDailyController = parentDailyController;
        _isEditingExisting = NO;
    }
    return self;
}

//used for existing dailies
-(instancetype)initWithParentDailyController:
(SHDailyViewController *)parentDailyController ToEdit:
(SHDailyDTO *)daily AtIndexPath:(NSIndexPath *)rowInfo{
    
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
    
    [self setupModelForEditing];
    [self setupEditControls];
    [self loadExistingDailyForEditing:self.modelForEditing];
    
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
    if(nil == self.modelForEditing){
      self.modelForEditing = [[SHDailyDTO alloc] init];
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
    self.modelForEditing.dailyName = sender.text;
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
           onItemFlexibleList:(SHItemFlexibleListView *)itemFlexibleList
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
    self.modelForEditing.streakLength = 0;
}

#pragma clang diagnostic pop

-(void)saveEdit{
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  NSString *updatedActiveDays = [self.modelForEditing.activeDaysDict dictToString];
  self.modelForEditing.activeDays = updatedActiveDays;
  SHDaily *model = [self.modelForEditing copy];
  [context performBlock:^{
    SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:self.modelForEditing.objectID];
    [daily dtoCopyFrom:model];
    NSError *error = nil;
    [context save:&error];
    if(error){
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self showErrorView:@"Save faile" withError:error];
      }];
    }
  }];
}


-(void)deleteModel{
    if(self.modelForEditing.objectID){
      NSManagedObjectContext *context = [self.dataController newBackgroundContext];
      NSManagedObjectID *objectID = self.modelForEditing.objectID;
      [context performBlock:^{
        NSError *error = nil;
        NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithObjectIDs:@[objectID]];
        [context executeRequest:deleteRequest error:&error];
        if(error){
          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self showErrorView:@"Delete faile" withError:error];
          }];
        }
      }];
    }
}


-(void)loadExistingDailyForEditing:(SHDailyDTO *)daily{
    self.nameBox.text = daily.dailyName.length>0?daily.dailyName:@"";
    self.nameStr = self.nameBox.text;
}


-(void)textDidChange:(SHEventInfo *)eventInfo{
    UITextView *textView = (UITextView *)eventInfo.senderStack[0];\
    self.modelForEditing.note = textView.text;
    self.nameStr = textView.text;
}
    
    
-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo {
    UIStepper *sender = (UIStepper *)eventInfo.senderStack[0];
    self.modelForEditing.rate = sender.value;
    sender.value = self.modelForEditing.rate;
}
    
    
-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo{
  (void)eventInfo;
  SHSwitch *sender = (SHSwitch *)eventInfo.senderStack[0];
  [self.modelForEditing flipDayOfWeek:sender.tag];
}
    
    
-(void)sld_valueChanged_action:(SHEventInfo *)eventInfo{
    UISlider *sender = (UISlider *)eventInfo.senderStack[0];
    SHImportanceSliderView *sliderView = (SHImportanceSliderView *)eventInfo.senderStack[1];
    int sliderValue = (int)sender.value;
    [sliderView updateImportanceSlider:sliderValue];
    if(sliderView == self.editControls.controlLookup[@"urgencySld"]){
      self.modelForEditing.urgency = sliderValue;
    }
    else{
      self.modelForEditing.difficulty = sliderValue;
    }
}


-(void)dealloc{
    NSLog(@"DailyEditController deallocating");
    @try{
        [self removeObserver:self forKeyPath:IS_TOUCHED context:nil];
    }
    @catch(NSException *ex){}
}


@end
