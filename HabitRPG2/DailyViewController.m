//
//  DailyViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyViewController.h"
#import "DailyTablesViewController.h"
#import "UIUtilities.h"
#import "CoreDataStackController.h"
#import "Daily.h"
#import "EditNavigationController.h"

@interface DailyViewController ()

@property (nonatomic,strong) DailyTablesViewController *dailyTablesController;
@property (nonatomic,strong) CoreDataStackController *dataController;
@property (nonatomic,strong) EditNavigationController *editController;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,strong) UIView *dailyEditView;

@end

@implementation DailyViewController

static NSString *const EntityName = @"Daily";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dailyTablesController = [[DailyTablesViewController alloc]
                                  initWithNibName:@"DailyTablesViewController"
                                  bundle:nil];
    [self.dailyTablesController setupData:self.dataController];
    [self.view addSubview:self.dailyTablesController.view];
    [self addChildViewController:self.dailyTablesController];
    [self.dailyTablesController didMoveToParentViewController:self];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat minY = self.view.frame.origin.y;
    CGFloat viewHeight = self.view.frame.size.height - [UIUtilities GetYStartUnderLabel:height];
    self.dailyTablesController.view.frame = CGRectMake(0, minY + [UIUtilities GetYStartUnderLabel:height],
                                                       width,
                                                       viewHeight);
    [self.dailyTablesController setupData:self.dataController];
    
    self.addButton = [self.view viewWithTag:1];
    [self.addButton addTarget:self action:@selector(pressedAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"DailyEditView" owner:self options:nil];
    self.dailyEditView = [subviewArray objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuptab:(CoreDataStackController *)dataController{
    self.dataController = dataController;
    UITabBarItem *tbi = [self tabBarItem];
    
    
    
    [tbi setTitle:@"Dailies"];
}

-(void)pressedAddBtn:(id)sender{
//    Daily *d = (Daily *)[self.dataController constructEmptyEntity:EntityName];
//    d.dailyName = @"it's a daily";
//    d.difficulty = @2;
//    d.urgency = @2;
//    
//    [self.dataController Save];
//    [self.dailyTablesController addNewDailyToView:d];
    self.editController = [[EditNavigationController alloc]initWithNibName:@"EditNavigationController" bundle:nil];
    [self.editController setupView:self.dailyEditView];
    [self showViewController:self.editController sender:self];
    
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
