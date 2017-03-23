//
//  CentralViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CentralViewController.h"
#import "DailyViewController.h"
#import "HabitController.h"
#import "TodoViewController.h"
#import "GoodsViewController.h"
#import "MenuViewController.h"
#import "UIUtilities.h"
#import "CoreDataStackController.h"
#import "Settings+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "IntroViewController.h"
#import "ZoneChoiceViewController.h"
#import "constants.h"
#import "ViewHelper.h"
#import "ZoneHelper.h"

@import CoreGraphics;


@interface CentralViewController ()
@property (strong,nonatomic) UITabBarController *tabsController;
@end

@implementation CentralViewController

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


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTabs {
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

-(void)showIntroView{
    IntroViewController *introView = [[IntroViewController alloc]
                                          initWithCentralViewController:self];
    [self.view addSubview:introView.view];
    [self addChildViewController:introView];
    [introView didMoveToParentViewController:self];
}

-(void)determineIfFirstTimeAndSetupSettings{
    if(self.dataController.userData.theDataInfo.isNew){
        [self showIntroView];        
    }
    
}

-(void)setupData{
    self.userSettings = self.dataController.userData.theSettings;
    self.userHero = self.dataController.userData.theHero;
}

-(void)doActionForCompletedDaily:(Daily *)daily{
    
}

-(void)undoActionForCompletedDaily:(Daily *)daily{

}

-(void)setToSkipStory:(BOOL)skipStory{
    self.userSettings.storyModeisOn = skipStory;
    [self.dataController save];
    
}

-(void)showZoneChoiceView{
    NSArray<Zone *> *zoneChoices = [ZoneHelper setupForAndGetZoneChoices:
                                    self.dataController];
    ZoneChoiceViewController *zoneChoiceView = [ZoneChoiceViewController constructWithCentral:self AndZoneChoices:zoneChoices];
    [self.view addSubview:zoneChoiceView.view];
    [self addChildViewController:zoneChoiceView];
    [zoneChoiceView didMoveToParentViewController:self];
}

-(void)afterIntro:(Zone *)firstZone{
    [self setupTabs];
}

@end
