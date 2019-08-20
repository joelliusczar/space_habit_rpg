//
//  NSManagedObjectContext+SHModelHelper.h
//  SHModels
//
//  Created by Joel Pridgen on 8/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SHConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObjectContext (SHModelHelper)
@property (readonly,nonatomic) SHConfig *sh_globalConfig;
@end

NS_ASSUME_NONNULL_END
