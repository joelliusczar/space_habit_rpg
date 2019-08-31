//
//  SHMonster.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <SHCommon/SHProbWeight.h>
#import "SHMonsterInfoDictionary.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHMonster : NSManagedObject
@property (class,strong,nonatomic) SHMonsterInfoDictionary *monsterInfo;
@property (readonly,nonatomic) int32_t maxHp;
@property (readonly,nonatomic) int32_t attack;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "SHMonster+CoreDataProperties.h"
