//
//  SHMappableProtocol.h
//  SHCommon
//
//  Created by Joel Pridgen on 9/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol SHMappableProtocol <NSObject>
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@end

NS_ASSUME_NONNULL_END
