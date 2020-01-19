//
//  SHRateItemProtocol.h
//  SHModels
//
//  Created by Joel Pridgen on 12/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SHRateItemProtocol <NSObject>
@property (assign, nonatomic) NSInteger intervalSize;
@property (readonly, nonatomic) NSString *singularFormatString;
@property (readonly, nonatomic) NSString *pluralFormatString;
@end

NS_ASSUME_NONNULL_END
