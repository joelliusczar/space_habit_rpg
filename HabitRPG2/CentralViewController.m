//
//  CentralViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#define KVO_HERO_HP @"userHero.nowHp"
#define KVO_HERO_XP @"userHero.nowXp"
#define KVO_MONSTER_HP @"nowMonster.nowHp"
#define KVO_GOLD @"userHero.gold"
#define KVO_LVL @"userHero.lvl"
#define KVO_MON_NAME @"nowMonster.fullName"
#define KVO_ZONE_NAME @"nowZone.fullName"

#import "CentralViewController.h"
#import "DailyViewController.h"
#import "HabitController.h"
#import "TodoViewController.h"
#import "GoodsViewController.h"
#import "MenuViewController.h"
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
#import "ZoneTransaction+CoreDataClass.h"
#import "MonsterTransaction+CoreDataClass.h"
#import "NSObject+Helper.h"

@import CoreGraphics;

@interface CentralViewController ()
@property (strong,nonatomic) UITabBarController *tabsController;
@property (weak,nonatomic) IBOutlet UIView *statsView;
@property (weak,nonatomic) IBOutlet UILabel *heroDescLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *heroHPBar;
@property (weak,nonatomic) IBOutlet UILabel *monsterDescLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *monsterHPBar;
@property (weak,nonatomic) IBOutlet UILabel *xpLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *xpBar;
@property (weak,nonatomic) IBOutlet UILabel *lvlLbl;
@property (weak,nonatomic) IBOutlet UILabel *goldLbl;
@end

@implementation CentralViewController

    
    
@synthesize nowMonster = _nowMonster;
@synthesize nowZone = _nowZone;

@synthesize dataController = _dataController;
-(NSObject<P_CoreData> *)dataController{
    if(_dataController == nil){
        _dataController = [SingletonCluster getSharedInstance].dataController;
    }
    return _dataController;
}

@synthesize userHero = _userHero;
-(Hero *)userHero{
    return [SingletonCluster getSharedInstance].
    dataController.userData.theHero;
}

@synthesize userSettings = _userSettings;
-(Settings *)userSettings{
    return [SingletonCluster getSharedInstance].
    dataController.userData.theSettings;
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
    [CommonUtilities checkForAndApplyVisualChanges:self.view];
    //most likely any changes you want to add to load should go in
    //determineIfFirstTimeAndSetupSettings
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
    DailyViewController* dc = [[DailyViewController alloc]initWithParent:self];
    
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
    self.tabsController.view.frame =
    CGRectMake(0,
               [CommonUtilities GetYStart:height],
               width,height -[CommonUtilities GetYStart:height]);
}

-(void)showIntroView{
    IntroViewController *introView = [[IntroViewController alloc]
                                          initWithCentralViewController:self];
    [self.view addSubview:introView.view];
    [self addChildViewController:introView];
    [introView didMoveToParentViewController:self];
}

-(void)setupNormalZoneAndMonster{
    Zone *z = [ZoneHelper getZone:YES];
    if(z==nil){
        NSMutableArray<Zone *> *zoneChoices =
        [ZoneHelper constructMultipleZoneChoices:self.userHero
                                 AndMatchHeroLvl:NO];
        
        [self showZoneChoiceView:zoneChoices];
        return;
    }
    self.nowZone = z;
    Monster *m = [MonsterHelper getCurrentMonster];
    if(m==nil||m.nowHp<1){
        z.monstersKilled=
        (m!=nil&&m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
        
        if(z.monstersKilled>=z.maxMonsters){
            NSMutableArray<Zone *> *zoneChoices =
            [ZoneHelper constructMultipleZoneChoices:self.userHero
                                     AndMatchHeroLvl:NO];
            
            [zoneChoices addObject:z];
            [self showZoneChoiceView:zoneChoices];
            //setups observers after user has picked zones
            return;
        }
        m = [MonsterHelper constructRandomMonster:z.zoneKey AroundLvl:z.lvl];
        [SHData save];
        [self showMonsterStory];
    }
    self.nowMonster = m;
}


-(void)determineIfFirstTimeAndSetupSettings{
    if(self.dataController.userData.theDataInfo.gameState ==
       GAME_STATE_UNINITIALIZED){
        
        [self showIntroView];        
    }
    else{
        [self setupNormalZoneAndMonster];
        [self initializeStatesView];
        self.statsView.hidden = NO;
        [self setupObservers];
        [self setupTabs];
    }
}

-(void)setToShowStory:(BOOL)shouldShowStory{
    self.userSettings.storyModeisOn = shouldShowStory;
}

-(void)showZoneChoiceView:(NSArray<Zone *> *)zoneChoices{
    ZoneChoiceViewController *zoneChoiceView =
    [ZoneChoiceViewController constructWithCentral:self
                                    AndZoneChoices:zoneChoices];
    
    [self.view addSubview:zoneChoiceView.view];
    [self addChildViewController:zoneChoiceView];
    [zoneChoiceView didMoveToParentViewController:self];
}

-(void)showZoneChoiceView{
    NSArray<Zone *> *zoneChoices =
    [ZoneHelper constructMultipleZoneChoices:self.userHero
                             AndMatchHeroLvl:YES];
    
    [self showZoneChoiceView:zoneChoices];
}

-(void)updateHeroHPUI:(int)part whole:(int)whole{
    self.heroDescLbl.text = [NSString stringWithFormat:@"HP:%d/%d",part,whole];
    float hpPercent = ((float)part)/whole;
    self.heroHPBar.progress = hpPercent;
}

-(void)updateHeroXPUI:(int)part whole:(int)whole{
    self.xpLbl.text = [NSString stringWithFormat:@"XP:%d/%d",part,whole];
    float xpPercent = ((float)part)/whole;
    self.xpBar.progress = xpPercent;
}

-(void)updateMonsterHPUI:(int)part whole:(int)whole{
    self.monsterDescLbl.text =
    [NSString stringWithFormat:@"%@ Lvl:%d HP:%d/%d",
     self.nowMonster.fullName,self.nowMonster.lvl, part,whole];
    
    float hpPercent = ((float)part)/whole;
    self.monsterHPBar.progress = hpPercent;
}


-(void)setupObservers{
    [self addObserver:self forKeyPath:KVO_HERO_HP
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:KVO_GOLD
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:KVO_HERO_XP
              options:NSKeyValueObservingOptionNew context:nil];

    [self addObserver:self forKeyPath:KVO_LVL
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:KVO_MONSTER_HP
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:KVO_MON_NAME
              options:NSKeyValueObservingOptionNew context:nil];
    
    [self addObserver:self forKeyPath:KVO_ZONE_NAME
              options:NSKeyValueObservingOptionNew context:nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if([keyPath isEqualToString:KVO_HERO_HP]){
        [self updateHeroHPUI:self.userHero.nowHp whole:self.userHero.maxHp];
    }
    if([keyPath isEqualToString:KVO_GOLD]){
        self.goldLbl.text =
        [NSString stringWithFormat:@"$%.2f",self.userHero.gold];
    }
    if([keyPath isEqualToString:KVO_HERO_XP]){
        [self updateHeroXPUI:self.userHero.nowXp whole:self.userHero.maxXp];
    }
    if([keyPath isEqualToString:KVO_LVL]){
        self.lvlLbl.text =
        [NSString stringWithFormat:@"Lv:%d",self.userHero.lvl];
    }
    if([keyPath isEqualToString:KVO_MONSTER_HP]){
        [self updateMonsterHPUI:self.nowMonster.nowHp
                          whole:self.nowMonster.maxHp];
    }
    if([keyPath isEqualToString:KVO_MON_NAME]){}
    if([keyPath isEqualToString:KVO_ZONE_NAME]){}
}


-(void)afterZonePick:(Zone *)zoneChoice{
    if(zoneChoice==nil){
        zoneChoice =
        [ZoneHelper constructZoneChoice:self.userHero AndMatchHeroLvl:NO];
    }
    
    [ZoneHelper moveZoneToFront:zoneChoice];
    [self.dataController insertIntoContext:zoneChoice];
    self.nowZone = zoneChoice;
    
    self.nowMonster =
    [MonsterHelper constructRandomMonster:zoneChoice.zoneKey
                                AroundLvl:zoneChoice.lvl];
    
    NSMutableDictionary *zoneInfo = self.nowZone.mapable;
    NSMutableDictionary *monsterInfo = self.nowMonster.mapable;
    
    if([SingletonCluster getSharedInstance].gameState==
       GAME_STATE_UNINITIALIZED){
    
        [self afterIntro];
    }
    
    ZoneTransaction *zt =
    (ZoneTransaction *)[self.dataController
                        constructEmptyEntity:ZoneTransaction.entity];
    
    zt.timestamp = [NSDate date];
    zoneInfo[TRANSACTION_TYPE_KEY] = TRANSACTION_TYPE_CREATE;
    zt.misc = [CommonUtilities dictToString:zoneInfo];
    MonsterTransaction *mt =
    (MonsterTransaction *)[self.dataController
                           constructEmptyEntity:MonsterTransaction.entity];

    mt.timestamp = [NSDate date];
    monsterInfo[TRANSACTION_TYPE_KEY] = TRANSACTION_TYPE_CREATE;
    mt.misc = [CommonUtilities dictToString:monsterInfo];
    [self.dataController save];
    [self showMonsterStory];
}


-(void)afterIntro{
    [self initializeStatesView];
    self.statsView.hidden = NO;
    [self setupObservers];
    [self setupTabs];
    self.dataController.userData.theDataInfo.gameState =
    GAME_STATE_INITIALIZED;
    
    self.userSettings.createDate = [NSDate date];
}


-(void)initializeStatesView{
    [self updateHeroHPUI:self.userHero.nowHp whole:self.userHero.maxHp];
    self.goldLbl.text =
    [NSString stringWithFormat:@"$%.2f",self.userHero.gold];
    
    [self updateHeroXPUI:self.userHero.nowXp whole:self.userHero.maxXp];
    self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%d",self.userHero.lvl];
    [self updateMonsterHPUI:self.nowMonster.nowHp
                      whole:self.nowMonster.maxHp];
}


-(void)showMonsterStory{
    if(self.userSettings.storyModeisOn){
        StoryDumpView *sdv =
        [[StoryDumpView alloc] initWithStoryItem:self.nowMonster];
        
        [ViewHelper pushViewToFront:sdv OfParent:self];
    }
}


@end
