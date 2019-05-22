//
//  SHDailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define dummy 0 && defined(IS_DEV) && IS_DEV

#import "SHDailyViewController.h"
#import <SHGlobal/SHConstants.h>
#import "SHEditNavigationController.h"
#import "SHDailyEditController.h"
#import "SHDailyCellController.h"
#import "SHIntroViewController.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHControls/SHButton.h>
#import <SHModels/SHMonster_Medium.h>
#import <SHModels/SHDaily_Medium.h>
#import <SHData/NSManagedObjectContext+Helper.h>


@interface SHDailyViewController ()

@property (strong,nonatomic) SHDailyEditController *dailyEditor;
@property (strong,nonatomic) UITableView *dailiesTable;
@property (strong,nonatomic) NSFetchedResultsController *incompleteItems;
@property (strong,nonatomic) NSFetchedResultsController *completeItems;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) Monster_Medium *monsterMedium;
@property (strong,nonatomic) SHDaily_Medium *dailyMedium;
@property (strong,nonatomic) NSManagedObjectContext *dailyContext;

@end

@implementation SHDailyViewController

static NSString *const EntityName = @"Daily";

@synthesize dailyEditor = _dailyEditor;
-(SHDailyEditController *)dailyEditor{
  if(_dailyEditor == nil){
    _dailyEditor = [[SHDailyEditController alloc] init];
  }
  return _dailyEditor;
}


-(NSManagedObjectContext*)dailyContext{
  if(nil == _dailyContext){
    _dailyContext = [self.central.dataController newBackgroundContext];
  }
  return _dailyContext;
}


-(instancetype)initWithCentral:(SHCentralViewController *)central{
  if(self = [self initWithNibName:@"SHDailyViewController" bundle:nil]){
    _central = central;
    [self setuptab];
    
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.dailiesTable = [[UITableView alloc]init];

  [self.view addSubview:self.dailiesTable];
  
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  CGFloat height = [UIScreen mainScreen].bounds.size.height;
  CGFloat minY = self.view.frame.origin.y;
  CGFloat viewHeight = self.view.frame.size.height - (height *.10);
  self.dailiesTable.frame = CGRectMake(0,
   minY + (height * .10),
   width,
   viewHeight);
  self.dailiesTable.delegate = self;
  self.dailiesTable.dataSource = self;
  self.incompleteItems.delegate = self;
  self.completeItems.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setuptab{
    UITabBarItem *tbi = [self tabBarItem];
    [self setupData];
    [tbi setTitle:@"Dailies"];
}


-(void)completeDaily:(SHDaily *)daily{
        daily.rollbackActivationDateTime = daily.lastActivationDateTime;
        daily.lastActivationDateTime = [[NSDate date] dayStart];
        //TODO: calculate damage done to monster
        //TODO: save
}


-(void)undoCompletedDaily:(SHDaily *)daily{
    daily.lastActivationDateTime = daily.rollbackActivationDateTime;
    //TODO: more stuff
}


-(void)setupData{
  SHConfigDTO *settings = self.central.configDTO;
  NSDate *todayStart = [[NSDate date] dayStart];
  todayStart = [todayStart timeAfterHours:settings.dayStart minutes:0 seconds:0];
  SHDaily_Medium *dailyMedium = [SHDaily_Medium newWithContext:self.dailyContext];
  self.incompleteItems = [dailyMedium getUnfinishedDailiesController:todayStart];
  self.completeItems = [dailyMedium getFinishedDailiesController:todayStart];
  
  [self fetchUpdates];
  
}


-(void)fetchUpdates{
  __block NSError *error = nil;
  [self.dailyContext performBlock:^{
    [self.incompleteItems performFetch:&error];
    [self.completeItems performFetch:&error];
  }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  (void)tableView;
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  (void)tableView;
  __block NSInteger rowCount = 0;
  [self.dailyContext performBlockAndWait:^{
    if(section == SH_INCOMPLETE){
      rowCount = self.incompleteItems.fetchedObjects.count;
    }
    else{
        rowCount = self.completeItems.fetchedObjects.count;
    }
  }];
  return rowCount;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  (void)tableView;
  if(section == SH_INCOMPLETE){
    return @"Unfinished";
  }
  else{
    return @"Finished";
  }
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
  (void)controller;
  [self.dailiesTable beginUpdates];
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  (void)controller;
  [self.dailiesTable endUpdates];
}


- (IBAction)addDailyBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  (void)sender; (void)event;
  SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc] init];
  objectIDWrapper.entityType = SHDaily.entity;
  [self setupEditorWithObjectIDWrapper:objectIDWrapper];
  self.central.editController.editingScreen = self.dailyEditor;
  self.central.editController.title = @"Daily";
  [self.central arrangeAndPushChildVCToFront:self.central.editController];
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  (void)tableView;
  UITableViewRowAction *openEditBox = [UITableViewRowAction
    rowActionWithStyle:UITableViewRowActionStyleNormal
    title:@"Edit"
    handler:^(UITableViewRowAction *action,NSIndexPath *path){
      (void)action;
      NSFetchedResultsController *fetchController = path.section == SH_INCOMPLETE?
        self.incompleteItems:
        self.completeItems;
      NSManagedObjectContext *fetchContext = fetchController.managedObjectContext;
      [fetchContext performBlockAndWait:^{
        NSManagedObject *rowObject = fetchController.fetchedObjects[indexPath.row];
        SHObjectIDWrapper *objectIDWrapper = [[SHObjectIDWrapper alloc] init];
        objectIDWrapper.objectID = rowObject.objectID;
        objectIDWrapper.entityType = SHDaily.entity;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [self setupEditorWithObjectIDWrapper:objectIDWrapper];
          self.central.editController.editingScreen = self.dailyEditor;
          self.central.editController.title = @"Daily";
          [self.central arrangeAndPushChildVCToFront:self.central.editController];
        }];
      }];
  }];
  
  return @[openEditBox];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  SHDailyCellController *cell = [SHDailyCellController getDailyCell:tableView WithParent:self];
  __block NSManagedObjectID *objectID = nil;
  [self.dailyContext performBlockAndWait:^{
    if(indexPath.section == SH_INCOMPLETE){
      objectID = ((SHDaily*)self.incompleteItems.fetchedObjects[indexPath.row]).objectID;
    }
    else{
      objectID = ((SHDaily*)self.completeItems.fetchedObjects[indexPath.row]).objectID;
    }
    
  }];
  [cell setupCell:objectID withContext:self.dailyContext andRow:indexPath];
  return cell;
}




/*
This will be called the user creates a new daily, checks it off, or deletes one
*/
-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
  atIndexPath:(NSIndexPath *)indexPath
  forChangeType:(NSFetchedResultsChangeType)type
  newIndexPath:(NSIndexPath *)newIndexPath
{
  NSAssert(controller==self.incompleteItems||controller==self.completeItems,
    @"controller is pointing to an invalid objects");
  (void)anObject;
  NSInteger sectionNum = controller==self.incompleteItems?SH_INCOMPLETE:SH_COMPLETE;
  NSIndexPath *customExistingPath = [NSIndexPath indexPathForRow:indexPath.row inSection:sectionNum];
  NSIndexPath *customNewPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:sectionNum];
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.dailiesTable insertRowsAtIndexPaths:@[customNewPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.dailiesTable cellForRowAtIndexPath:customExistingPath] atIndexPath:customExistingPath];
      break;
    case NSFetchedResultsChangeDelete:
      [self.dailiesTable deleteRowsAtIndexPaths:@[customExistingPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    default:
      break;
  }
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
  SHDailyCellController *dailyCell = (SHDailyCellController *)cell;
  [dailyCell refreshCell:indexPath];
}

-(void)setupEditorWithObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper{
  NSManagedObjectContext *parentContext = self.dailyContext;
  NSManagedObjectContext *context = [self.dailyContext createChildContext];
  
  __weak NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
  __weak typeof(self) weakSelf = self;
  __block id token = [center addObserverForName:NSManagedObjectContextDidSaveNotification
    object:context
    queue:nil
    usingBlock:^(NSNotification *notfification){
      (void)notfification;
      [parentContext performBlock:^{
        NSError *error = nil;
        if(parentContext.hasChanges){
          [parentContext save:&error];
          if(error){
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
              typeof(weakSelf) bSelf = weakSelf;
              if(nil == bSelf) return;
              [bSelf showErrorView:@"Save failed" withError:error];
            }];
          }
        }
      }];
      [center removeObserver:token];
    }];
  
  [self.dailyEditor setupForContext:context andObjectIDWrapper:objectIDWrapper];;
}


@end
