//
//  SHDailyRateItem.h
//  SHModels
//
//  Created by Joel Pridgen on 12/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRateItemProtocol.h"
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface SHDailyRateItem : NSObject<SHRateItemProtocol>
@property (assign, nonatomic) NSInteger intervalSize;
@end

NS_ASSUME_NONNULL_END
