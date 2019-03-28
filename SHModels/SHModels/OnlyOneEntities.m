//
//  OnlyOneEntities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "OnlyOneEntities.h"
#import <SHGlobal/Constants.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHCommon/SingletonCluster.h>


@interface OnlyOneEntities()
@property (nonatomic,weak)  NSObject<P_CoreData> *dataController;
@end

@implementation OnlyOneEntities

@synthesize theDataInfo = _theDataInfo;
-(DataInfo *)theDataInfo{
    if(nil == _theDataInfo){
        NSFetchRequest<DataInfo*> *request = DataInfo.fetchRequest;
        request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"nextZoneId" ascending:NO]];
        NSArray<NSManagedObject *> *results = [self.dataController.mainThreadContext getItemsWithRequest:request];
        NSAssert(results.count<2, @"There are too many entities");
        _theDataInfo = results.count>0?(DataInfo *)results[0]:nil;
        if(!_theDataInfo){
            _theDataInfo = [self constructDataInfoInitialState];
        }
    }
    return _theDataInfo;
}

@synthesize theSettings = _theSettings;
-(Settings *)theSettings{
    if(nil == _theSettings){
      NSFetchRequest<Settings*> *request = Settings.fetchRequest;
      request.sortDescriptors =@[[[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:NO]];
      NSArray<NSManagedObject *> *results = [self.dataController.mainThreadContext getItemsWithRequest:request];
      NSAssert(results.count<2, @"There are too many entities");
      _theSettings = results.count>0?(Settings *)results[0]:nil;
      if(!_theSettings){
          _theSettings = [self constructSettingsInitialState];
      }
    }
    return _theSettings;
}

@synthesize theHero = _theHero;
-(Hero *)theHero{
    if(nil == _theHero){
      NSFetchRequest<Settings*> *request = Settings.fetchRequest;
      request.sortDescriptors =@[[[NSSortDescriptor alloc] initWithKey:@"lvl" ascending:NO]];
      NSArray<NSManagedObject *> *results = [self.dataController.mainThreadContext getItemsWithRequest:request];
      NSAssert(results.count<2, @"There are too many entities");
      _theHero = results.count>0?(Hero *)results[0]:nil;
      if(nil == _theHero){
          _theHero = [self constructHeroInitialState];
      }
    }
    return _theHero;
}

-(instancetype)initWithDataController:(NSObject<P_CoreData> *)dataController{
    self = [super init];
    if(!self){
        return nil;
    }
    self.dataController = dataController;
    return self;
}

-(DataInfo *)constructDataInfoInitialState{
    DataInfo *dataInfo = (DataInfo *)[self.dataController.mainThreadContext newEntity:DataInfo.entity];
    dataInfo.nextZoneId = 0;
    dataInfo.gameState = GAME_STATE_UNINITIALIZED;
    return dataInfo;
}

-(Settings *)constructSettingsInitialState{
    Settings *settings = (Settings *)[self.dataController.mainThreadContext newEntity:Settings.entity];
    settings.createDate = [NSDate date];
    settings.dayStart = 0;
    settings.deathGoldPenalty = .25;
    settings.heroLvlPenalty = 0;
    settings.lastCheckinDate = [NSDate date];
    settings.permaDeath = NO;
    settings.isPasscodeProtected = NO;
    settings.reminderHour = 17; //5 o'clock?
    settings.storyModeisOn = YES;
    settings.zoneLvlPenalty = 1; //0 - no penalty? 1: restart lvl?
    settings.allowReport = NO|(SharedGlobal.EnviromentNum&ENV_BETA);
    settings.userId = [SharedGlobal.reportCaller getUniqueID];
    return settings;
}

-(Hero *)constructHeroInitialState{
    Hero *hero = (Hero *)[self.dataController.mainThreadContext newEntity:Hero.entity];
    hero.gold = 0;
    hero.lvl = 1;
    hero.maxHp = 50;
    hero.maxXp = 100;
    hero.nowHp = 50;
    hero.nowXp = 0;
    hero.shipName = @"";
    return hero;
}
@end
