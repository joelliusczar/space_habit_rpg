//
//  SHConfig.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHConfig : NSManagedObject
@property (readonly,nonatomic) NSDate *userTodayStart;
-(void)setupInitialState;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "SHConfig+CoreDataProperties.h"
