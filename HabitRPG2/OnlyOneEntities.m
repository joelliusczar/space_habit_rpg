//
//  OnlyOneEntities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "OnlyOneEntities.h"
#import "constants.h"


@interface OnlyOneEntities()
@property (nonatomic,weak)  NSObject<P_CoreData> *dataController;
@end

@implementation OnlyOneEntities

@synthesize theDataInfo = _theDataInfo;
-(DataInfo *)theDataInfo{
    if(!_theDataInfo){
        _theDataInfo = (DataInfo *)[self.dataController getItem:DATA_INFO_ENTITY_NAME predicate:nil sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"nextZoneId" ascending:NO]]];
        if(!_theDataInfo){
            _theDataInfo = [self constructDataInfoInitialState];
        }
    }
    return _theDataInfo;
}

@synthesize theSettings = _theSettings;
-(Settings *)theSettings{
    if(!_theSettings){
        _theSettings = (Settings *)[self.dataController getItem:SETTINGS_ENTITY_NAME predicate:nil sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:NO]]];
        if(!_theSettings){
            _theSettings = [self constructSettingsInitialState];
        }
    }
    return _theSettings;
}

@synthesize theHero = _theHero;
-(Hero *)theHero{
    if(!_theHero){
        _theHero = (Hero *)[self.dataController getItem:HERO_ENTITY_NAME predicate:nil sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"lvl" ascending:NO]]];
        if(!_theHero){
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
    DataInfo *dataInfo = (DataInfo *)[self.dataController constructEmptyEntity: DATA_INFO_ENTITY_NAME];
    dataInfo.nextZoneId = 0;
    dataInfo.isNew = YES;
    [self.dataController save];
    return dataInfo;
}

-(Settings *)constructSettingsInitialState{
    Settings *settings = (Settings *)[self.dataController constructEmptyEntity:SETTINGS_ENTITY_NAME];
    settings.createDate = [NSDate date];
    settings.dayStart = 0;
    settings.deathGoldPenalty = .25;
    settings.heroLvlPenalty = 0;
    settings.lastCheckinTime = [NSDate date];
    settings.permaDeath = NO;
    settings.reminderHour = 17; //5 o'clock?
    settings.storyModeisOn = YES;
    settings.zoneLvlPenalty = 1; //0 - no penalty? 1: restart lvl?
    [self.dataController save];
    return settings;
}

-(Hero *)constructHeroInitialState{
    Hero *hero = (Hero *)[self.dataController constructEmptyEntity:HERO_ENTITY_NAME];
    hero.gold = 0;
    hero.lvl = 1;
    hero.maxHp = 50;
    hero.maxXp = 100;
    hero.nowHp = 50;
    hero.nowXp = 0;
    hero.shipName = @"";
    [self.dataController save];
    return hero;
}
@end
