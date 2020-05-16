//
//  SHTestResourceUtil.h
//  SHTestCommon
//
//  Created by Joel Pridgen on 2/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHTestResourceUtil : NSObject<SHResourceUtilityProtocol>
@property (strong, nonatomic) SHResourceUtility *resourceUtil;
@property (strong, nonatomic) NSMutableDictionary	*mockFileSystem;
-(instancetype)initWithResourceUtil:(SHResourceUtility *)resourceUtil;
@end

NS_ASSUME_NONNULL_END
