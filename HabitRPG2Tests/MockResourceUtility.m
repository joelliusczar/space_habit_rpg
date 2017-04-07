//
//  MockResourceUtility.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MockResourceUtility.h"
#import "constants.h"

@interface MockResourceUtility()
    @property (nonatomic,strong) NSDictionary *mockZoneDict;
    @property (nonatomic,strong) NSDictionary *mockMonsterDict;
    @property (nonatomic,strong) NSMutableArray<NSString *> *mockZoneList;
@end

@implementation MockResourceUtility
    
    @synthesize mockZoneDict = _mockZoneDict;
    -(NSDictionary *)mockZoneDict{
        if(!_mockZoneDict){
            _mockZoneDict = [self buildMockZoneDict];
        }
        return _mockZoneDict;
    }
    
    @synthesize mockMonsterDict = _mockMonsterDict;
    -(NSDictionary *)mockMonsterDict{
        if(!_mockMonsterDict){
            /*
                gotta have the zone dict built first so that it can setup
                the list of zones. It's a little bit of a state machine
             */
            [self mockZoneDict];
            _mockMonsterDict = [self buildMockMonsterDict:self.mockZoneList];
        }
        return _mockMonsterDict;
    }
    
    -(NSArray *)getPListArray:(NSString *)fileName withClassBundle:(Class)class{
        if([fileName isEqualToString:@"SuffixList"]){
            return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        }
        [NSException raise:@"Invalid arg" format:@"argument is invalid"];
        return nil;
    }
    
    -(NSDictionary *)getPListDict:(NSString *)fileName withClassBundle:(Class)class{
        if([fileName isEqualToString:@"ZoneInfo"]){
            return self.mockZoneDict;
        }
        if([fileName isEqualToString:@"MonsterInfo"]){
            return self.mockMonsterDict;;
        }
        [NSException raise:@"Invalid arg" format:@"argument is invalid"];
        return nil;
    }
    
    -(NSDictionary *)buildMockZoneDict{
        int32_t zoneIndex = 0;
        self.mockZoneList = [NSMutableArray array];
        NSArray<NSString *> *zoneGroups = @[@"LVL_0_ZONES",@"LVL_5_ZONES",@"LVL_10_ZONES",@"LVL_15_ZONES",
                                @"LVL_20_ZONES",@"LVL_25_ZONES",@"LVL_30_ZONES"];
        NSMutableDictionary *mockDict = [NSMutableDictionary dictionary];
        for(int32_t i = 0;i<zoneGroups.count;i++){
            NSMutableDictionary *zoneGroup = [NSMutableDictionary dictionary];
            for(int32_t j = 0;j<5;j++){
                NSString *zoneName = [NSString stringWithFormat:@"testZone%d",zoneIndex];
                [zoneGroup setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                [NSString stringWithFormat:@"testDescription%d",zoneIndex],@"Description"
                ,[NSString stringWithFormat:@"TestName%d",zoneIndex],@"Name"
                , nil] forKey:zoneName];
                [self.mockZoneList addObject:zoneName];
                zoneIndex++;
            }
            [mockDict setValue:[NSDictionary dictionaryWithDictionary:zoneGroup] forKey:zoneGroups[i]];
        }
        
        return [NSDictionary dictionaryWithDictionary:mockDict];
    }
    
    -(NSDictionary *)buildMockMonsterDict:(NSArray<NSString *> *)zoneList{
        int32_t monsterIndex = 0;
        NSMutableDictionary *mockDict = [NSMutableDictionary dictionary];
        for(int32_t i =0;i<zoneList.count;i++){
            NSMutableDictionary *monsterGroup = [NSMutableDictionary dictionary];
            for(int32_t j = 0;j<5;j++){
                NSString *monsterName = [NSString stringWithFormat:@"monster%d",monsterIndex];
                [monsterGroup setValue:[NSDictionary dictionaryWithObjectsAndKeys:
                    [NSString stringWithFormat:@"monster%d",monsterIndex],@"NAME"
                    ,[NSString stringWithFormat:@"testDescription%d",monsterIndex],@"DESCRIPTION"
                    ,[NSNumber numberWithInt:(monsterIndex)],@"ATTACK_LVL"
                    ,[NSNumber numberWithInt:(monsterIndex)],@"DEFENSE_LVL"
                    ,[NSNumber numberWithInt:(monsterIndex)],@"BASE_XP_REWARD"
                    ,[NSNumber numberWithInt:(monsterIndex)],@"HP"
                    ,[NSNumber numberWithInt:(monsterIndex/10)],@"TREASURE_DROP_RATE"
                    ,[NSNumber numberWithFloat:(monsterIndex)],@"ENCOUNTER_WEIGHT"
                    ,nil] forKey:monsterName];
                monsterIndex++;
            }
            [mockDict setValue:[NSDictionary dictionaryWithDictionary:monsterGroup] forKey:zoneList[i]];
        }
        return [NSDictionary dictionaryWithDictionary:mockDict];
    }

@end
