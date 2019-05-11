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
#import <SHModels/SHConfig.h>
#import <SHModels/SHHero.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHMonster_Medium.h>
#import <SHModels/SHTransaction_Medium.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHControls/UIView+Helpers.h>
#import <SHCommon/NSException+SHCommonExceptions.h>
#import "SHCentralViewController.h"
#import "SHDailyViewController.h"
#import "SHMenuViewController.h"
#import "SHIntroViewController.h"
#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpView.h"
#import <SHControls/UIViewController+Helper.h>


#define KVO_HERO_HP @"heroDTO.nowHp"
#define KVO_HERO_XP @"heroDTO.nowXp"
#define KVO_MONSTER_HP @"monsterDTO.nowHp"
#define KVO_GOLD @"heroDTO.gold"
#define KVO_LVL @"heroDTO.lvl"
#define KVO_MON_NAME @"monsterDTO.fullName"
#define KVO_ZONE_NAME @"sectorDTO.fullName"

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
@property (strong,nonatomic) dispatch_queue_t configAccessorQueue;
/*
  #sectorMonsterQueue
  I'm doing some initial clean up in certain start up situations.
  I don't want the clean up accidently deleting any newly added
  sectors or monsters, so all saving and retrieving actions should
  be done through this queue.
*/
@property (strong,nonatomic) dispatch_queue_t sectorMonsterQueue;

@end

@implementation SHCentralViewController
    


@synthesize tabsController = _tabsController;
-(UITabBarController *)tabsController{
    if(_tabsController == nil){
        _tabsController = [[UITabBarController alloc] init];
    }
    return _tabsController;
}


@synthesize configDTO = _configDTO;
-(SHConfigDTO*)configDTO{
  __block SHConfigDTO *config = nil;
  dispatch_sync(self.configAccessorQueue,^{
    config = self->_configDTO;
  });
  return config;
}

-(void)setConfigDTO:(SHConfigDTO *)configDTO{
  dispatch_async(self.configAccessorQueue,^{
    self->_configDTO = configDTO;
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
    _configAccessorQueue = dispatch_queue_create("com.SpaceHabit.Config",DISPATCH_QUEUE_SERIAL);
    _sectorMonsterQueue = dispatch_queue_create("com.SpaceHabit.Sector_Monster",DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(_configAccessorQueue,^{
      NSManagedObjectContext *context = [dataController newBackgroundContext];
      [context performBlockAndWait:^{
        NSFetchRequest *fetchRequest = SHConfig.fetchRequest;
        NSSortDescriptor *sortBy = [NSSortDescriptor sortDescriptorWithKey:@"createDateTime" ascending:YES];
        fetchRequest.sortDescriptors = @[sortBy];
        NSError *error = nil;
        NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
        if(error){
          @throw [NSException dbException:error];
        }
        SHConfig *config = nil;
        if(results.count > 0){
          config = (SHConfig*)results[0];
        }
        else{
          config = (SHConfig*)[context newEntity:SHConfig.entity];
          [context performBlock:^{
            NSError *error = nil;
            if(![context save:&error]){
              @throw [NSException dbException:error];
            }
          }];
        }
        
        SHConfigDTO *dto = [SHConfigDTO new];
        [dto dtoCopyFrom:config];
        self->_configDTO = dto;
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
    //determineIfFirstTimeAndSetupConfig
    [self determineIfFirstTimeAndSetupConfig];
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

// logic picks back up in afterIntroStarted
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


-(void)setupNormalSectorAndMonster{
  
  SHSectorDTO * z = [self getCurrentSector];
  if(nil == z){
    //we're not ready yet
    return;
  }
  /*
    Part of me thinks this monster stuff should be abstracted
    to its own method but I'd still have to do this sector
    stuff above and it ends up becoming the same method
  */
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  SHMonsterInfoDictionary *monInfoDict = [SHMonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
  SHSectorInfoDictionary *sectorInfoDict = [SHSectorInfoDictionary newWithResourceUtil:self.resourceUtil];
  Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:self.resourceUtil withInfoDict:sectorInfoDict];
  SHHeroDTO *heroDTO = self.heroDTO;
  [context performBlock:^{
    SHMonster *m = [mm getCurrentMonster];
    if(m==nil||m.nowHp<1){
      z.monstersKilled = (m && m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
    
      if(z.monstersKilled>=z.maxMonsters){
        NSMutableArray<SHSectorDTO *> *sectorChoices = [zm
          newMultipleSectorChoicesGivenHero:heroDTO ifShouldMatchLvl:NO];
      
        [sectorChoices addObject:z];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [self showSectorChoiceView:sectorChoices];
        }];
      }
      else { //if we're just using the same sector
        if(m){
          [context deleteObject:m];
        }
        SHMonsterDTO *mDTO = [mm newRandomMonster:z.sectorKey sectorLvl:z.lvl];
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
    else {
      SHMonsterDTO *mDTO = [SHMonsterDTO newWithMonsterDict:monInfoDict];
      [mDTO dtoCopyFrom:m];
      
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.monsterDTO = mDTO;
        [self setupHero:^{
          [self prepareScreen];
        }];
      }];
    }
  }];
}


-(void)prepareScreen{
  [self initializeStatesView];
  [self setupObservers];
  [self setupTabs];
}


-(void)cleanUpPreviousAttempts{
  
  NSManagedObjectContext *context = self.dataController.newBackgroundContext;
  [context performBlock:^{
    //see note by sectorMonsterQueue #sectorMonsterQueue
    dispatch_sync(self.sectorMonsterQueue,^{
      //don't add any other entities than sector and monster
      NSFetchRequest *sectorsRequest = SHSector.fetchRequest;
      NSFetchRequest *monstersRequest = SHMonster.fetchRequest;
      NSBatchDeleteRequest *deleteSectors = [[NSBatchDeleteRequest alloc] initWithFetchRequest:sectorsRequest];
      deleteSectors.resultType = NSBatchDeleteResultTypeCount;
      NSBatchDeleteRequest *deleteMonsters = [[NSBatchDeleteRequest alloc] initWithFetchRequest:monstersRequest];
      deleteMonsters.resultType = NSBatchDeleteResultTypeCount;
      [context performBlockAndWait:^{
        @autoreleasepool {
          NSError *errorSectors = nil;
          NSBatchDeleteResult *sectorResults = [context executeRequest:deleteSectors error:&errorSectors];
          NSError *errorMonsters = nil;
          NSBatchDeleteResult *monsterResults = [context executeRequest:deleteMonsters error:&errorMonsters];
          [context performBlock:^{
            NSInteger sectorCounts = ((NSNumber*)sectorResults.result).integerValue;
            if(sectorCounts > 0){
              SHTransaction_Medium *sm = [[SHTransaction_Medium alloc] initWithContext:context
                andEntityType:SHSector.entity.name];
              [sm addBatchDeleteTransaction:[NSString stringWithFormat:
                @"Batch deleted %ldl sectors",sectorCounts]];
            }
            NSInteger monsterCounts = ((NSNumber*)monsterResults.result).integerValue;
            if(monsterCounts > 0){
              SHTransaction_Medium *mm = [[SHTransaction_Medium alloc] initWithContext:context
                andEntityType:SHMonster.entity.name];
              [mm addBatchDeleteTransaction:[NSString stringWithFormat:
                @"Batch deleted %ldl monsters",monsterCounts]];
            }
          }];
        }
      }];
      
    });
  }];
}


-(void)determineIfFirstTimeAndSetupConfig{
  if(self.configDTO.gameState == SH_GAME_STATE_UNINITIALIZED){
    [self cleanUpPreviousAttempts];
    [self showIntroView];
  }
  else{
    [self setupNormalSectorAndMonster];
  }
}

-(void)setToShowStory:(BOOL)shouldShowStory{
    self.configDTO.storyModeisOn = shouldShowStory;
}

-(void)showSectorChoiceView:(NSArray<SHSectorDTO *> *)sectorChoices{
    SHSectorChoiceViewController *sectorChoiceView = [SHSectorChoiceViewController
      newWithCentral:self AndSectorChoices:sectorChoices];
    
    [self.view addSubview:sectorChoiceView.view];
    [self addChildViewController:sectorChoiceView];
    [sectorChoiceView didMoveToParentViewController:self];
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

/*
  This is where the logic picks back up after the intro view
*/
-(void)afterIntroStarted{
  /*
      This whole process is hard to follow.
      It's because there's a few steps are dependent upon user input.
      So, the choices were:
      A. Have a convoluted state machine that goes down different
        branches depending on if certain conditions were met yet.
      B. (What I'm currently doing) Basically, callback hell. This way
        I can connect the next actions to the end of the previous
        segment.
      I suppose I could have also writen my modals work like showDialog
        in winforms. But I'm not doing that.
   
  */
  
  [self setupHero:^{
    NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
    SHSectorInfoDictionary *sectorInfoDict = [SHSectorInfoDictionary newWithResourceUtil:resourceUtil];
    SHSector_Medium *sm = [SHSector_Medium newWithContext:nil
      withResourceUtil:resourceUtil
      withInfoDict:sectorInfoDict];
    SHSectorDTO *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
    [self afterSectorPick:s];
  }];
}

-(void)setupHero:(void (^)(void))completionBlock{
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  //what the hell, we're doing it async everywhere else in this
  //file, why not here too.
  [context performBlock:^{
    NSFetchRequest *heroRequest = SHHero.fetchRequest;
    NSSortDescriptor *sortBy = [NSSortDescriptor
      sortDescriptorWithKey:@"lvl"
      ascending:YES];
    heroRequest.sortDescriptors = @[sortBy];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:heroRequest error:&error];
    if(error){
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self showErrorView:@"Retriving hero failed"
          withError:error];
      }];
      return;
    }
    SHHeroDTO *heroDTO = [SHHeroDTO new];
    SHHero *heroCD = nil;
    if(results.count > 0){
      heroCD = (SHHero*)results[0];
    }
    else{
      heroCD = (SHHero*)[context newEntity:SHHero.entity];
      NSError *saveError = nil;
      [context save:&saveError];
      if(saveError){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          [self showErrorView:@"Saving hero failed"
            withError:error];
        }];
        return;
      }
    }
    
    [heroDTO dtoCopyFrom:heroCD];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.heroDTO = heroDTO;
      completionBlock();
    }];
  }];
}


-(void)afterSectorPick:(SHSectorDTO*)sectorChoice{

  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  
  NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
  SHSectorInfoDictionary *sectorDict = [SHSectorInfoDictionary newWithResourceUtil:resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil withInfoDict:sectorDict];
  __block SHSectorDTO *sectorChoiceBlockVar = sectorChoice;
  [context performBlock:^{
    if(sectorChoiceBlockVar==nil){
      //my theory is that I am copying heroDTO b/c it belongs to the main thread
      SHHeroDTO *heroCopy = [self.heroDTO copy];
      sectorChoiceBlockVar = [zm newRandomSectorChoiceGivenHero:heroCopy
        ifShouldMatchLvl:NO];
    }
    SHSector *sectorCD = (SHSector*)[context newEntity:SHSector.entity];
    [sectorCD copyFrom:sectorChoiceBlockVar];
    //see note by sectorMonsterQueue #sectorMonsterQueue
    dispatch_sync(self.sectorMonsterQueue, ^{
      [zm moveSectorToFront:sectorCD];
    });
    sectorChoiceBlockVar.objectID = sectorCD.objectID;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.sectorDTO = sectorChoiceBlockVar;
    }];
    
    SHTransaction_Medium *zt = [[SHTransaction_Medium alloc]
      initWithContext:context andEntityType:SHSector.entity.name];
  
    [zt addCreateTransaction:sectorChoiceBlockVar.mapable];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self showSectorStoryWithContext:context];
    }];
  }];
}

-(void)afterIntroCompleted:(NSManagedObjectContext*)context{
  [self prepareScreen];
  [context performBlock:^{
    if(self.configDTO.gameState == SH_GAME_STATE_UNINITIALIZED){
      SHConfig *config = [context objectWithID:self.configDTO.objectID];
      config.gameState = SH_GAME_STATE_INITIALIZED;
      SHConfigDTO *dto = [SHConfigDTO new];
      [dto dtoCopyFrom:config];
      NSError *error = nil;
      [context save:&error];
      if(nil == error){
        self.configDTO = dto;
      }
      else{
        @throw [NSException dbException:error];
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


-(SHSectorDTO *)getCurrentSector{
  if(self.sectorDTO){
    return self.sectorDTO;
  }
  BOOL isFront = YES;
  NSManagedObjectContext *context = [self.dataController newBackgroundContext];
  SHSectorInfoDictionary *sectorInfoDict = [SHSectorInfoDictionary newWithResourceUtil:self.resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil withInfoDict:sectorInfoDict];
  __block SHSectorDTO *result = nil;
  [context performBlockAndWait:^{
    @autoreleasepool {
      SHSector *z = [zm getSector:isFront];
      if(z==nil){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          NSMutableArray<SHSectorDTO*> *sectorChoices = [zm
          newMultipleSectorChoicesGivenHero:self.heroDTO ifShouldMatchLvl:NO];
      
          [self showSectorChoiceView:sectorChoices];
        }];
      }
      else{
        result = [SHSectorDTO newWithSectorDict:sectorInfoDict];
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
    SHConfigDTO *config = self.configDTO;
    if(config.storyModeisOn){
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
      [self afterIntroCompleted:context];
    }];
  }];
}


-(void)showSectorStoryWithContext:(NSManagedObjectContext*)context{
  [self showStoryItem:self.sectorDTO withResponse:^(SHStoryDumpView * sdv){
    (void)sdv;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      SHMonsterInfoDictionary *monInfoDict = [SHMonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
      Monster_Medium *mm = [Monster_Medium newWithContext:context withInfoDict:monInfoDict];
      SHSectorDTO *sectorDTO = self.sectorDTO;
      self.monsterDTO = [mm newRandomMonster:sectorDTO.sectorKey sectorLvl:sectorDTO.lvl];
      [self saveAndShowNewMonster:self.monsterDTO inContext:context];
      
    }];
  }];
}


-(void)saveAndShowNewMonster:(SHMonsterDTO *)monsterDTO inContext:(NSManagedObjectContext*)context{
  [context performBlock:^{
    SHTransaction_Medium *mt = [[SHTransaction_Medium alloc] initWithContext:context
      andEntityType:SHMonster.entity.name];
    SHMonster *monsterCD = (SHMonster*)[context newEntity:SHMonster.entity];
    [monsterCD copyFrom:monsterDTO];
    //see note by sectorMonsterQueue #sectorMonsterQueue
    dispatch_sync(self.sectorMonsterQueue, ^{
      [context performBlockAndWait:^{
        @autoreleasepool {
          NSError *error = nil;
          [context save:&error];
        }
      }];
    });
    [mt addCreateTransaction:monsterDTO.mapable];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self showMonsterStoryWithContext:context];
    }];
  }];
}


@end
