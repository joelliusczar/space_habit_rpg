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
@property (assign, nonatomic) int32_t intervalSize;
@property (class, readonly, nonatomic) NSString *singularFormatString;
@property (class, readonly, nonatomic) NSString *pluralFormatString;
@property (readonly, nonatomic) NSString *intervalDescription;
@property (readonly, nonatomic) NSString *intervalLabelDescription;
+(NSString *)getFormatStringTypeForIntervalSize:(NSUInteger)intervalSize;
@end

NS_ASSUME_NONNULL_END
