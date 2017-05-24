//
//  ZoneTransaction+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "P_Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZoneTransaction : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ZoneTransaction+CoreDataProperties.h"

@interface ZoneTransaction (Transaction) <P_Transaction>
@end


