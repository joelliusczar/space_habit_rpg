//
//  DailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyViewController.h"
#import "constants.h"
#import "UIUtilities.h"
#import "EditNavigationController.h"
#import "DailyEditController.h"
#import "DailyHelper.h"
#import "DailyCellController.h"
#import "IntroViewController.h"


@interface DailyViewController ()

@property (nonatomic,weak) CoreDataStackController *dataController;
@property (nonatomic,weak) EditNavigationController *editController;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,strong) DailyEditController *dailyEditor;
@property (nonatomic,weak)  CentralViewController *parentController;
@property (nonatomic,strong) UITableView *dailiesTable;
@property (nonatomic,strong) NSMutableArray *incompleteItems;
@property (nonatomic,strong) NSMutableArray *completeItems;
@property (nonatomic,strong) DailyHelper *dailyHelper;
@property (nonatomic,strong) CommonUtilities *util;

@end

@implementation DailyViewController

static NSString *const EntityName = @"Daily";

@synthesize editController = _editController;
-(EditNavigationController *)editController{
    if(_editController == nil){
        _editController = self.parentController.editController;
    }
    return _editController;
}

@synthesize dailyEditor = _dailyEditor;
-(DailyEditController *)dailyEditor{
    if(_dailyEditor == nil){
        _dailyEditor = [[DailyEditController alloc]initWithDataController:self.dataController AndWithParentDailyController:self];
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

@synthesize util = _util;
-(CommonUtilities *)util{
    if(_util == nil){
        _util = [[CommonUtilities alloc] init];
    }
    return _util;
}

@synthesize dailyHelper = _dailyHelper;
-(DailyHelper *)dailyHelper{
    
    if(_dailyHelper){
        _dailyHelper = [[DailyHelper alloc] init];
    }
    return _dailyHelper;
}

-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParent:(CentralViewController *)parent{
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
    CGFloat viewHeight = self.view.frame.size.height - [UIUtilities GetYStartUnderLabel:height];
    self.dailiesTable.frame = CGRectMake(0, minY + [UIUtilities GetYStartUnderLabel:height],
                                                       width,
                                                       viewHeight);
    self.dailiesTable.delegate = self;
    self.dailiesTable.dataSource = self;
    
    
    [self addButton];

    [self.editController setupTaskEditor:self.dailyEditor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuptab:(CoreDataStackController *)dataController{
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
    if(daily == [self.incompleteItems objectAtIndex:daily.rowNum]){
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
    if(daily == [self.completeItems objectAtIndex:daily.rowNum]){
        [self.completeItems removeObjectAtIndex:daily.rowNum];
        [self.incompleteItems addObject:daily];
        [self.dailiesTable reloadData];
        //reverse complete action
    }
    else{
        NSLog(@"Oh oh! Something illogical was about to happen. There was a mismatch in completeDaily.");
    }
}

-(void)setupData:(CoreDataStackController *)data{
    self.dataController = data;
    NSFetchedResultsController *resultsController = [self.dataController getItemFetcher:DAILY_ENTITY_NAME predicate:nil sortBy:[self getFetchDescriptors]];
    NSError *error;
    if(![resultsController performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        return;
    }
    self.completeItems = [NSMutableArray array];
    self.incompleteItems = [NSMutableArray array];
    
    for(Daily *d in resultsController.fetchedObjects){
        if([self.dailyHelper isDailyCompleteForTheDay:d]){
            [self.completeItems addObject:d];
        }
        else{
            [self.incompleteItems addObject:d];
        }
    }
    
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
        d = [self.incompleteItems objectAtIndex:indexPath.row];
    }
    else{
        d = [self.completeItems objectAtIndex:indexPath.row];
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
    self.editController.viewTitle = @"Dailies";
    [self showViewController:self.editController sender:self];
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    void (^pressedEdit)(UITableViewRowAction *,NSIndexPath *) = ^(UITableViewRowAction *action,NSIndexPath *path){
        [self.dailyEditor loadExistingDailyForEditing:[self.incompleteItems objectAtIndex:indexPath.row] WithIndexPath:indexPath];
        [self showViewController:self.editController sender:self];
    };
    
    UITableViewRowAction *openEditBox = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:pressedEdit];
    
    return @[openEditBox];
}



@end
