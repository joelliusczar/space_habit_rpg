//
//  Monster+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "P_StoryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface Monster : NSManagedObject <P_StoryItem>
@property (nonatomic,readonly) int32_t attack;
@property (nonatomic,readonly) int32_t defense;
@property (nonatomic,readonly) int32_t xp;
@property (nonatomic,readonly) int32_t maxHp;
@property (nonatomic,readonly) float treasureDropRate;
@property (nonatomic,readonly) int32_t encounterWeight;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@end

NS_ASSUME_NONNULL_END

#import "Monster+CoreDataProperties.h"

