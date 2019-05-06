//
//  SHMonthRateItemCollection.h
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
#import "SHMonthlyRateItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHMonthRateItemCollection : SHObject
@property (readonly,nonatomic) NSUInteger count;
-(void)addMonthlyRateItem:(SHMonthlyRateItem*)rateItem;
-(void)removeMonthlyRateItemAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
