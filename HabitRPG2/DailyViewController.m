//
//  DailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyViewController.h"
#import "UIUtilities.h"
#import "CoreDataStackController.h"
#import "Daily.h"
#import "EditNavigationController.h"
#import "DailyEditController.h"
#import "DailyHelper.h"
#import "constants.h"
#import "DailyCellController.h"


@interface DailyViewController ()

@property (nonatomic,weak) CoreDataStackController *dataController;
@property (nonatomic,weak) EditNavigationController *editController;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,strong) DailyEditController *dailyEditor;
@property (nonatomic,weak)  BaseViewController *parentController;
@property (nonatomic,strong) UITableView *dailiesTable;
@property (nonatomic,strong) NSMutableArray *incompleteItems;
@property (nonatomic,strong) NSMutableArray *completeItems;
@property (nonatomic,strong) DailyHelper *helper;
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

@synthesize helper = _helper;
-(DailyHelper *)helper{
    if(_helper == nil){
        _helper = [[DailyHelper alloc]init];
    }
    
    return _helper;
}

-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParent:(BaseViewController *)parent{
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
        if([self.helper isDailyCompleteForTheDay:d]){
            [self.completeItems addObject:d];
        }
        else{
            [self.incompleteItems addObject:d];
        }
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.incompleteItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Daily *d = [self.incompleteItems objectAtIndex:indexPath.row];
    DailyCellController *cell = [DailyCellController getDailyCell:tableView WithParent:self];
    [cell setupModel:d];
    //cell.nameLbl.text = d.dailyName;

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
    [self showViewController:self.editController sender:self];
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    void (^pressedEdit)(UITableViewRowAction *,NSIndexPath *) = ^(UITableViewRowAction *action,NSIndexPath *path){
        [self.dailyEditor loadExistingDailyForEditing:[self.incompleteItems objectAtIndex:indexPath.row]];
        [self showViewController:self.editController sender:self];
    };
    
    UITableViewRowAction *openEditBox = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:pressedEdit];
    
    return @[openEditBox];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
