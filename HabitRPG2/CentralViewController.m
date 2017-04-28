//
//  CentralViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define KVO_HERO_HP @"gold"
#define KVO_HERO_XP @"nowHp"
#define KVO_MONSTER_HP @"nowHp"
#define KVO_GOLD @"nowXp"
#define KVO_LVL @"lvl"

#import "CentralViewController.h"
#import "DailyViewController.h"
#import "HabitController.h"
#import "TodoViewController.h"
#import "GoodsViewController.h"
#import "MenuViewController.h"
#import "CoreDataStackController.h"
#import "P_CoreData.h"
#import "Settings+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "IntroViewController.h"
#import "ZoneChoiceViewController.h"
#import "constants.h"
#import "ViewHelper.h"
#import "ZoneHelper.h"
#import "CommonUtilities.h"
#import "SingletonCluster.h"
#import "MonsterHelper.h"

@import CoreGraphics;


@interface CentralViewController ()
@property (strong,nonatomic) UITabBarController *tabsController;
@end

@implementation CentralViewController

    
    
@synthesize nowMonster = _nowMonster;
@synthesize nowZone = _nowZone;

@synthesize editController = _editController;
-(EditNavigationController *)editController{
    if(_editController == nil){
        _editController = [[EditNavigationController alloc]initWithTitle:@""];
    }
    return _editController;
}

@synthesize dataController = _dataController;
-(NSObject<P_CoreData> *)dataController{
    if(_dataController == nil){
        _dataController = [SingletonCluster getSharedInstance].dataController;
    }
    return _dataController;
}

@synthesize userHero = _userHero;
-(Hero *)userHero{
    return [SingletonCluster getSharedInstance].dataController.userData.theHero;
}

@synthesize userSettings = _userSettings;
-(Settings *)userSettings{
    return [SingletonCluster getSharedInstance].dataController.userData.theSettings;
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
                                                [CommonUtilities GetYStart:height]
                                                ,width,
                                                height -
                                                [CommonUtilities GetYStart:height]);
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
    else{
        
    }
}

-(void)setToSkipStory:(BOOL)skipStory{
    self.userSettings.storyModeisOn = skipStory;
    [self.dataController save:self.userSettings];
}

-(void)showZoneChoiceView{
    NSArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:YES];
    ZoneChoiceViewController *zoneChoiceView = [ZoneChoiceViewController constructWithCentral:self AndZoneChoices:zoneChoices];
    [self.view addSubview:zoneChoiceView.view];
    [self addChildViewController:zoneChoiceView];
    [zoneChoiceView didMoveToParentViewController:self];
}

-(void)updateHeroHPBar:(int)part whole:(int)whole{}

-(void)updateHeroXPBar:(int)part whole:(int)whole{}

-(void)updateMonsterHPBar:(int)part whole:(int)whole{}

-(void)setupObservers{

    [self.userHero addObserver:self forKeyPath:KVO_HERO_HP options:NSKeyValueObservingOptionNew context:nil];
    [self.userHero addObserver:self forKeyPath:KVO_GOLD options:NSKeyValueObservingOptionNew context:nil];
    [self.userHero addObserver:self forKeyPath:KVO_HERO_XP options:NSKeyValueObservingOptionNew context:nil];
    [self.userHero addObserver:self forKeyPath:KVO_LVL options:NSKeyValueObservingOptionNew context:nil];
    [self.nowMonster addObserver:self forKeyPath:KVO_MONSTER_HP options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if([keyPath isEqualToString:KVO_HERO_HP]){
    
    }
    if([keyPath isEqualToString:KVO_GOLD]){}
    if([keyPath isEqualToString:KVO_HERO_XP]){}
    if([keyPath isEqualToString:KVO_LVL]){}
    if([keyPath isEqualToString:KVO_MONSTER_HP]){}
}

-(void)afterIntro:(Zone *)zoneChoice{
    self.nowZone = zoneChoice;
    self.nowZone.isFront = YES;
    self.nowMonster = [MonsterHelper constructRandomMonster:self.nowZone.zoneKey AroundLvl:self.nowZone.lvl];
    [self setupObservers];
    [self setupTabs];
}

-(void)showMonsterStory{
    
}


@end
