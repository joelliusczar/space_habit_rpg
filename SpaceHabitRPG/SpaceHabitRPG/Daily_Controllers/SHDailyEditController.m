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
#import <SHModels/SHDailyActiveDays.h>
#import <SHModels/SHDailyValidation.h>


@interface SHDailyEditController ()
@property (assign,nonatomic) shDailyStatus section;
@property (assign,nonatomic) BOOL areXtraOptsOpen;
@property (assign,nonatomic) BOOL isStreakReset;
@property (strong,nonatomic) SHControlKeep<SHView *,id> *editControls;
@property (assign,nonatomic) BOOL isEditingExisting;
@property (strong,nonatomic) SHDailyActiveDays *activeDays;
@end

@implementation SHDailyEditController

//These need to be synthesized since they come from a protocol
@synthesize editorContainer = _editorContainer;
@synthesize nameStr = _nameStr;


-(SHDailyActiveDays*)activeDays{
  if(nil == _activeDays){
    [self.context performBlockAndWait:^{
      SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
      NSMutableDictionary *activeDaysDict = [NSMutableDictionary jsonStringToDict:daily.activeDays];
      self->_activeDays = [[SHDailyActiveDays alloc] initWithActiveDaysDict:activeDaysDict];
    }];
  }
  return _activeDays;
}


-(instancetype)init{
  if(self = [self initWithNibName:@"SHDailyEditView" bundle:nil]){}
  return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.controlsTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
    [self setupEditControls];
    [self loadExistingDailyForEditing];
    
    //it is important that this table delegate stuff happens after we check
    //for the existence of the model, otherwise table events will trigger
    //at inconvienient times, and either invalid data or null pointer exceptions
    //will happen
    self.controlsTbl.dataSource = self;
    self.controlsTbl.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.objectIDWrapper.objectID){
        [self.editorContainer enableDelete];
    } 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupEditControls{
    //I want the editControls stuff to happen here because when it gets
    //lazy loaded, it gets out of hand
    
    self.editControls = [self buildControlKeep];
    [self setResponders:self.editControls];
    self.editorContainer.editControls = self.editControls;
    
}


- (IBAction)nameBox_editingChange_action:(SHTextField *)sender forEvent:(UIEvent *)event {
  (void)event;
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    daily.dailyName = sender.text;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self modelTouched];
    }];
  }];
}


- (IBAction)showXtra_push_action:(UIButton *)sender forEvent:(UIEvent *)event {
  (void)sender; (void)event;
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
  forEvent:(UIEvent *)event
{
  (void)picker; (void)itemFlexibleList; (void)event;
  [self.editorContainer enableSave];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  (void)tableView;(void)section;
  return self.editControls.controlList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  (void)tableView;
  UITableViewCell *cell = [[UITableViewCell alloc] init];
  SHView *cellView = self.editControls.controlList[indexPath.row];
  cellView.holderView = cell;
  [cellView changeBackgroundColorTo:self.view.backgroundColor];
  cell.backgroundColor = self.view.backgroundColor;
  [cell.contentView addSubview:cellView];
  return cell;
}


-(CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  (void)tableView;
  return self.editControls.controlList[indexPath.row].mainView.frame.size.height;
}


-(void)streakResetBtn_press_action:(SHEventInfo *)eventInfo {
  (void)eventInfo;
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    daily.streakLength = 0;
  }];
}


-(void)saveEdit{
  NSManagedObjectContext *context = self.context;
  NSString *updatedActiveDays = self.activeDays.activeDaysJson;
  [context performBlock:^{
    SHDaily *daily = (SHDaily*)[context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    daily.activeDays = updatedActiveDays;
    NSError *error = nil;
    [context save:&error];
    if(error){
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self showErrorView:@"Save failed" withError:error];
      }];
    }
  }];
}


-(void)deleteModel{
  NSManagedObjectID *objectID = self.objectIDWrapper.objectID;
  if(objectID){
    NSManagedObjectContext *context = self.context;
    [context performBlock:^{
      NSError *error = nil;
      NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithObjectIDs:@[objectID]];
      [context executeRequest:deleteRequest error:&error];
      if(error){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [self showErrorView:@"Delete failed" withError:error];
        }];
      }
    }];
  }
}


-(void)loadExistingDailyForEditing{
  if(self.objectIDWrapper.objectID){
    [self.context performBlock:^{
      SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
      NSString *dailyName = daily.dailyName;
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.nameBox.text = dailyName;
      }];
    }];
  }
}


-(void)textDidChange:(SHEventInfo *)eventInfo{
    UITextView *textView = (UITextView *)eventInfo.senderStack[0];
    NSString *note = textView.text;
    [self.context performBlock:^{
      SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
      daily.note = note;
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self modelTouched];
      }];
    }];
}
    
    
-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo {
  UIStepper *sender = (UIStepper *)eventInfo.senderStack[0];
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    int32_t rate = shFilterRate(sender.value);
    daily.rate = rate;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      sender.value = rate;
      [self modelTouched];
    }];
  }];
}
    
    
-(void)activeDaySwitch_press_action:(SHEventInfo *)eventInfo{
  (void)eventInfo;
  SHSwitch *sender = (SHSwitch *)eventInfo.senderStack[0];
  
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    BOOL isInverse = shIsInverseRateType(daily.rateType);
    int32_t rate = daily.rate;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.activeDays flipDayOfWeek:sender.tag forPolarity:isInverse andRate:rate];
      [self modelTouched];
    }];
  }];
}
    
    
-(void)sld_valueChanged_action:(SHEventInfo *)eventInfo{
  UISlider *sender = (UISlider *)eventInfo.senderStack[0];
  SHImportanceSliderView *sliderView = (SHImportanceSliderView *)eventInfo.senderStack[1];
  int sliderValue = shCheckImportanceRange((int)sender.value);
  [sliderView updateImportanceSlider:sliderValue];
  BOOL isUrgency = sliderView == self.editControls.controlLookup[@"urgencySld"];
  [self.context performBlock:^{
    SHDaily *daily = (SHDaily*)[self.context getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    if(isUrgency){
      daily.urgency = sliderValue;
    }
    else{
      daily.difficulty = sliderValue;
    }
  }];
  
}


-(void)modelTouched{
  [self.editorContainer enableSave];
}


@end
