//
//  SHCentralViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <SHGlobal/SHConstants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHData/SHCoreDataProtocol.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/SHSectorTransaction+CoreDataClass.h>
#import <SHModels/SHMonsterTransaction+CoreDataClass.h>
#import <SHModels/SHSettings+CoreDataClass.h>
#import <SHModels/SHHero+CoreDataClass.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHMonster_Medium.h>
#import <SHModels/SHSectorTransaction_Medium.h>
#import <SHModels/SHMonsterTransaction_Medium.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>

#import "SHCentralViewController.h"
#import "SHDailyViewController.h"
#import "SHMenuViewController.h"
#import "SHIntroViewController.h"
#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpView.h"


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

@interface SHCentralViewController ()
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
@property (weak,nonatomic) SHIntroViewController *introVC;
@property (strong,nonatomic) dispatch_queue_t settingsAccessorQueue;

@end

@implementation SHCentralViewController
    


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

@synthesize settingsDTO = _settingsDTO;
-(SHSettingsDTO*)settingsDTO{
  __block SHSettingsDTO *settings = nil;
  dispatch_sync(self.settingsAccessorQueue,^{
    settings = self->_settingsDTO;
  });
  return settings;
}

-(void)setSettingsDTO:(SHSettingsDTO *)settingsDTO{
  dispatch_async(self.settingsAccessorQueue,^{
    self->_settingsDTO = settingsDTO;
  });
}


-(instancetype)initWithDataController:(NSObject<P_CoreData>*)dataController
  andNibName:(NSString*)nib
  andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
  andBundle:(NSBundle*)bundle
  {
  if(self = [super initWithNibName:nib bundle:bundle]){
    _dataController = dataController;
    _resourceUtil = util;
    _settingsAccessorQueue = dispatch_queue_create("com.SpaceHabit.Settings",DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(_settingsAccessorQueue,^{
      NSManagedObjectContext *context = [dataController newBackgroundContext];
      [context performBlockAndWait:^{
        NSFetchRequest *fetchRequest = SHSettings.fetchRequest;
        NSSortDescriptor *sortBy = [NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES];
        fetchRequest.sortDescriptors = @[sortBy];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
        SHSettings *settings = (SHSettings*)results[0];
        SHSettingsDTO *dto = [SHSettingsDTO new];
        [dto dtoCopyFrom:settings];
        self->_settingsDTO = dto;
      }];
    });

  }
  return self;
}


+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
  andNibName:(NSString*)nib
  andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
  andBundle:(NSBundle*)bundle
  {
  id instance = [[SHCentralViewController alloc]
    initWithDataController:dataController
    andNibName:nib
    andResourceUtil:util
    andBundle:bundle];
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
  SHDailyViewController* dc = [[SHDailyViewController alloc] initWithCentral:self];

  self.tabsController.viewControllers = @[dc];
  
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
  SHIntroViewController *introVC = [[SHIntroViewController alloc] initWithCentralViewController:self];
  [self arrangeAndPushChildVCToFront:introVC];
  self.introVC = introVC;
}


-(void)setupNormalZoneAndMonster{
  
  SHSectorDTO * z = [self getCurrentZone];
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
  SHMonsterInfoDictionary *monInfoDict = [SHMonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
  SHSectorInfoDictionary *zoneInfoDict = [SHSectorInfoDictionary newWithResourceUtil:self.resourceUtil];
  Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:self.resourceUtil withInfoDict:zoneInfoDict];
  SHHeroDTO *heroDTO = self.heroDTO;
  [context performBlock:^{
    SHMonster *m = [mm getCurrentMonster];
    if(m==nil||m.nowHp<1){
      z.monstersKilled = (m && m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
    
      if(z.monstersKilled>=z.maxMonsters){
        NSMutableArray<SHSectorDTO *> *zoneChoices = [zm
          newMultipleSectorChoicesGivenHero:heroDTO ifShouldMatchLvl:NO];
      
        [zoneChoices addObject:z];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [self showZoneChoiceView:zoneChoices];
        }];
      }
      else { //if we're just using the same zone
        if(m){
          [context deleteObject:m];
        }
        SHMonsterDTO *mDTO = [mm newRandomMonster:z.sectorKey zoneLvl:z.lvl];
        SHMonster *monsterNew = (SHMonster*)[context newEntity:SHMonster.entity];
        [monsterNew copyFrom:mDTO];
        NSError *error = nil;
        [context save:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          self.monsterDTO = mDTO;
          [self showMonsterStoryWithContext: context];
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
    if(self.settingsDTO.gameState == SH_GAME_STATE_UNINITIALIZED){
        [self showIntroView];        
    }
    else{
      [self setupNormalZoneAndMonster];
    }
}

-(void)setToShowStory:(BOOL)shouldShowStory{
    self.settingsDTO.storyModeisOn = shouldShowStory;
}

-(void)showZoneChoiceView:(NSArray<SHSectorDTO *> *)zoneChoices{
    SHSectorChoiceViewController *zoneChoiceView = [SHSectorChoiceViewController
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
     self.monsterDTO.fullName,self.monsterDTO.lvl, part,whole];
    
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
        [self updateHeroHPUI:self.heroDTO.nowHp whole:self.heroDTO.maxHp];
    }
    if([keyPath isEqualToString:KVO_GOLD]){
        self.goldLbl.text =
        [NSString stringWithFormat:@"$%.2f",self.heroDTO.gold];
    }
    if([keyPath isEqualToString:KVO_HERO_XP]){
        [self updateHeroXPUI:self.heroDTO.nowXp whole:self.heroDTO.maxXp];
    }
    if([keyPath isEqualToString:KVO_LVL]){
        self.lvlLbl.text =
        [NSString stringWithFormat:@"Lv:%d",self.heroDTO.lvl];
    }
    if([keyPath isEqualToString:KVO_MONSTER_HP]){
        [self updateMonsterHPUI:self.monsterDTO.nowHp
                          whole:self.monsterDTO.maxHp];
    }
    if([keyPath isEqualToString:KVO_MON_NAME]){}
    if([keyPath isEqualToString:KVO_ZONE_NAME]){}
}

#pragma clang diagnostic pop


-(void)afterZonePick:(SHSectorDTO*)zoneChoice withContext:(NSManagedObjectContext*)context{
  if(nil == context){
    context = [self.dataController newBackgroundContext];
  }
  NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
  SHSectorInfoDictionary *zoneDict = [SHSectorInfoDictionary newWithResourceUtil:resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil withInfoDict:zoneDict];
  __block SHSectorDTO *zoneChoiceBlock = zoneChoice;
  [context performBlock:^{
    if(zoneChoice==nil){
      SHHeroDTO *heroCopy = [self.heroDTO copy];
      zoneChoiceBlock = [zm newRandomSectorChoiceGivenHero:heroCopy
        ifShouldMatchLvl:NO];
    }
    SHSector *zoneCD = (SHSector*)[context newEntity:SHSector.entity];
    [zm moveSectorToFront:zoneCD];
    zoneChoice.objectID = zoneCD.objectID;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.zoneDTO = zoneChoice;
    }];
    
    SHSectorTransaction_Medium *zt = [SHSectorTransaction_Medium
      newWithContext:context];
  
    [zt addCreateTransaction:zoneCD];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self showZoneStoryWithContext:context];
    }];
  }];
}


-(void)afterIntroWithContext:(NSManagedObjectContext*)context{
  [self prepareScreen];
  [context performBlock:^{
    if(self.settingsDTO.gameState == SH_GAME_STATE_UNINITIALIZED){
      SHSettings *settings = [context objectWithID:self.settingsDTO.objectID];
      //settings.gameState = GAME_STATE_INITIALIZED;
      SHSettingsDTO *dto = [SHSettingsDTO new];
      [dto dtoCopyFrom:settings];
      NSError *error = nil;
      [context save:&error];
      if(nil == error){
        self.settingsDTO = dto;
      }
    }
  }];
}


-(void)initializeStatesView{
  [self updateHeroHPUI:self.heroDTO.nowHp whole:self.heroDTO.maxHp];
  self.goldLbl.text =
  [NSString stringWithFormat:@"$%.2f",self.heroDTO.gold];
  
  [self updateHeroXPUI:self.heroDTO.nowXp whole:self.heroDTO.maxXp];
  self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%d",self.heroDTO.lvl];
  [self updateMonsterHPUI:self.monsterDTO.nowHp
    whole:self.monsterDTO.maxHp];
  self.statsView.hidden = NO;
}


-(SHSectorDTO *)getCurrentZone{
  if(self.zoneDTO){
    return self.zoneDTO;
  }
  BOOL isFront = YES;
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  SHSectorInfoDictionary *zoneInfoDict = [SHSectorInfoDictionary newWithResourceUtil:self.resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil withInfoDict:zoneInfoDict];
  __block SHSectorDTO *result = nil;
  [context performBlockAndWait:^{
    @autoreleasepool {
      SHSector *z = [zm getSector:isFront];
      if(z==nil){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          NSMutableArray<SHSectorDTO*> *zoneChoices = [zm
          newMultipleSectorChoicesGivenHero:self.heroDTO ifShouldMatchLvl:NO];
      
          [self showZoneChoiceView:zoneChoices];
        }];
      }
      else{
        result = [SHSectorDTO newWithZoneDict:zoneInfoDict];
        [result dtoCopyFrom:z];
      }
    }
  }];
  return result;
}


-(void)showStoryItem:(NSObject<SHStoryItemProtocol>*)storyItem
  withResponse:(void (^)(SHStoryDumpView * nullable))response{
  NSManagedObjectContext *context = [self.dataController  newBackgroundContext];
  [context performBlock:^{
    SHSettingsDTO *settings = self.settingsDTO;
    if(settings.storyModeisOn){
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        SHStoryDumpView *sdv = [[SHStoryDumpView alloc] initWithStoryItem:storyItem];
        sdv.responseBlock = response;
        sdv.backgroundColor = UIColor.whiteColor;
        [self arrangeAndPushChildVCToFront:sdv];
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
  [self showStoryItem:self.monsterDTO withResponse:^(SHStoryDumpView * sdv){
    (void)sdv;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      if(nil != self.introVC){
        [self.introVC popVCFromFront];
      }
      [self afterIntroWithContext:context];
    }];
  }];
}


-(void)showZoneStoryWithContext:(NSManagedObjectContext*)context{
  [self showStoryItem:self.zoneDTO withResponse:^(SHStoryDumpView * sdv){
    (void)sdv;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      SHMonsterInfoDictionary *monInfoDict = [SHMonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
      Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
      SHSectorDTO *zoneDTO = self.zoneDTO;
      self.monsterDTO = [mm newRandomMonster:zoneDTO.sectorKey zoneLvl:zoneDTO.lvl];
      [self saveNewMonster:self.monsterDTO inContext:context];
    }];
    
  }];
}


-(void)saveNewMonster:(SHMonsterDTO *)monsterDTO inContext:(NSManagedObjectContext*)context{
  [context performBlock:^{
    SHMonsterTransaction_Medium *mt = [SHMonsterTransaction_Medium newWithContext:context];
    SHMonster *monsterCD = (SHMonster*)[context newEntity:SHMonster.entity];
    [monsterCD copyFrom:monsterDTO];
    [mt addCreateTransaction:monsterDTO];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self showMonsterStoryWithContext:context];
    }];
  }];
}

@end
