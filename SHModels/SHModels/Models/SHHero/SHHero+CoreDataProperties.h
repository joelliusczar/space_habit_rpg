//
//  SHHero+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHHero+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHHero (CoreDataProperties)

+ (NSFetchRequest<SHHero *> *)fetchRequest;

@property (nonatomic) double gold;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nonatomic) int32_t maxXp;
@property (nonatomic) int32_t nowHp;
@property (nonatomic) int32_t nowXp;
@property (nullable, nonatomic, copy) NSString *shipName;
@property (nonatomic) int32_t teaLeaves;

@end

NS_ASSUME_NONNULL_END
