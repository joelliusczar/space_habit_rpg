//
//  DailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyViewController.h"
#import "constants.h"
#import "EditNavigationController.h"
#import "DailyEditController.h"
#import "DailyCellController.h"
#import "IntroViewController.h"
#import "SingletonCluster.h"
#import "CommonUtilities.h"
#import "ViewHelper.h"
#import "Daily+DailyHelper.h"
#import "NSDate+DateHelper.h"
#import "Interceptor.h"

@interface DailyViewController ()

    @property (strong,nonatomic) DailyEditController *dailyEditor;
    @property (weak,nonatomic)  CentralViewController *parentController;
    @property (strong,nonatomic) UITableView *dailiesTable;
    @property (strong,nonatomic) NSFetchedResultsController *incompleteItems;
    @property (strong,nonatomic) NSFetchedResultsController *completeItems;

@end

@implementation DailyViewController

static NSString *const EntityName = @"Daily";

@synthesize dailyEditor = _dailyEditor;
-(DailyEditController *)dailyEditor{
    if(_dailyEditor == nil){
        _dailyEditor = [[DailyEditController alloc] initWithParentDailyController:self];
    }
    return _dailyEditor;
}

-(id)initWithParent:(CentralViewController *)parent
{
    if(self = [self initWithNibName:@"DailyViewController" bundle:nil]){
        _parentController = parent;
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
    CGFloat viewHeight = self.view.frame.size.height - [CommonUtilities GetYStartUnderLabel:height];
    self.dailiesTable.frame = CGRectMake(0, minY + [CommonUtilities GetYStartUnderLabel:height],
                                                       width,
                                                       viewHeight);
    self.dailiesTable.delegate = self;
    self.dailiesTable.dataSource = self;
    self.incompleteItems.delegate = self;
    self.completeItems.delegate = self;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:SHData.readContext selector:@selector(mergeChangesFromContextDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:SHData.writeContext];
    
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

-(void)refreshTableAtRow:(NSIndexPath *)row{
    [self.dailiesTable reloadRowsAtIndexPaths:@[row] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)completeDaily:(Daily *)daily{
    if(daily == self.incompleteItems.fetchedObjects[daily.rowNum]){
        daily.rollbackActivationTime = daily.lastActivationTime;
        daily.lastActivationTime = [NSDate todayStart];
        //TODO calculate damage done to monster
        //TODO save
    }
    else{
        NSLog(@"Oh oh! Something illogical was about to happen. There was a mismatch in completeDaily.");
    }
}

-(void)undoCompletedDaily:(Daily *)daily{
    if(daily == self.completeItems.fetchedObjects[daily.rowNum]){
        daily.lastActivationTime = daily.rollbackActivationTime;
        //TODO more stuff
    }
    else{
        NSLog(@"Oh oh! Something illogical was about to happen. There was a mismatch in completeDaily.");
    }
}

-(void)setupData{
    NSDate *todayStart = [NSDate todayStart];
    todayStart = [NSDate adjustTime:todayStart hour:SHData.userData.theSettings.dayStart minute:0 second:0];
    self.incompleteItems = [Daily getUnfinishedDailiesController:todayStart];
    self.completeItems = [Daily getFinishedDailiesController:todayStart];
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == INCOMPLETE){
        return self.incompleteItems.fetchedObjects.count;
    }
    else{
        return self.completeItems.fetchedObjects.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == INCOMPLETE){
        return @"Unfinished";
    }
    else{
        return @"Finished";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyCellController *cell = [DailyCellController getDailyCell:tableView WithParent:self];
    Daily *d = nil;
    if(indexPath.section == INCOMPLETE){
        d = self.incompleteItems.fetchedObjects[indexPath.row];
    }
    else{
        d = self.completeItems.fetchedObjects[indexPath.row];
    }
    d.rowNum = indexPath.row;
    d.sectionNum = indexPath.section;
    [cell setupCell:d AndRow:indexPath];
    
    return cell;
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.dailiesTable beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    NSInteger sectionNum = controller==self.incompleteItems?INCOMPLETE:COMPLETE;
    NSIndexPath *customExistingPath = indexPath?[NSIndexPath indexPathForRow:indexPath.row inSection:sectionNum]:nil;
    NSIndexPath *customNewPath = newIndexPath?[NSIndexPath indexPathForRow:newIndexPath.row inSection:sectionNum]:nil;
    
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

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.dailiesTable endUpdates];
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    DailyCellController *dailyCell = (DailyCellController *)cell;
    [dailyCell refreshCell:indexPath];
}

- (IBAction)addDailyBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    
    wrapReturnVoid wrappedCall = ^void(){
        DailyEditController *dailyEditor = [[DailyEditController alloc] initWithParentDailyController:self];
        EditNavigationController *editController = [[EditNavigationController alloc] initWithTitle:@"Add Daily" andEditor:dailyEditor];
        [ViewHelper pushViewToFront:editController OfParent:self.parentController];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@addDailyBtn_press_action",self.description]];
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    void (^pressedEdit)(UITableViewRowAction *,NSIndexPath *) = ^(UITableViewRowAction *action,NSIndexPath *path){
        wrapReturnVoid wrappedCall = ^void(){
            NSFetchedResultsController *fetchController = path.section == INCOMPLETE?self.incompleteItems:self.completeItems;
            DailyEditController *dailyEditor = [[DailyEditController alloc] initWithParentDailyController:self ToEdit:fetchController.fetchedObjects[indexPath.row] AtIndexPath:path];
            EditNavigationController *editController = [[EditNavigationController alloc] initWithTitle:@"Add Daily" andEditor:dailyEditor];
            [ViewHelper pushViewToFront:editController OfParent:self.parentController];
        };
        [Interceptor callVoidWrapped:wrappedCall withInfo:[NSString stringWithFormat:@"%@pressedEdit",self.description]];
    };
    
    UITableViewRowAction *openEditBox = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:pressedEdit];
    
    return @[openEditBox];
}

@end
