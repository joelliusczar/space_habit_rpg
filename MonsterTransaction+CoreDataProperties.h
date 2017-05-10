//
//  MonsterTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/9/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<MonsterTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, copy) NSString *monsterKey;

@end

NS_ASSUME_NONNULL_END
