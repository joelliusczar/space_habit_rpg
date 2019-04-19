//
//  SHSector+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHSector (CoreDataProperties)

+ (NSFetchRequest<SHSector *> *)fetchRequest;

@property (nonatomic) BOOL isFront;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nullable, nonatomic, copy) NSString *suffix;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *sectorKey;

@end

NS_ASSUME_NONNULL_END
