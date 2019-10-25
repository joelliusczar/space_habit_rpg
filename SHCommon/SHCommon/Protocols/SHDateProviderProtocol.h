//
//  SHDateProviderProtocol.h
//  SHCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol SHDateProviderProtocol <NSObject>
@property (readonly, nonatomic) NSDate *date;
@end

NS_ASSUME_NONNULL_END
