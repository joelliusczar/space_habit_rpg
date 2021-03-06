//
//  SHDaily_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 3/26/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDaily.h"
@import Foundation;
@import CoreData;
@import SHCommon;

#define useOtherFetcher 0

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily_Medium : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
+(instancetype)newWithContext:(NSManagedObjectContext *)context;
-(NSFetchedResultsController *)dailiesDataFetcher;

@end

NS_ASSUME_NONNULL_END
