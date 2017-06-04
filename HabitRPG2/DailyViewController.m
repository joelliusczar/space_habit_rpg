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
#import "DailyHelper.h"
#import "DailyCellController.h"
#import "IntroViewController.h"
#import "SingletonCluster.h"
#import "CommonUtilities.h"
#import "ViewHelper.h"


@interface DailyViewController ()

    @property (nonatomic,weak) NSObject<P_CoreData> *dataController;
    @property (nonatomic,weak) UIButton *addButton;
    @property (nonatomic,strong) DailyEditController *dailyEditor;
    @property (nonatomic,weak)  CentralViewController *parentController;
    @property (nonatomic,strong) UITableView *dailiesTable;
    @property (nonatomic,strong) NSMutableArray *incompleteItems;
    @property (nonatomic,strong) NSMutableArray *completeItems;
    @property (nonatomic,strong) DailyHelper *dailyHelper;

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

@synthesize addButton = _addButton;
-(UIButton *)addButton{
    if(_addButton == nil){
        _addButton = [self.view viewWithTag:1];
        [_addButton addTarget:self action:@selector(pressedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@synthesize dailyHelper = _dailyHelper;
-(DailyHelper *)dailyHelper{
    
    if(_dailyHelper){
        _dailyHelper = [[DailyHelper alloc] init];
    }
    return _dailyHelper;
}

-(id)initWithDataController:(NSObject<P_CoreData> *)dataController AndWithParent:(CentralViewController *)parent
{
    if(self = [self initWithNibName:@"DailyViewController" bundle:nil]){
        self.parentController = parent;
        [self setuptab:dataController];
        
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
    
    
    [self addButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuptab:(NSObject<P_CoreData> *)dataController{
    UITabBarItem *tbi = [self tabBarItem];
    [self setupData:dataController];
    
    
    [tbi setTitle:@"Dailies"];
}

-(void)showNewDaily:(Daily *)daily{
    [self.incompleteItems addObject:daily];
    [self.dailiesTable reloadData];
}

-(void)refreshTableAtRow:(NSIndexPath *)row{
    [self.dailiesTable reloadRowsAtIndexPaths:@[row] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)removeItemFromViewAtRow:(NSIndexPath *)rowInfo{
    if(rowInfo.section == INCOMPLETE){
        [self.incompleteItems removeObjectAtIndex:rowInfo.row];
        //todo reload by section
    }
    else{
        [self.completeItems removeObjectAtIndex:rowInfo.row];
        //reload by section
    }
    [self.dailiesTable reloadData];
}

-(void)completeDaily:(Daily *)daily{
    if(daily == self.incompleteItems[daily.rowNum]){
        [self.incompleteItems removeObjectAtIndex:daily.rowNum];
        [self.completeItems addObject:daily];
        [self.dailiesTable reloadData];
        //todo complete action
    }
    else{
        NSLog(@"Oh oh! Something illogical was about to happen. There was a mismatch in completeDaily.");
    }
}

-(void)undoCompletedDaily:(Daily *)daily{
    if(daily == self.completeItems[daily.rowNum]){
        [self.completeItems removeObjectAtIndex:daily.rowNum];
        [self.incompleteItems addObject:daily];
        [self.dailiesTable reloadData];
        //reverse complete action
    }
    else{
        NSLog(@"Oh oh! Something illogical was about to happen. There was a mismatch in completeDaily.");
    }
}

-(void)setupData:(NSObject<P_CoreData> *)data{
    //NSPredicate *unfinished = [NSPredicate predicateWithFormat:@"isActive = 1 AND "];
    
    self.dataController = data;
//    NSFetchedResultsController *resultsController = [self.dataController getItemFetcher:DAILY_ENTITY_NAME predicate:nil sortBy:[self getFetchDescriptors]];
    //NSError *error;
//    if(![resultsController performFetch:&error]){
//        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
//        return;
//    }
    self.completeItems = [NSMutableArray array];
    self.incompleteItems = [NSMutableArray array];
    
//    for(Daily *d in resultsController.fetchedObjects){
//        if([self.dailyHelper isDailyCompleteForTheDay:d]){
//            [self.completeItems addObject:d];
//        }
//        else{
//            [self.incompleteItems addObject:d];
//        }
//    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == INCOMPLETE){
        return [self.incompleteItems count];
    }
    else{
        return [self.completeItems  count];
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
        d = self.incompleteItems[indexPath.row];
    }
    else{
        d = self.completeItems[indexPath.row];
    }
    d.rowNum = indexPath.row;
    d.sectionNum = indexPath.section;
    [cell setupCell:d AndRow:indexPath];
    
    return cell;
}

-(NSArray *)getFetchDescriptors{
    NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
                                       initWithKey:@"urgency" ascending:NO];
    NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
                                          initWithKey:@"difficulty" ascending:YES];
    return [NSArray arrayWithObjects:sortByUrgency,sortByDifficulty, nil];
}

-(void)pressedAddBtn:(id)sender{
    DailyEditController *dailyEditor = [[DailyEditController alloc] initWithParentDailyController:self];
    EditNavigationController *editController = [[EditNavigationController alloc] initWithTitle:@"Add Daily" AndEditor:dailyEditor];
    [ViewHelper pushViewToFront:editController OfParent:self.parentController];
    //[self showViewController:editController sender:self];
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    void (^pressedEdit)(UITableViewRowAction *,NSIndexPath *) = ^(UITableViewRowAction *action,NSIndexPath *path){
        [self.dailyEditor loadExistingDailyForEditing:self.incompleteItems[indexPath.row] WithIndexPath:indexPath];
        //open edit screen
    };
    
    UITableViewRowAction *openEditBox = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:pressedEdit];
    
    return @[openEditBox];
}



@end
