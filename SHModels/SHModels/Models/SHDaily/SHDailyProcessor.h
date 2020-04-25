//
//  SHDailyProcessor.h
//  SHModels
//
//  Created by Joel Pridgen on 4/10/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

@import Foundation;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyProcessor : NSObject
@property (strong, nonatomic) NSManagedObjectContext *context;
-(void)processAllDailies;
@end

NS_ASSUME_NONNULL_END
