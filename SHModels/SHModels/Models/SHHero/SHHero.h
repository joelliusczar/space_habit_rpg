//
//  SHHero.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHero : NSManagedObject
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)setupInitialState;
@end

NS_ASSUME_NONNULL_END

#import "SHHero+CoreDataProperties.h"
