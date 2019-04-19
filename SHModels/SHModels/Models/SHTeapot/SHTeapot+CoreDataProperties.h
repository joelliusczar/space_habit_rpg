//
//  SHTeapot+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTeapot+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHTeapot (CoreDataProperties)

+ (NSFetchRequest<SHTeapot *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *timestampStart;
@property (nonatomic) int32_t type;
@property (nonatomic) int32_t timerLength;
@property (nullable, nonatomic, copy) NSDate *timestampEnd;
@property (nullable, nonatomic, retain) SHCategory *cat_teapot;

@end

NS_ASSUME_NONNULL_END
