//
//  Monster+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"
#import "SingletonCluster.h"
#import "MonsterInfoDictionary.h"

@interface Monster()
@property (nonatomic,weak) MonsterInfoDictionary *monInfoDict;
@end

@implementation Monster

    @synthesize monInfoDict = _monInfoDict;
    -(MonsterInfoDictionary *)monInfoDict{
        if(!_monInfoDict){
            _monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
        }
        return _monInfoDict;
    }
    
    -(NSString *)fullName{
        return [self.monInfoDict getName:@""];
    }
    
    -(NSString *)synopsis{
        return [self.monInfoDict getDescription:@""];
    }

@end
