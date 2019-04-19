//
//  SHMonsterTransaction_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 1/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/SHCoreDataProtocol.h>
#import "SHMonsterDTO.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHMonsterTransaction_Medium : NSObject
+(instancetype)newWithContext:(NSManagedObjectContext*)context;
-(void)addCreateTransaction:(SHMonsterDTO *)m;
@end

NS_ASSUME_NONNULL_END
