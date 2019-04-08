//
//  ZoneTransaction_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/P_CoreData.h>
#import "Zone+CoreDataClass.h"
#import "ZoneTransaction+CoreDataClass.h"



NS_ASSUME_NONNULL_BEGIN

@interface ZoneTransaction_Medium : NSObject
+(instancetype)newWithContext:(NSManagedObjectContext*)context;
-(void)addCreateTransaction:(Zone *)zone;
@end

NS_ASSUME_NONNULL_END
