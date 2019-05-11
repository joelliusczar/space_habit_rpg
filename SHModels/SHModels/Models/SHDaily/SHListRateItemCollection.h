//
//  SHListRateItemCollection.h
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
#import "SHListRateItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHListRateItemCollection : SHObject
@property (readonly,nonatomic) NSUInteger count;
@property (copy,nonatomic) void (^touchCallback)(void);
-(instancetype)initWithActiveDays:(NSMutableArray<SHListRateItem*>*)activeDays
  andTouchCallback:(void (^)(void))touchCallback;
-(NSUInteger)addRateItem:(SHListRateItem*)rateItem;
-(void)removeRateItemAtIndex:(NSUInteger)index;
-(SHListRateItem*)objectAtIndexedSubscript:(NSUInteger)idx;
@end

NS_ASSUME_NONNULL_END
