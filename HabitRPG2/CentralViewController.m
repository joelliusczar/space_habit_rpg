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
#import "ZoneTransaction+CoreDataClass.h"
#import "MonsterTransaction+CoreDataClass.h"

@import CoreGraphics;


@interface CentralViewController ()
@property (strong,nonatomic) UITabBarController *tabsController;
@property (weak, nonatomic) IBOutlet UIView *statsView;
@property (weak, nonatomic) IBOutlet UILabel *heroDescLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *heroHPBar;
@property (weak, nonatomic) IBOutlet UILabel *monsterDescLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *monsterHPBar;
@property (weak, nonatomic) IBOutlet UILabel *xpLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *xpBar;
@property (weak, nonatomic) IBOutlet UILabel *lvlLbl;
@property (weak, nonatomic) IBOutlet UILabel *goldLbl;
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

-(void)setupNormalZoneAndMonster{
    Zone *z = [ZoneHelper getZone:YES];
    if(z==nil){
        NSMutableArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:NO];
        [self showZoneChoiceView:zoneChoices];
        return;
    }
    self.nowZone = z;
    Monster *m = [MonsterHelper getCurrentMonster];
    if(m==nil||m.nowHp<1){
        z.monstersKilled=(m!=nil&&m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
        if(z.monstersKilled>=z.maxMonsters){
            NSMutableArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:self.userHero AndMatchHeroLvl:NO];
            [zoneChoices addObject:z];
            [self showZoneChoiceView:zoneChoices];
            //setups observers after user has picked zones
            return;
        }
        m = [MonsterHelper constructRandomMonster:z.zoneKey AroundLvl:z.lvl];
        [SHData save:m];
        [self showMonsterStory];
    }
    self.nowMonster = m;
}


-(void)determineIfFirstTimeAndSetupSettings{
    if(self.dataController.userData.theDataInfo.gameState == GAME_STATE_UNINITIALIZED){
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
    self.monsterDescLbl.text = [NSString stringWithFormat:@"%@ Lvl:%d HP:%d/%d",self.nowMonster.fullName,self.nowMonster.lvl, part,whole];
    float hpPercent = ((float)part)/whole;
    self.monsterHPBar.progress = hpPercent;
}

-(void)setupSingleObserver:(NSString *)keyPath{
    @try{
        [self removeObserver:self forKeyPath:keyPath context:nil];
    }
    @catch(NSException *ex){}
    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
}

-(void)setupHeroObservers{
    [self setupSingleObserver:KVO_HERO_HP];
    [self setupSingleObserver:KVO_GOLD];
    [self setupSingleObserver:KVO_HERO_XP];
    [self setupSingleObserver:KVO_LVL];
    
}

-(void)setupMonsterObservers{
    [self setupSingleObserver:KVO_MONSTER_HP];
    [self setupSingleObserver:KVO_MON_NAME];
}

-(void)setupZoneObservers{
    [self setupSingleObserver:KVO_ZONE_NAME];
}

-(void)setupObservers{
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
    if([keyPath isEqualToString:KVO_MON_NAME]){}
    if([keyPath isEqualToString:KVO_ZONE_NAME]){}
}

-(void)afterZonePick:(Zone *)zoneChoice{
    if(zoneChoice!=nil){
        NSSet<NSManagedObject *> *zSet = [NSSet setWithObject:zoneChoice];
        [SHData removeInsertedNotInSet:zSet];
    }
    if(zoneChoice==nil){
        zoneChoice = [ZoneHelper constructZoneChoice:self.userHero AndMatchHeroLvl:NO];
    }
    self.nowZone = zoneChoice;
    [ZoneHelper moveZoneToFront:zoneChoice];
    self.nowMonster = [MonsterHelper constructRandomMonster:zoneChoice.zoneKey AroundLvl:zoneChoice.lvl];
    NSMutableDictionary *zoneInfo = self.nowZone.mapable;
    NSMutableDictionary *monsterInfo = self.nowMonster.mapable;
    if([SingletonCluster getSharedInstance].gameState==GAME_STATE_UNINITIALIZED){
        [self afterIntro];
    }
    [self.dataController save:self.nowZone];
    [self.dataController save:self.nowMonster];
    [self.dataController.transactionContext performBlock:^{
        ZoneTransaction *zt = (ZoneTransaction *)[self.dataController constructEmptyEntity:ZONE_TRANSACTION_ENTITY_NAME];
        zt.timestamp = [NSDate date];
        zt.misc = [CommonUtilities dictToString:zoneInfo];
        
        MonsterTransaction *mt = (MonsterTransaction *)[self.dataController constructEmptyEntity:MONSTER_TRANSACTION_ENTITY_NAME];
        mt.timestamp = [NSDate date];
        mt.misc = [CommonUtilities dictToString:monsterInfo];
        
        if(![self.dataController saveTransaction]){
            abort();
        }
    }];
    [self showMonsterStory];
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
