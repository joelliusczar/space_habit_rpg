//
//  Daily.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface Daily : NSManagedObject
@property (nonatomic,assign) NSInteger rowNum;
@property (nonatomic,assign) NSInteger sectionNum;

@end

NS_ASSUME_NONNULL_END

#import "Daily+CoreDataProperties.h"
