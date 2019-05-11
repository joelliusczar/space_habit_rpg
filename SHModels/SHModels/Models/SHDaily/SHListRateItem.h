//
//  SHListRateItem.h
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHListRateItem : SHObject
@property (assign,nonatomic) NSInteger majorOrdinal;
@property (assign,nonatomic) NSInteger minorOrdinal;
@property (copy,nonatomic) void (^touchCallback)(void);
-(instancetype)initWithMajorOrdinal:(NSInteger)majorOrdinal
  minorOrdinal:(NSInteger)minorOrdinal;
@end

NS_ASSUME_NONNULL_END
