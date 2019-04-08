//
//  Monster+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


NS_ASSUME_NONNULL_BEGIN

@interface Monster : NSManagedObject
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyInto:(NSObject *)object;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "Monster+CoreDataProperties.h"

