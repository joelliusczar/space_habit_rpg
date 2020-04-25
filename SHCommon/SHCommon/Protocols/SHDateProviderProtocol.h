//
//  SHDateProviderProtocol.h
//  SHCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHDatetime;

NS_ASSUME_NONNULL_BEGIN

@protocol SHDateProviderProtocol <NSObject>
@property (readonly, nonatomic) NSDate *date;
@property (readonly, nonatomic) NSInteger localTzOffset;
@property (readonly, nonatomic) SHDatetime dateSHDt;
@end

NS_ASSUME_NONNULL_END
