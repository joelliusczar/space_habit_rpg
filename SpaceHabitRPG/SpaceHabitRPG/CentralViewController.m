//
//  CentralViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <SHGlobal/Constants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHData/P_CoreData.h>
#import <SHModels/ZoneTransaction+CoreDataClass.h>
#import <SHModels/MonsterTransaction+CoreDataClass.h>
#import <SHModels/Settings+CoreDataClass.h>
#import <SHModels/Hero+CoreDataClass.h>
#import <SHModels/Zone+Helper.h>
#import <SHModels/Monster+Helper.h>
#import <SHModels/ZoneTransaction_Medium.h>
#import <SHModels/MonsterTransaction_Medium.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>

#import "SingletonCluster+App.h"
#import "CentralViewController.h"
#import "DailyViewController.h"
#import "HabitController.h"
#import "TodoViewController.h"
#import "GoodsViewController.h"
#import "MenuViewController.h"
#import "IntroViewController.h"
#import "ZoneChoiceViewController.h"
#import "StoryDumpView.h"

#define KVO_HERO_HP @"userHero.nowHp"
#define KVO_HERO_XP @"userHero.nowXp"
#define KVO_MONSTER_HP @"nowMonster.nowHp"
#define KVO_GOLD @"userHero.gold"
#define KVO_LVL @"userHero.lvl"
#define KVO_MON_NAME @"nowMonster.fullName"
#define KVO_ZONE_NAME @"nowZone.fullName"

#define observeKey(key) [self addObserver:self forKeyPath:KVO_HERO_HP\
  options:NSKeyValueObservingOptionNew context:nil]

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
@property (weak,nonatomic) IntroViewController *introVC;
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


-(Hero *)userHero{
    return SharedGlobal.userData.theHero;
}


-(Settings *)userSettings{
    return SHSettings;
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
    [self.view checkForAndApplyVisualChanges];
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
    
    self.tabsController.viewControllers = @[dc,hc,tc,gc,mc];
    
    [self.tabsContainer addSubview:self.tabsController.view];
    [self addChildViewController:self.tabsController];
    self.tabsController.view.frame = self.tabsContainer.bounds;
}


-(void)showIntroView{
  /*Since self.introVC is a weak ref, we must create this local var
  to hold the value until the strong ref gets attached.
  I made self.introVC a weak because I only want a reference to it
  if it actually exists. I don't want to actively keep it alive, which
  is what a strong ref would do.
  */
  IntroViewController *introVC = [[IntroViewController alloc]
    initWithCentralViewController:self];
  [self arrangeAndPushChildVCToFront:introVC];
  self.introVC = introVC;
}


-(void)setupNormalZoneAndMonster{
  
  Zone * z = [self getCurrentZone];
  if(nil == z){
    //we're not ready yet
    return;
  }
  /*
    Part of me thinks this monster stuff should be abstracted
    to its own method but I'd still have to do this zone
    stuff above and it ends up becoming the same method
  */
  Monster *m = getCurrentMonster();
  if(m==nil||m.nowHp<1){
    z.monstersKilled=
    (m!=nil&&m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
  
    if(z.monstersKilled>=z.maxMonsters){
      NSMutableArray<Zone *> *zoneChoices =
      constructMultipleZoneChoices(self.userHero,NO);
    
      [zoneChoices addObject:z];
      [self showZoneChoiceView:zoneChoices];
      //setups observers after user has picked zones
      return;
    }
    m = constructRandomMonster(z.zoneKey,z.lvl);
    [SHData saveNoWaiting];
    [self showMonsterStory];
  }
  self.nowMonster = m;
}


-(void)prepareScreen{
  [self initializeStatesView];
  [self setupObservers];
  [self setupTabs];
}


-(void)determineIfFirstTimeAndSetupSettings{
    if(SharedGlobal.userData.theDataInfo.gameState ==
       GAME_STATE_UNINITIALIZED){
        [self showIntroView];        
    }
    else{
      [self setupNormalZoneAndMonster];
      [self prepareScreen];
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
    NSArray<Zone *> *zoneChoices = constructMultipleZoneChoices(self.userHero,YES);
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

  observeKey(KVO_HERO_HP);
  observeKey(KVO_GOLD);
  observeKey(KVO_HERO_XP);
  observeKey(KVO_LVL);
  observeKey(KVO_MONSTER_HP);
  observeKey(KVO_MON_NAME);
  observeKey(KVO_ZONE_NAME);
  
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

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

#pragma clang diagnostic pop


-(void)afterZonePick:(Zone *)zoneChoice{
  if(zoneChoice==nil){
    zoneChoice = constructRandomZoneChoice(self.userHero,NO);
  }
  [zoneChoice moveZoneToFront];
  
  //?? is this insert line necessary?
  /*Yes, because for it's entity setup, we insert into a nil context
    and it does no harm even it did already exist. check out test, testDoubleInsert
  */
  [self.dataController insertIntoContext:zoneChoice];
  self.nowZone = zoneChoice;

  ZoneTransaction_Medium *zt = [ZoneTransaction_Medium
    newWithDataController:self.dataController];
  
  [zt addCreateTransaction:self.nowZone];
  [self showZoneStory];
}


-(void)afterIntro{
  [self prepareScreen];
  SharedGlobal.userData.theDataInfo.gameState = GAME_STATE_INITIALIZED;
  
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
  self.statsView.hidden = NO;
}


-(Zone *)getCurrentZone{
  if(self.nowZone){
    return self.nowZone;
  }
  BOOL isFront = YES;
  Zone *z = getZone(isFront);
  if(z==nil){
      NSMutableArray<Zone *> *zoneChoices = constructMultipleZoneChoices(self.userHero,NO);
    
      [self showZoneChoiceView:zoneChoices];
      return nil;
  }
  self.nowZone = z;
  return z;
}


-(void)showStoryItem:(NSObject<P_StoryItem>*)storyItem withResponse:(void (^)(StoryDumpView * nullable))response{
  if(self.userSettings.storyModeisOn){
      StoryDumpView *sdv =
      [[StoryDumpView alloc] initWithStoryItem:storyItem];
      sdv.responseBlock = response;
      sdv.backgroundColor = UIColor.whiteColor;
      [self arrangeAndPushChildVCToFront:sdv];
    }
    else{
      response(nil);
    }
}


-(void)showMonsterStory{
  CentralViewController * __weak weakSelf = self;
  [self showStoryItem:self.nowMonster withResponse:^(StoryDumpView * sdv){
    (void)sdv;
    if(nil == weakSelf){
      return;
    }
    if(nil != weakSelf.introVC){
      [weakSelf.introVC popVCFromFront];
    }
    if(SharedGlobal.gameState == GAME_STATE_UNINITIALIZED){
      [weakSelf afterIntro];
    }
  }];
}


-(void)showZoneStory{
  CentralViewController * __weak weakSelf = self;
  [self showStoryItem:self.nowZone withResponse:^(StoryDumpView * sdv){
    (void)sdv;
    if(nil == weakSelf){
      return;
    }
    weakSelf.nowMonster = constructRandomMonster(weakSelf.nowZone.zoneKey,weakSelf.nowZone.lvl);
    
    MonsterTransaction_Medium *mt = [MonsterTransaction_Medium
      newWithDataController:weakSelf.dataController];
    
    [mt addCreateTransaction:weakSelf.nowMonster];
    [weakSelf.dataController saveNoWaiting];
    [weakSelf showMonsterStory];
  }];
}


@end
