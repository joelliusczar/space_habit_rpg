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
#import "DailyEditController.h"

@interface DailyViewController ()

@property (nonatomic,strong) DailyTablesViewController *dailyTablesController;
@property (nonatomic,weak) CoreDataStackController *dataController;
@property (nonatomic,weak) EditNavigationController *editController;
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic,strong) DailyEditController *dailyEditor;
@property (nonatomic,weak)  BaseViewController *parentController;

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

-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParent:(BaseViewController *)parent{
    if(self = [self initWithNibName:@"DailyViewController" bundle:nil]){
        self.parentController = parent;
        [self setuptab:dataController];
    }
    return self;
}


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
    
    [self addButton];
    

    [self.editController setupTaskEditor:self.dailyEditor];
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

-(void)showNewDaily:(Daily *)daily{
    [self.dailyTablesController addNewDailyToView:daily];
}

-(void)pressedAddBtn:(id)sender{
//    Daily *d = (Daily *)[self.dataController constructEmptyEntity:EntityName];
//    d.dailyName = @"it's a daily";
//    d.difficulty = @2;
//    d.urgency = @2;
//    
//    [self.dataController Save];
//    [self.dailyTablesController addNewDailyToView:d];
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
