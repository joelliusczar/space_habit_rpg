//
//  SHIntervalItemFormat.h
//  SHModels
//
//  Created by Joel Pridgen on 1/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface SHIntervalItemFormat : NSObject
@property (assign, nonatomic) NSInteger intervalSize;
@property (readonly, nonatomic) NSString *singularFormatString;
@property (readonly, nonatomic) NSString *pluralFormatString;
@end

NS_ASSUME_NONNULL_END
