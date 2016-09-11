//
//  DailyTablesViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/31/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyTablesViewController.h"
#import "DailyCellController.h"
#import "CoreDataStackController.h"
#import "Daily.h"
#import "DailyHelper.h"


@interface DailyTablesViewController ()
@property (nonatomic,strong) UITableView *dailyTable;
@property (nonatomic,strong) CoreDataStackController *dataController;
@property (nonatomic,strong) NSMutableArray *incompleteItems;
@property (nonatomic,strong) NSMutableArray *completeItems;
@property (nonatomic,strong) NSString *entityName;
@end

@implementation DailyTablesViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.dailyTable = [[UITableView alloc] init];
    
    self.dailyTable.delegate = self;
    self.dailyTable.dataSource = self;
    
    

    
    self.view = self.dailyTable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData:(CoreDataStackController *)data{
    self.dataController = data;
    self.entityName = @"Daily";

    NSFetchedResultsController *resultsController = [self.dataController getItemFetcher:self.entityName predicate:nil sortBy:[self getFetchDescriptors]];
    NSError *error;
    if(![resultsController performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        return;
    }
    self.completeItems = [NSMutableArray array];
    self.incompleteItems = [NSMutableArray array];
    
    for(Daily *d in resultsController.fetchedObjects){
        if([DailyHelper isDailyCompleteForTheDay:d]){
            [self.completeItems addObject:d];
        }
        else{
            [self.incompleteItems addObject:d];
        }
    }
//    Daily *d1 = (Daily *)[self.dataController constructEmptyEntity:self.entityName];
//    d1.dailyName = @"rake leaves";
//    d1.urgency = @5;
//    d1.difficulty = @7;
//    
//    Daily *d2 = (Daily *)[self.dataController constructEmptyEntity:self.entityName];
//    d2.dailyName = @"burninate leaves";
//    d2.urgency = @5;
//    d2.difficulty = @7;
//    
//    Daily *d3 = (Daily *)[self.dataController constructEmptyEntity:self.entityName];
//    d3.dailyName = @"clean up the ashes of your enemies.";
//    d3.urgency = @5;
//    d3.difficulty = @7;
//    [self.dataController Save];
//    
//    self.tableData = [NSArray arrayWithObjects:d1,d2,d3, nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.incompleteItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"DailyCell";
    DailyCellController *cell = (DailyCellController *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DailyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    Daily *d = [self.incompleteItems objectAtIndex:indexPath.row];
    cell.nameLbl.text =   d.dailyName;
    NSLog(@"In cell");
    return cell;
}

-(NSArray *)getFetchDescriptors{
    NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
                                       initWithKey:@"urgency" ascending:NO];
    NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
                                          initWithKey:@"difficulty" ascending:YES];
    return [NSArray arrayWithObjects:sortByUrgency,sortByDifficulty, nil];
}

-(void)addNewDailyToView:(Daily *)daily{
    [self.incompleteItems addObject:daily];
    [self.dailyTable reloadData];
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
