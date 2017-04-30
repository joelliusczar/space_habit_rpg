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
@property (weak,nonatomic) UIView *statsView;
@property (weak,nonatomic) UILabel *shipNameLbl;
@property (weak,nonatomic) UILabel *heroHPLbl;
@property (weak,nonatomic) UIProgressView *heroHPBar;
@property (weak,nonatomic) UILabel *monsterHPLbl;
@property (weak,nonatomic) UIProgressView *monsterHPBar;
@property (weak,nonatomic) UILabel *xpLbl;
@property (weak,nonatomic) UIProgressView *xpBar;
@property (weak,nonatomic) UILabel *lvlLbl;
@property (weak,nonatomic) UILabel *goldLbl;
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

@synthesize statsView = _statsView;
-(UIView *)statsView{
    if(!_statsView){
        _statsView = [self.view viewWithTag:1];
    }
    return _statsView;
}

@synthesize shipNameLbl = _shipNameLbl;
-(UILabel *)shipNameLbl{
    if(!_shipNameLbl){
        _shipNameLbl = [self.view viewWithTag:2];
    }
    return _shipNameLbl;
}

@synthesize heroHPLbl = _heroHPLbl;
-(UILabel *)heroHPLbl{
    if(!_heroHPLbl){
        _heroHPLbl = [self.view viewWithTag:3];
    }
    return _heroHPLbl;
}

@synthesize heroHPBar = _heroHPBar;
-(UIProgressView *)heroHPBar{
    if(!_heroHPBar){
        _heroHPBar = [self.view viewWithTag:4];
    }
    return _heroHPBar;
}

@synthesize monsterHPLbl = _monsterHPLbl;
-(UILabel *)monsterHPLbl{
    
    if(!_monsterHPLbl){
        _monsterHPLbl = [self.view viewWithTag:5];
    }
    return _monsterHPLbl;
}

@synthesize monsterHPBar = _monsterHPBar;
-(UIProgressView *)monsterHPBar{
    
    if(!_monsterHPBar){
        _monsterHPBar = [self.view viewWithTag:6];
    }
    return _monsterHPBar;
}

@synthesize xpLbl = _xpLbl;
-(UILabel *)xpLbl{
    
    if(!_xpLbl){
        _xpLbl = [self.view viewWithTag:7];
    }
    return _xpLbl;
}

@synthesize xpBar = _xpBar;
-(UIProgressView *)xpBar{
    
    if(!_xpBar){
        _xpBar = [self.view viewWithTag:8];
    }
    return _xpBar;
}

@synthesize lvlLbl = _lvlLbl;
-(UILabel *)lvlLbl{
    
    if(!_lvlLbl){
        _lvlLbl = [self.view viewWithTag:9];
    }
    return _lvlLbl;
}

@synthesize goldLbl = _goldLbl;
-(UILabel *)goldLbl{
    
    if(!_goldLbl){
        _goldLbl = [self.view viewWithTag:10];
    }
    return _goldLbl;
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

-(void)updateHeroHPUI:(int)part whole:(int)whole{
    self.heroHPLbl.text = [NSString stringWithFormat:@"HP:%d/%d",part,whole];
    float hpPercent = ((float)part)/whole;
    self.heroHPBar.progress = hpPercent;
}

-(void)updateHeroXPUI:(int)part whole:(int)whole{
    self.xpLbl.text = [NSString stringWithFormat:@"XP:%d/%d",part,whole];
    float xpPercent = ((float)part)/whole;
    self.xpBar.progress = xpPercent;
}

-(void)updateMonsterHPUI:(int)part whole:(int)whole{
    self.monsterHPLbl.text = [NSString stringWithFormat:@"HP:%d/%d",part,whole];
    float hpPercent = ((float)part)/whole;
    self.monsterHPBar.progress = hpPercent;
}

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
    self.nowMonster = [MonsterHelper constructRandomMonster:zoneChoice.zoneKey AroundLvl:zoneChoice.lvl];
    [self showMonsterStory];
    [self setupObservers];
    [self setupTabs];
}

-(void)showMonsterStory{
    if(self.userSettings.storyModeisOn){
        
    }
}


@end
