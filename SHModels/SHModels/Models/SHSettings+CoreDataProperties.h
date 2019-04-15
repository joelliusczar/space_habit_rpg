//
//  SHSettings+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSettings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHSettings (CoreDataProperties)

+ (NSFetchRequest<SHSettings *> *)fetchRequest;

@property (nonatomic) BOOL allowReport;
@property (nullable, nonatomic, copy) NSDate *createDateTime;
@property (nonatomic) int32_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int32_t heroLvlPenalty;
@property (nonatomic) BOOL invertColors;
@property (nonatomic) BOOL isPasscodeProtected;
@property (nullable, nonatomic, copy) NSDate *lastCheckinDateTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int32_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nonatomic) int32_t zoneLvlPenalty;
@property (nonatomic) int32_t gameState;
@property (nonatomic) int32_t migrationNumber;

@end

NS_ASSUME_NONNULL_END
