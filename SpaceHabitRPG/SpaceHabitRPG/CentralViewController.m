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
#import <SHModels/Zone_Medium.h>
#import <SHModels/Monster_Medium.h>
#import <SHModels/ZoneTransaction_Medium.h>
#import <SHModels/MonsterTransaction_Medium.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>

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
@property (strong,nonatomic) dispatch_queue_t settingsAccessorQueue;

@end

@implementation CentralViewController
    


@synthesize tabsController = _tabsController;
-(UITabBarController *)tabsController{
    if(_tabsController == nil){
        _tabsController = [[UITabBarController alloc] init];
    }
    return _tabsController;
}

-(dispatch_queue_t)settingsAccessorQueue{
  if(nil == _settingsAccessorQueue){
    _settingsAccessorQueue = dispatch_queue_create("com.SpaceHabit.Settings",DISPATCH_QUEUE_SERIAL);
  }
  return _settingsAccessorQueue;
}

-(void (^)(void))contextSettingsBlock:(NSManagedObjectContext*)context{
  return ^{
    
  }
}


-(SHSettingsDTO*)settingsDTO{
  __block SHSettingsDTO* value = nil;
  dispatch_sync(self.settingsAccessorQueue,^{
    value = [self privateSettingsDTO];
  });
  return value;
}

-(void)setSettingsDTO:(SHSettingsDTO *)settingsDTO{
  dispatch_async(self.settingsAccessorQueue,^{
    [self setPrivateSettingsDTO:settingsDTO];
  });
}

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
andNibName:(NSString*)nib
andResourceUtil:(NSObject<P_ResourceUtility>*)util
andBundle:(NSBundle*)bundle{
  CentralViewController* instance = [[CentralViewController alloc] initWithNibName:nib bundle:bundle];
  instance.dataController = dataController;
  instance.resourceUtil = util;
  instance.weakSelf = instance;
  NSManagedObjectContext *context = [dataController newBackgroundContext];
  [];
  return instance;
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
    DailyViewController* dc = [[DailyViewController alloc] initWithParent:self
      withDataController:self.dataController
      withResourceUtil:self.resourceUtil];
    
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
  IntroViewController *introVC = [[IntroViewController alloc] initWithCentralViewController:self];
  [self arrangeAndPushChildVCToFront:introVC];
  self.introVC = introVC;
}


-(void)setupNormalZoneAndMonster{
  
  ZoneDTO * z = [self getCurrentZone];
  if(nil == z){
    //we're not ready yet
    return;
  }
  /*
    Part of me thinks this monster stuff should be abstracted
    to its own method but I'd still have to do this zone
    stuff above and it ends up becoming the same method
  */
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  MonsterInfoDictionary *monInfoDict = [MonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
  ZoneInfoDictionary *zoneInfoDict = [ZoneInfoDictionary newWithResourceUtil:self.resourceUtil];
  Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
  Zone_Medium *zm = [Zone_Medium newWithContext:context withResourceUtil:self.resourceUtil withInfoDict:zoneInfoDict];
  HeroDTO *heroDTO = self.heroDTO;
  [context performBlock:^{
    CentralViewController *blockSelf = _weakSelf;
    if(nil == blockSelf) return;
    Monster *m = [mm getCurrentMonster];
    if(m==nil||m.nowHp<1){
      z.monstersKilled = (m && m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
    
      if(z.monstersKilled>=z.maxMonsters){
        NSMutableArray<ZoneDTO *> *zoneChoices = [zm
          newMultipleZoneChoicesGivenHero:heroDTO ifShouldMatchLvl:NO]
      
        [zoneChoices addObject:z];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [blockSelf showZoneChoiceView:zoneChoices];
        }];
      }
      else { //if we're just using the same zone
        if(m){
          [context deleteObject:m];
        }
        MonsterDTO *mDTO = [mm newRandomMonster:z.zoneKey zoneLvl:z.lvl];
        Monster *monsterNew = [context newEntity:Monster.entity];
        [monsterNew copyFrom:mDTO];
        NSError *error = nil;
        [context save:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          blockSelf.monsterDTO = mDTO;
          [blockSelf showMonsterStory];
        }];
        
      }
    }
  }];
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

-(void)showZoneChoiceView:(NSArray<ZoneDTO *> *)zoneChoices{
    ZoneChoiceViewController *zoneChoiceView = [ZoneChoiceViewController
      newWithCentral:self AndZoneChoices:zoneChoices];
    
    [self.view addSubview:zoneChoiceView.view];
    [self addChildViewController:zoneChoiceView];
    [zoneChoiceView didMoveToParentViewController:self];
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


-(void)afterZonePick:(ZoneDTO*)zoneChoice withContext:(NSManagedObjectContext*)context{
  if(nil == context){
    context = [self.dataController newBackgroundContext];
  }
  NSObject<P_ResourceUtility> *resourceUtil = self.resourceUtil;
  ZoneInfoDictionary *zoneDict = [ZoneInfoDictionary newWithResourceUtil:resourceUtil];
  Zone_Medium *zm = [Zone_Medium newWithContext:context withResourceUtil:resourceUtil withInfoDict:zoneDict];
  [context performBlock:^{
    CentralViewController *blockSelf = _weakSelf;
    if(nil == blockSelf) return;
    if(zoneChoice==nil){
      HeroDTO *heroCopy = [blockSelf.heroDTO copy];
      zoneChoice = [zm newRandomZoneChoice:heroCopy,NO];
    }
    Zone *zoneCD = (Zone*)[context newEntity:Zone.entity];
    [zoneCD moveZoneToFront];
    zoneChoice.objectID = zoneCD.objectID;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      blockSelf.zoneDTO = zoneChoice;
    }];
    
    ZoneTransaction_Medium *zt = [ZoneTransaction_Medium
      newWithDataController:context];
  
    [zt addCreateTransaction:zoneCD];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [blockSelf showZoneStoryWithContext:context];
    }];
  }];
}


-(void)afterIntroWithContext:(NSManagedObjectContext*)context{
  [self prepareScreen];
  NSManagedObjectID *dataInfoID = self.theDataInfoID;
  NSManagedObjectID *settingsID = self.theSettingsID;
  [context performBlock:^{
    DataInfo *dataInfo = (DataInfo*)[context getExistingOrNewEntityWithObjectID:dataInfoID];
    if(dataInfo.gameState == GAME_STATE_UNINITIALIZED){
      DataInfo.gameState = GAME_STATE_INITIALIZED;
      
      Settings *settings = (Settings*)[context getExistingOrNewEntityWithObjectID:settingsID];
      NSError *error = nil;
      [context save:&error];
    }
  }];
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


-(ZoneDTO *)getCurrentZone{
  if(self.zoneDTO){
    return self.zoneDTO;
  }
  BOOL isFront = YES;
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  ZoneInfoDictionary *zoneInfoDict = [ZoneInfoDictionary newWithResourceUtil:self.resourceUtil];
  Zone_Medium *zm = [Zone_Medium newWithContext:context
    withResourceUtil:self.resourceUtil withInfoDict:zoneInfoDict];
  __block ZoneDTO *result = nil;
  [context performBlockAndWait:^{
    @autoreleasepool {
      Zone *z = [zm getZone:isFront];
      if(z==nil){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          NSMutableArray<ZoneDTO*> *zoneChoices = [zm
          newMultipleZoneChoicesGivenHero:_weakSelf.heroDTO ifShouldMatchLvl:NO];
      
          [_weakSelf showZoneChoiceView:zoneChoices];
        }];
      }
      else{
        result = [ZoneDTO newWithZoneDict:zoneInfoDict];
        [z copyInto:result];
      }
    }
  }];
  return result;
}


-(void)showStoryItem:(NSObject<P_StoryItem>*)storyItem
  withResponse:(void (^)(StoryDumpView * nullable))response{
  NSManagedObjectContext *context = [self.dataController  newBackgroundContext];
  NSManagedObjectID *settingsID = self.theSettingsID;
  [context performBlock:^{
    CentralViewController *blockSelf = _weakSelf;
    Settings *settings = (Settings*)[context objectWithID:settingsID];
    if(settings.storyModeisOn){
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        StoryDumpView *sdv = [[StoryDumpView alloc] initWithStoryItem:storyItem];
        sdv.responseBlock = response;
        sdv.backgroundColor = UIColor.whiteColor;
        [blockSelf arrangeAndPushChildVCToFront:sdv];
      }];
    }
    else{
      @autoreleasepool {
        response(nil);
      }
      
    }
  }];
}


-(void)showMonsterStoryWithContext:(NSManagedObjectContext*)context{
  [self showStoryItem:self.monsterDTO withResponse:^(StoryDumpView * sdv){
    (void)sdv;
    CentralViewController *blockSelf = _weakSelf;
    if(nil == blockSelf){
      return;
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      if(nil != blockSelf.introVC){
        [blockSelf.introVC popVCFromFront];
      }
      [blockSelf afterIntroWithContext:context];
    }];
  }];
}


-(void)showZoneStoryWithContext:(NSManagedObjectContext*)context{
  [self showStoryItem:self.zoneDTO withResponse:^(StoryDumpView * sdv){
    (void)sdv;
    CentralViewController *blockSelf = _weakSelf;
    if(nil == blockSelf){
      return;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      MonsterInfoDictionary *monInfoDict = [MonsterInfoDictionary newWithResourceUtil:blockSelf.resourceUtil];
      Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
      ZoneDTO *zoneDTO = blockSelf.zoneDTO;
      blockSelf.monsterDTO = [mm newRandomMonster:zoneDTO.zoneKey zoneLvl:zoneDTO.lvl];
      [blockSelf saveNewMonster:blockSelf.monsterDTO inContext:context];
    }];
    
  }];
}


-(void)saveNewMonster:(MonsterDTO *)monsterDTO inContext:(NSManagedObjectContext*)context{
  [context performBlock:^{
    CentralViewController *blockSelf = _weakSelf;
    if(nil == blockSelf) return;
    MonsterTransaction_Medium *mt = [MonsterTransaction_Medium newWithContext:context];
    Monster *monsterCD = (Monster*)[context newEntity:Monster.entity];
    [monsterCD copyFrom:monsterDTO];
    [mt addCreateTransaction:monsterCD];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [blockSelf showMonsterStoryWithContext:context];
    }];
  }];
}

@end
