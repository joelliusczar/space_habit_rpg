//
//  SHIntroHelper.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/15/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@import SHGlobal;
@import SHModels;

NS_ASSUME_NONNULL_BEGIN

@interface SHIntroHelper : NSObject
@property (strong, nonatomic) NSManagedObjectContext *context;
-(instancetype)initWithContext:(NSManagedObjectContext*)context;
-(void)cleanUpPreviousAttempts;
-(void)afterIntroCompleted;
@end

NS_ASSUME_NONNULL_END
