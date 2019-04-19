//
//  SHMonsterTransaction+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonsterTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHMonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<SHMonsterTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, copy) NSDate *timestamp;

@end

NS_ASSUME_NONNULL_END
