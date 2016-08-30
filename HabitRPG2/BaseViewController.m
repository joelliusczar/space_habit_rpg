//
//  BaseViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "BaseViewController.h"
#import "DailyViewController.h"
#import "HabitController.h"
#import "TodoViewController.h"
#import "GoodsViewController.h"
#import "MenuViewController.h"
#import "UIUtilities.h"

@import CoreGraphics;


@interface BaseViewController ()

@property (strong,nonatomic) UITabBarController *tabsController;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabsController = [[UITabBarController alloc] init];
    
    DailyViewController* dc = [[DailyViewController alloc]
                               initWithNibName:@"DailyViewController"
                               bundle:nil];
    [self setUpDailyTab:dc];
    
    HabitController* hc = [[HabitController alloc]
                           initWithNibName:@"HabitController"
                           bundle:nil];
    [self setUpHabitsTab:hc];
    
    TodoViewController* tc = [[TodoViewController alloc]
                              initWithNibName:@"TodoViewController"
                              bundle:nil];
    [self setUpTodoTab:tc];
    
    GoodsViewController* gc = [[GoodsViewController alloc]
                               initWithNibName:@"GoodsViewController"
                               bundle:nil];
    [self setUpGoodsTab:gc];
    MenuViewController* mc = [[MenuViewController alloc]
                              initWithNibName:@"MenuViewController"
                              bundle:nil];
    [self setUpMenuTab:mc];
    NSArray* controllers = [NSArray arrayWithObjects:dc,hc,tc,gc,mc,nil];
    
    self.tabsController.viewControllers = controllers;
    
    
    [self.view addSubview:self.tabsController.view];
    [self addChildViewController:self.tabsController];
    
    [self.tabsController didMoveToParentViewController:self];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    self.tabsController.view.frame = CGRectMake(0,
                                                [UIUtilities GetYStart:height]
                                                ,width,
                                                height -
                                                [UIUtilities GetYStart:height]);
    
    
}

-(void)setUpDailyTab:(DailyViewController *)controller{
    UITabBarItem *tbi = [controller tabBarItem];
    
    [tbi setTitle:@"Dailies"];
}

-(void)setUpHabitsTab:(HabitController *)controller{
    UITabBarItem *tbi = [controller tabBarItem];
    
    [tbi setTitle:@"Habits"];
}

-(void)setUpTodoTab:(TodoViewController *)controller{
    UITabBarItem *tbi = [controller tabBarItem];
    
    [tbi setTitle:@"To-dos"];
}

-(void)setUpGoodsTab:(GoodsViewController *)controller{
    UITabBarItem *tbi = [controller tabBarItem];
    
    [tbi setTitle:@"Goods"];
}

-(void)setUpMenuTab:(MenuViewController *)controller{
    UITabBarItem *tbi = [controller tabBarItem];
    
    [tbi setTitle:@"Menu"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
