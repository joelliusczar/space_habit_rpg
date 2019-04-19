//
//  SHSectorTransaction_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/SHCoreDataProtocol.h>
#import "SHSector+CoreDataClass.h"
#import "SHSectorTransaction+CoreDataClass.h"



NS_ASSUME_NONNULL_BEGIN

@interface SHSectorTransaction_Medium : NSObject
+(instancetype)newWithContext:(NSManagedObjectContext*)context;
-(void)addCreateTransaction:(SHSector *)sector;
@end

NS_ASSUME_NONNULL_END
