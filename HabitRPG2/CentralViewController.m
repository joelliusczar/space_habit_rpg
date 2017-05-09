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
#import "StoryDumpView.h"

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
    if(_statsView==nil){
        _statsView = [self.view viewWithTag:1];
    }
    return _statsView;
}

@synthesize shipNameLbl = _shipNameLbl;
-(UILabel *)shipNameLbl{
    if(_shipNameLbl==nil){
        _shipNameLbl = [self.statsView viewWithTag:2];
    }
    return _shipNameLbl;
}

@synthesize heroHPLbl = _heroHPLbl;
-(UILabel *)heroHPLbl{
    if(_heroHPLbl==nil){
        _heroHPLbl = [self.statsView viewWithTag:3];
    }
    return _heroHPLbl;
}

@synthesize heroHPBar = _heroHPBar;
-(UIProgressView *)heroHPBar{
    if(_heroHPBar==nil){
        _heroHPBar = [self.statsView viewWithTag:4];
    }
    return _heroHPBar;
}

@synthesize monsterHPLbl = _monsterHPLbl;
-(UILabel *)monsterHPLbl{
    
    if(_monsterHPLbl==nil){
        _monsterHPLbl = [self.statsView viewWithTag:5];
    }
    return _monsterHPLbl;
}

@synthesize monsterHPBar = _monsterHPBar;
-(UIProgressView *)monsterHPBar{
    
    if(_monsterHPBar==nil){
        _monsterHPBar = [self.statsView viewWithTag:6];
    }
    return _monsterHPBar;
}

@synthesize xpLbl = _xpLbl;
-(UILabel *)xpLbl{
    
    if(_xpLbl==nil){
        _xpLbl = [self.statsView viewWithTag:7];
    }
    return _xpLbl;
}

@synthesize xpBar = _xpBar;
-(UIProgressView *)xpBar{
    
    if(_xpBar==nil){
        _xpBar = [self.statsView viewWithTag:8];
    }
    return _xpBar;
}

@synthesize lvlLbl = _lvlLbl;
-(UILabel *)lvlLbl{
    
    if(_lvlLbl==nil){
        _lvlLbl = [self.statsView viewWithTag:9];
    }
    return _lvlLbl;
}

@synthesize goldLbl = _goldLbl;
-(UILabel *)goldLbl{
    
    if(_goldLbl==nil){
        _goldLbl = [self.statsView viewWithTag:10];
    }
    return _goldLbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonUtilities checkForAndApplyVisualChanges:self.view];
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

-(void)showNormalView{
    Zone *z = [ZoneHelper getZone:YES];
    if(z==nil){
        NSMutableArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:NO];
        [self showZoneChoiceView:zoneChoices];
        return;
    }
    self.nowZone = z;
    Monster *m = [MonsterHelper getCurrentMonster];
    if(m==nil){
        if(z.monstersKilled>=z.maxMonsters){
            NSMutableArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:NO];
            [zoneChoices addObject:z];
            [self showZoneChoiceView:zoneChoices];
            return;
        }
        self.nowMonster = [MonsterHelper constructRandomMonster:z.zoneKey AroundLvl:z.lvl];
        [SHData save:self.nowMonster];
        [self showMonsterStory];
    }
    self.nowMonster = m;
    if(self.nowMonster.nowHp<=0){
        self.nowMonster = [MonsterHelper constructRandomMonster:z.zoneKey AroundLvl:z.lvl];
        [SHData save:self.nowMonster];
        [self showMonsterStory];
    }
}


-(void)determineIfFirstTimeAndSetupSettings{
    if(self.dataController.userData.theDataInfo.gameState == GAME_STATE_UNINITIALIZED){
        [self showIntroView];        
    }
    else{
        
    }
}

-(void)setToShowStory:(BOOL)shouldShowStory{
    self.userSettings.storyModeisOn = shouldShowStory;
    [self.dataController save:self.userSettings];
}

-(void)showZoneChoiceView:(NSArray<Zone *> *)zoneChoices{
    ZoneChoiceViewController *zoneChoiceView = [ZoneChoiceViewController constructWithCentral:self AndZoneChoices:zoneChoices];
    [self.view addSubview:zoneChoiceView.view];
    [self addChildViewController:zoneChoiceView];
    [zoneChoiceView didMoveToParentViewController:self];
}

-(void)showZoneChoiceView{
    NSArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:YES];
    [self showZoneChoiceView:zoneChoices];
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

-(void)setupHeroObservers{
    @try{
        [self.userHero removeObserver:self forKeyPath:KVO_HERO_HP context:nil];
    }
    @catch(NSException *ex){}
    [self.userHero addObserver:self forKeyPath:KVO_HERO_HP options:NSKeyValueObservingOptionNew context:nil];
    
    @try{
        [self.userHero removeObserver:self forKeyPath:KVO_GOLD context:nil];
    }
    @catch(NSException *ex){}
    [self.userHero addObserver:self forKeyPath:KVO_GOLD options:NSKeyValueObservingOptionNew context:nil];
    
    @try{
        [self.userHero removeObserver:self forKeyPath:KVO_HERO_XP context:nil];
    }
    @catch(NSException *ex){}
    [self.userHero addObserver:self forKeyPath:KVO_HERO_XP options:NSKeyValueObservingOptionNew context:nil];
    
    @try{
        [self.userHero removeObserver:self forKeyPath:KVO_LVL context:nil];
    }
    @catch(NSException *ex){}
    [self.userHero addObserver:self forKeyPath:KVO_LVL options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)setupMonsterObservers{
    @try{
        [self.nowMonster removeObserver:self forKeyPath:KVO_MONSTER_HP context:nil];
    }
    @catch(NSException *ex){}
    [self.nowMonster addObserver:self forKeyPath:KVO_MONSTER_HP options:NSKeyValueObservingOptionNew context:nil];
}

-(void)setupObservers{
    //TODO; figure out object observation consistency, ie, if we replace monster, is it still being observed?
    [self setupHeroObservers];
    [self setupMonsterObservers];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if([keyPath isEqualToString:KVO_HERO_HP]){
        [self updateHeroHPUI:self.userHero.nowHp whole:self.userHero.maxHp];
    }
    if([keyPath isEqualToString:KVO_GOLD]){
        self.goldLbl.text = [NSString stringWithFormat:@"$%.2f",self.userHero.gold];
    }
    if([keyPath isEqualToString:KVO_HERO_XP]){
        [self updateHeroXPUI:self.userHero.nowXp whole:self.userHero.maxXp];
    }
    if([keyPath isEqualToString:KVO_LVL]){
        self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%d",self.userHero.lvl];
    }
    if([keyPath isEqualToString:KVO_MONSTER_HP]){
        [self updateMonsterHPUI:self.nowMonster.nowHp whole:self.nowMonster.maxHp];
    }
}

-(void)afterZonePick:(Zone *)zoneChoice{
    NSSet<NSManagedObject *> *zSet = [NSSet setWithObject:zoneChoice];
    [SHData removeInsertedNotInSet:zSet];
    if(zoneChoice==nil){
        zoneChoice = [ZoneHelper constructZoneChoice:self.userHero AndMatchHeroLvl:NO];
    }
    if([SingletonCluster getSharedInstance].gameState==GAME_STATE_UNINITIALIZED){
        [self afterIntro];
    }
    else{
        [self afterNormalZonePick:zoneChoice];
    }
    self.nowZone = zoneChoice;
    [ZoneHelper moveZoneToFront:zoneChoice];
    self.nowMonster = [MonsterHelper constructRandomMonster:zoneChoice.zoneKey AroundLvl:zoneChoice.lvl];
    [self.dataController save:self.nowZone];
    [self.dataController save:self.nowMonster];
    [self showMonsterStory];
}

-(void)afterNormalZonePick:(Zone *)zoneChoice{
    
}

-(void)afterIntro{
    [self initializeStatesView];
    self.statsView.hidden = NO;
    [self setupObservers];
    [self setupTabs];
    self.dataController.userData.theDataInfo.gameState = GAME_STATE_INITIALIZED;
    self.userSettings.createDate = [NSDate date];
    [self.dataController save:self.dataController.userData.theDataInfo];
    [self.dataController save:self.userSettings];
}

-(void)initializeStatesView{
    [self updateHeroHPUI:self.userHero.nowHp whole:self.userHero.maxHp];
    self.goldLbl.text = [NSString stringWithFormat:@"$%.2f",self.userHero.gold];
    [self updateHeroXPUI:self.userHero.nowXp whole:self.userHero.maxXp];
    self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%d",self.userHero.lvl];
    [self updateMonsterHPUI:self.nowMonster.nowHp whole:self.nowMonster.maxHp];
}

-(void)showMonsterStory{
    if(self.userSettings.storyModeisOn){
        StoryDumpView *sdv = [[StoryDumpView alloc] initWithStoryItem:self.nowMonster];
        [ViewHelper pushViewToFront:sdv OfParent:self];
    }
}


@end
