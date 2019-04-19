//
//  DailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define dummy 0 && defined(IS_DEV) && IS_DEV

#import "DailyViewController.h"
#import <SHGlobal/SHConstants.h>
#import "EditNavigationController.h"
#import "DailyEditController.h"
#import "DailyCellController.h"
#import "IntroViewController.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHControls/SHButton.h>
#import <SHModels/SHMonster_Medium.h>
#import <SHModels/SHDaily_Medium.h>



@interface DailyViewController ()

@property (strong,nonatomic) DailyEditController *dailyEditor;
@property (strong,nonatomic) UITableView *dailiesTable;
@property (strong,nonatomic) NSFetchedResultsController *incompleteItems;
@property (strong,nonatomic) NSFetchedResultsController *completeItems;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) Monster_Medium *monsterMedium;
@property (strong,nonatomic) SHDaily_Medium *dailyMedium;

@end

@implementation DailyViewController

static NSString *const EntityName = @"Daily";

@synthesize dailyEditor = _dailyEditor;
-(DailyEditController *)dailyEditor{
  if(_dailyEditor == nil){
    _dailyEditor = [[DailyEditController alloc]
    initWithParentDailyController:self];
  }
  return _dailyEditor;
}


-(instancetype)initWithCentral:(CentralViewController *)central{
  if(self = [self initWithNibName:@"DailyViewController" bundle:nil]){
    self->_central = central;
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
  SHSettingsDTO *settings = self.central.settingsDTO;
  NSDate *todayStart = [[NSDate date] dayStart];
  todayStart = [todayStart timeAfterHours:settings.dayStart minutes:0 seconds:0];
  self.incompleteItems = [self.dailyMedium getUnfinishedDailiesController:todayStart
    withContext:self.dataController.mainThreadContext];
  self.completeItems = [self.dailyMedium getFinishedDailiesController:todayStart
    withContext:self.dataController.mainThreadContext];
  
  [self fetchUpdates];
  
}


-(void)fetchUpdates{
    NSError *error;
    if(![self.incompleteItems performFetch:&error]){
        NSLog(@"Error fetching incompleted items: %@", error.localizedFailureReason);
        return;
    }
    if(![self.completeItems performFetch:&error]){
        NSLog(@"Error fetching completed items: %@", error.localizedFailureReason);
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == SH_INCOMPLETE){
        return self.incompleteItems.fetchedObjects.count;
    }
    else{
        return self.completeItems.fetchedObjects.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  if(section == SH_INCOMPLETE){
    return @"Unfinished";
  }
  else{
    return @"Finished";
  }
}


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
  [self.dailiesTable beginUpdates];
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
  [self.dailiesTable endUpdates];
}


-(UIViewController*)getEditScreen{
    DailyEditController *dailyEditor = [[DailyEditController alloc]
      initWithParentDailyController:self];
    EditNavigationController *editController = [[EditNavigationController alloc]
                                                initWithTitle:@"Add Daily"
                                                andEditor:dailyEditor];
    return editController;
}


- (IBAction)addDailyBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  [self.central arrangeAndPushChildVCToFront:[self getEditScreen]];
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak DailyViewController *weakSelf = self;
    void (^pressedEdit)(UITableViewRowAction *,NSIndexPath *) = ^(UITableViewRowAction *action,NSIndexPath *path){
        shWrapReturnVoid wrappedCall = ^void(){
            NSFetchedResultsController *fetchController = path.section == SH_INCOMPLETE?weakSelf.incompleteItems:weakSelf.completeItems;
            DailyEditController *dailyEditor = [[DailyEditController alloc]
                                                initWithParentDailyController:weakSelf
                                                ToEdit:fetchController.fetchedObjects[indexPath.row]
                                                AtIndexPath:path];
            EditNavigationController *editController = [[EditNavigationController alloc]
                                                        initWithTitle:@"Add Daily"
                                                        andEditor:dailyEditor];
            [weakSelf.central arrangeAndPushChildVCToFront:editController];
        };
        [SHInterceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@pressedEdit",self.description]];
    };
    
    UITableViewRowAction *openEditBox = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:pressedEdit];
    
    return @[openEditBox];
}

#pragma clang diagnostic pop



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyCellController *cell = [DailyCellController getDailyCell:tableView WithParent:self];
    SHDaily *d = nil;
    if(indexPath.section == SH_INCOMPLETE){
        d = self.incompleteItems.fetchedObjects[indexPath.row];
    }
    else{
        d = self.completeItems.fetchedObjects[indexPath.row];
    }
    [cell setupCell:d AndRow:indexPath];

    return cell;
}




/*
This will be called the user creates a new daily, checks it off, or deletes one
*/
-(void)controller:(NSFetchedResultsController *)controller
                    didChangeObject:(id)anObject
                    atIndexPath:(NSIndexPath *)indexPath
                    forChangeType:(NSFetchedResultsChangeType)type
                    newIndexPath:(NSIndexPath *)newIndexPath{
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
    DailyCellController *dailyCell = (DailyCellController *)cell;
    [dailyCell refreshCell:indexPath];
}



@end
