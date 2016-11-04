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
#import "CoreDataStackController.h"
#import "Settings.h"
#import "Zone.h"
#import "Hero.h"
#import "Monster.h"
#import "IntroViewController.h"

@import CoreGraphics;


@interface BaseViewController ()

@property (strong,nonatomic) UITabBarController *tabsController;
@property (nonatomic,strong) Settings *userSettings;
@property (nonatomic,strong) Hero *userHero;
@property (nonatomic,strong) Zone *nowZone;
@property (nonatomic,strong) Monster *nowMonsters;
@end

@implementation BaseViewController

@synthesize editController = _editController;
-(EditNavigationController *)editController{
    if(_editController == nil){
        _editController = [[EditNavigationController alloc]initWithTitle:@""];
    }
    return _editController;
}

@synthesize dataController = _dataController;
-(CoreDataStackController *)dataController{
    if(_dataController == nil){
        _dataController = [[CoreDataStackController alloc] init];
    }
    return _dataController;
}

@synthesize tabsController = _tabsController;
-(UITabBarController *)tabsController{
    if(_tabsController == nil){
        _tabsController = [[UITabBarController alloc] init];
    }
    return _tabsController;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self determineIfFirstTimeAndSetupSettings];

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabs {
    DailyViewController* dc = [[DailyViewController alloc]initWithDataController:self.dataController AndWithParent:self];
    
    HabitController* hc = [[HabitController alloc]
                           initWithNibName:@"HabitController"
                           bundle:nil];
    [hc setuptab];
    
    TodoViewController* tc = [[TodoViewController alloc]
                              initWithNibName:@"TodoViewController"
                              bundle:nil];
    [tc setuptab];
    
    GoodsViewController* gc = [[GoodsViewController alloc]
                               initWithNibName:@"GoodsViewController"
                               bundle:nil];
    [gc setuptab];
    MenuViewController* mc = [[MenuViewController alloc]
                              initWithNibName:@"MenuViewController"
                              bundle:nil];
    [mc setuptab];
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

-(void)determineIfFirstTimeAndSetupSettings{
    NSSortDescriptor *sortByAnything = [[NSSortDescriptor alloc]
                                        initWithKey:@"createDate" ascending:NO];
    
    NSFetchedResultsController *settingsFetchController = [self.dataController getItemFetcher:SETTINGS_ENTITY_NAME predicate:nil sortBy:@[sortByAnything]];
    NSError *err;
    if(![settingsFetchController performFetch:&err]){
        [NSException raise:@"Error fetching data" format:@"%@",err.localizedFailureReason];
        
    }
    if([settingsFetchController.fetchedObjects count] == 0){
        self.userSettings = (Settings *)[self.dataController constructEmptyEntity:SETTINGS_ENTITY_NAME];
        IntroViewController *introView = [[IntroViewController alloc] initWithBaseViewController:self];
        
        [self.view addSubview:introView.view];
        
        [self addChildViewController:introView];
        [introView didMoveToParentViewController:self];
        
    }
    else{
        self.userSettings = [settingsFetchController.fetchedObjects objectAtIndex:0];
    }
    
}

-(void)setupSettingsAndLoadIntroView{
    NSSortDescriptor *sortByAnything = [[NSSortDescriptor alloc]
                                        initWithKey:@"createDate" ascending:NO];
    
    NSFetchedResultsController *settingsFetchController = [self.dataController getItemFetcher:SETTINGS_ENTITY_NAME predicate:nil sortBy:@[sortByAnything]];
    NSError *err;
    if(![settingsFetchController performFetch:&err]){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return;
    }
    if([settingsFetchController.fetchedObjects count] == 0){
        self.userSettings = (Settings *)[self.dataController constructEmptyEntity:SETTINGS_ENTITY_NAME];
        IntroViewController *introView = [[IntroViewController alloc] initWithBaseViewController:self];
        
        
        [self showViewController:introView sender:self];
        
        
    }
    else{
        self.userSettings = [settingsFetchController.fetchedObjects objectAtIndex:0];
    }
}

- (void)setupHero {
    NSFetchedResultsController *heroFetchController = [self.dataController getItemFetcher:HERO_ENTITY_NAME predicate:nil sortBy:nil];
    NSError *err;
    if(![heroFetchController performFetch:&err]){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return;
    }
    if([heroFetchController.fetchedObjects count] == 0){
        //do new user action
    }
    else{
        self.userHero = [heroFetchController.fetchedObjects objectAtIndex:0];
    }
}

-(void)setupData{
    [self setupHero];
}

-(void)doActionForCompletedDaily:(Daily *)daily{
    
}

-(void)undoActionForCompletedDaily:(Daily *)daily{

}

-(void)setToSkipStory:(BOOL)skipStory{
    self.userSettings.storyModeisOn = skipStory;
    [self.dataController save];
    
}
-(void)dismissIntro{}

@end
