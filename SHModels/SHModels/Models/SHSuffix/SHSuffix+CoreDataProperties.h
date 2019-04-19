//
//  SHSuffix+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSuffix+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHSuffix (CoreDataProperties)

+ (NSFetchRequest<SHSuffix *> *)fetchRequest;

@property (nonatomic) int32_t visitCount;
@property (nullable, nonatomic, copy) NSString *sectorKey;

@end

NS_ASSUME_NONNULL_END
