//
//  SHTestDateProvider.h
//  SHTestCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHDateProviderProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTestDateProvider : NSObject<SHDateProviderProtocol>
@property (copy, nonatomic) NSDate *testDate;
@end

NS_ASSUME_NONNULL_END
