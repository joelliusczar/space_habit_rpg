//
//  SHMonsterTransaction+CoreDataClass.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHMonsterTransaction : NSManagedObject
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "SHMonsterTransaction+CoreDataProperties.h"
