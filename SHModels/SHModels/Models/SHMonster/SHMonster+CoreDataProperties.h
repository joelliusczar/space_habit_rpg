//
//  SHMonster+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHMonster (CoreDataProperties)

+ (NSFetchRequest<SHMonster *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) int32_t lvl;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nonatomic) int32_t nowHp;

@end

NS_ASSUME_NONNULL_END
